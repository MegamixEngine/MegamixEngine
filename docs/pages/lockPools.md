# Lock Pools

## Purpose

In many circumstances, the player's controls are intended to become unresponsive. For example, when the player gets stunned, or enters a boss chamber, or talks to an NPC, or uses certain utilities. In previous versions of the engine, the controls status were decided by variables such as `canHit`, `canMove`, `canStep`, etc.

One of several flaws with the previous system was that multiple control locks could not stack. For example, if one object locked up the player's controls, and then a second object locked them, the first object could unlock the controls and then the player would be able to move despite the fact that the second object still intended for the player to have their controls locked.

Lock Pools allow multiple sources of locks to stack together and independently lock/unlock the player's controls. Other systems can also use lock pools. `global.frozen` may eventually be replace with a lock pool.

## Overview

Each state that can be locked or unlocked independently (such as the player's ability to move, jump, shoot, etc.) is assigned a *Lock Pool*. A pool or set of pools can be locked by invoking `lockPoolLock()`, which returns the value of a *lock*. To unlock, this same *lock* value must later be returned (or *released*) when the the pool is to be unlocked. A lock is said to be *checked out* when it has not yet been returned. A pool is *unlocked* when there are no currently checked-out locks. As a convenience feature, multiple lock pools may be locked simultaneously, returning a single shared lock among them.

Lock Pools also make use of assert statements to ensure that they are used properly. If a lock pool is misused -- for example, if a checked-out lock is returnred more than once -- then the game crashes with a helpful error message. This is intentional and is designed to force the programmer to not write code with latent unnoticed bugs.

## Interface

| Script                                | Arguments                                                                      | Return Value                | Description
|---------------------------------------|--------------------------------------------------------------------------------|-----------------------------|-----------
| `lockPoolInit()`                      |                                                                                |                             | Sets up the lock pool system. Should be called once at the beginning of the game.
| `lockPoolNew()`                       |                                                                                | returns the lock pool ID.   | Creates a new lock pool, returning its ID for later use (much like data structures in GML).
| `lockPoolDestroy(pool)`               | `pool`: the lock pool to destroy.                                              | deletes the given pool.     | This is used to free up resource. ~~If there are any currently checked-out locks on the pool when it is destroyed, then it will be marked with a tombstone and the resource will only be freed when all locks are returned. Locks expire automatically on tombstoned pools when a room ends, after which returning the lock could cause undefined behaviour.~~*
| `lockPoolLock(pools...)`              | `pools...`: the pool or set of pools to lock.                                  | the checked-out lock.       | Locks the given lock pool until all checked-out locks are returned.
| `lockPoolRelease([pools...], lock)`   | `[pools...]`: an optional list of pool IDs. `lock`: a checked-out `lock`.      | returns the value `0`.      | Releases the given lock. The game wil crash if the `lock` value supplied is not a checked-out lock, so **never return the same lock twice**. As a convenience feature, if the value `0` is passed into the the `lock` argument, then nothing will occur. Since `0` is also returned by the lock, a typical usage will look like `lock = lockPoolRelease(lock)`. Running this line multiple times in a row will not cause a crash, whereas `lockPoolRelease(lock)` is liable to. If a list of lock pools is supplied, then the script will assert that the lock is checked out on all the given lock pools and no others, crashing the game if it is not the case. This is helpful to ensure that the lock pool system is never misused.
| `lockPoolReleaseAll(pools...)`        | `pools...`: the list of pools to release all locks on.                         |                             | Releases all checked-out locks on the given pool. No currently checked-out locks should be returned after this, or the game will crash. As a result, **this function should not be used** except in circumstances where it is possible to guarantee that no lock will ever be returned to the given pools again.
| `lockPoolExists(pool)`                | `pool`: a lock pool ID.                                                        | `true` or `false`           | Returns `true` if the given lock pool exists (has not been destroyed). ~~Tombstoned lock pools still exist.~~*
| `isLocked(pools...)`                  | `pools...`: a list of lock pools.                                              | `true` or `false`           | Returns `true` if any of the given pools are locked, and `false` if none of them are.

* Tombstones are not yet implemented.

## Example

The following code creates two lock pools, checks out three locks including one on both pools, and then returns all three of them. It then destroys the lock pool, freeing the resource.

```
// create lock pools
lockPoolA = lockPoolNew();
lockPoolB = lockPoolNew();

print(isLocked(lockPoolA)); // false
print(isLocked(lockPoolB)); // false
print(isLocked(lockPoolA, lockPoolA)); // false

// check out some locks
lockA = lockPoolLock(lockPoolA);

print(isLocked(lockPoolA)); // true
print(isLocked(lockPoolB)); // false
print(isLocked(lockPoolA, lockPoolA)); // true

lockB  = lockPoolLock(lockPoolB);
lockAB = lockPoolLock(lockPoolA, lockPoolB);

print(isLocked(lockPoolA)); // true
print(isLocked(lockPoolB)); // true
print(isLocked(lockPoolA, lockPoolA)); // true

// return one lock
lockA = lockPoolRelease(lockPoolA);

// lockPoolA is still locked due toe lockAB being checked out
print(isLocked(lockPoolA)); // true

// release all locks
lockB = lockPoolRelease(lockPoolB, lockB); // specifying lockPoolB is optional
lockB = lockPoolRelease(lockB); // because lockB has the value 0, this does nothing
lockAB = lockPoolRelease(lockAB);

print(isLocked(lockPoolA)); // false
print(isLocked(lockPoolB)); // false
print(isLocked(lockPoolA, lockPoolA)); // false

// destroy lock pools
lockPoolDestroy(lockPoolA);
lockPoolDestroy(lockPoolB);
lockPoolDestroy(lockPoolC);
```

## Commonly-used lock pools

Here are a list of lock pools and their descriptions. Note that the player control locks have both a
global and an instance version. The instance version allows locking the controls for a single instance
of `objMegaman` (e.g. if one `objMegaman` instance is caught in a honey pool and the other isn't).
The `global` version locks the controls for all `objMegaman` instances, which is useful for cutscenes.

| Name                                     | Owner                   | Description
|------------------------------------------|-------------------------|-------------
| `global.timeStopped`                     |                         | Is time stopped for enemies?
| `global.playerFrozen`                    |                         | Is time stopped for the players?
| `localPlayerLock[PL_LOCK_MOVE]`          | objMegaman              | Can the player walk horizontally or move in the air horizontally? This is *not* a master lock; one can lock this form of movement but still allow jumping and climbing and sliding.
| `localPlayerLock[PL_LOCK_PHYSICS]`       | objMegaman              | (deprecated?)
| `localPlayerLock[PL_LOCK_TURN]`          | objMegaman              | Can the player turn around? (Does not affect turning while sliding)
| `localPlayerLock[PL_LOCK_GRAVITY]`       | objMegaman              | Does the player experience gravity?
| `localPlayerLock[PL_LOCK_SHOOT]`         | objMegaman              | Can the player shoot?
| `localPlayerLock[PL_LOCK_SLIDE]`         | objMegaman              | Can the player slide?
| `localPlayerLock[PL_LOCK_PAUSE]`         | objMegaman              | Can the player pause? (Also currently used for interaction with NPCs, but this may be refactored.)
| `localPlayerLock[PL_LOCK_CLIMB]`         | objMegaman              | Can the player climb ladders?
| `localPlayerLock[PL_LOCK_JUMP]`          | objMegaman              | Can the player jump?
| `localPlayerLock[PL_LOCK_CHARGE]`        | objMegaman              | Can the player charge their weapon?
| `localPlayerLock[PL_LOCK_SPRITECHANGE]`  | objMegaman              | Can the player change sprites?
| `global.playerLock[...]`                 |                         | All the same as above, but global versions.
| `global.playerLock[PL_LOCK_SPAWN]`       |                         | Can players respawn currently? (Co-op). This is meaningless for individual instances of objMegaman because they are already spawned.
| `PL_LOCK_MAX`                            |                         | **This is not a lock pool**, but if you want to add more lock pool `PL_LOCK` constants to the player lock system then make sure that this value is greater than all the other `PL_LOCK_` constants.

## Convenience scripts

It is a bit of a pain to type out `isLocked(localPlayerLock[PL_LOCK_MOVE], localPlayerLock[PL_LOCK_JUMP]) || isLocked(global.playerLock[PL_LOCK_MOVE], global.playerLock[PL_LOCK_JUMP])`, so the script `playerIsLocked()` is provided. This can be used like `playerIsLocked(PL_LOCK_MOVE, PL_LOCK_JUMP)`.
