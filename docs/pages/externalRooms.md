# External Room Loading

## Overview

A huge issue encountered during the development of MaGMML2 was the problem that the GMS 1.4 IDE takes a very long time
to load and save a project with rooms containing many objects and tiles. This is because the IDE validates each object and
tile in the room every time the project is loaded and saved. Notably, the number and dimensions of the rooms don't contribute
significantly to the loading times -- only the number of objects and tiles in the room.

To try to reduce loading and saving times, a system was devised wherin the room file can be stored in the *external data* asset
folder rather than the *Rooms* asset folder. The rooms are then loaded from the game during runtime, rather than during compile
time or during IDE load/save time.

## Disadvantages

There are four main drawbacks to using external room loading.

The first is that the room cannot be edited within the Game Maker IDE unless
it is returned to the Rooms asset folder, which is inconvenient because it takes a minute or two to do so.

The next main drawback
is that the room must be loaded during runtime, which can briefly cause the game to lag if a very large room is loaded. The 
developer may choose to load the room at any point prior to the player entering the room, including the frame before or during
the game's startup.

The third problem is that creation code in the room will now be executed using `string_execute_partial`, which has its own complications, and
is missing some functionality. Read the documentation for `string_execute_partial` to find out more.

Finally, there is a potential security risk where hackers can replace the room file with their own malicious one. See the
"Security Risks" section below for a way to prevent this.

## How to make a room externally loaded

From the resources menu bar, or by right clicking in the external data part of the resource tree, add a new external data file.
In the file select dialogue, navigate to the `rooms/` folder for your project on your hard-drive. Select the `.room.gmx` file
corresponding to the room you wish to make externally loaded. Then place the `.room.gmx` file anywhere you wish in the external
data files asset tree. Finally, delete this room in the the Rooms asset folder so that it does not appear in two places.

To access the external room in the game, use the script `room_external_load(filename)`, which takes as input the path to the room
file to load externally relative to the external data files asset folder.
You should drop the `.room.gmx` extension from the filename. For example, if you placed `lvlMyLevel.room.gmx` in `Levels/`
sub-folder of the external data files asset folder, then you should do `room_external_load("Levels/lvlMyLevel")`. This
function returns the ID for the loaded room, which can then be used anywhere you'd normally put the room's ID directly in code.

For example, where in a teleporter you might have previously done this:

```
// Teleporter Creation Code -- Internally-loaded room
Room = lvlMyLevel;
```

You should now do this:

```
// Teleporter Creation Code -- Externally-loaded room
Room = room_external_load("Levels/lvlMyLevel");
```

Note that the room is cached for subsequent loads, so it will only load the room the first time
the `room_external_load` script is called. If you desire to re-load the room (for example, if you intend
to edit the room file during runtime), then use `room_external_clear` to clear the cache.

## How to restore an Externally-Loaded room to be Interally-Loaded

Open the `datafiles/` folder of your project on your hard drive and locate the `.room.gmx` file, then drag it
into game maker. This will prompt you to import the room. After it is imported, delete the version that's in 
the external data files asset folder. Be sure to delete the external data file from within the Game Maker IDE,
not through your normal file browser.

Don't forget to replace instances of `room_external_load("Levels/lvlMyLevel")` with `lvlMyLevel`, etc.

## Security risks

It's fairly simple for a hacker to edit the game's external data files and replace `lvlMyLevel` with their
own malicious level. This is especially problematic due to the use of `string_execute_partial` to run creation
code in the room. Fortunately, there is a security feature in place to obstruct this, if you desire, called *hashing*.

Any text data has a corresponding [md5 hash](http://www.miraclesalad.com/webtools/md5.php), including the `.room.gmx` file. When
a room is loaded externally, the hash of the file is printed out to the console in GMS. Copy this value and add it as a second
argument to the `room_load_external()` script. Now a hacker cannot edit the `.room.gmx` file without also inadvertently editing
its md5 hash. The game will throw an error if it tries to load an external room and the hash is incorrect.

For example, here is a secure way to have a teleporter pointed at an externally-loaded room.

```
// Teleporter Creation Code -- Externally-loaded room, secure version
Room = room_external_load("Levels/lvlMyLevel", "43ec517d68b6edd3015b3edc9a11367b");
```

Note that the hash check is only checked the first time the script is called. After that, the externally-loaded room is cached.
