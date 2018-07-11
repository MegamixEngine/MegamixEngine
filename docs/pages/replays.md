# Action Replay System

## Overview

The Action Replay system allows for user input recording and playback. Here are some use cases:

- Players can record and share an Action Replay to show off their talent without having to use external recording software which can slow their computers and provide low-framerate or blurry playback.
- Demos can be played during the start menu
- In-level clipscenes can be authored with minimal programming
- Unit tests can run Action Replays to ensure code quality

## Usage

To begin recording, enter the debug menu (2) and select the recording button. There are then two options: "Record-Here" and "Record-Reset."
**Record-Reset** will restart the game from the last checkpoint to begin recording. It is the safer option and is more likely to give high-fidelity playback.
**Record-Here** will begin recording from the player's current co-ordinates -- however, on playback, all objects will be re-created and return to their original positions. This means
that it is only safe to use "record here" if the player is in a section which does not have any enemies, gimmicks, or pick-ups on screen and furthermore *would not* have any
such objects on screen if they were allowed to respawn.

In short, **Record-Reset** is the recommended option.

Once you have decided on a recording type, you must enter in a file. You can save this anywhere, but if you are using version
control, mind that you not save it in the repository unless you are sure you want it there. 

The recording file will be appended to every frame, so even if the game crashes during recording, the recording will still take.

To finish a recording, press pause again.

## Playback

From the room selector, select "Play Recording..." and select the file. Press pause to quit the recording early.

## Playback Failed? (Low-Fi)

The Action Replay recording file keeps track of the player's control inputs and dubs them in during playback.
The only other data saved in the recording is a minimal snapshot of the game when the recording begins. This snapshot
does not contain information such as the positions of enemies. This means there are a number of ways that the playback can desync from the original recording.

There are two probable causes of recording failures:
 - Randomness
 - Global data not stored in the recording.
 
 There are also other possibilities, such as:
 - Floating Point Errors
 
 ### Randomness
 
 It is forbidden to use the `randomize()` function at any time during a level, recording or no. It is also forbidden
 to use any kind of random function during the create event of an object. If that is needed, defer its use to the spawn event.
 Breaking either of these rules can result in low-fidelity playback.
 
 ### Global Data
 
 To fix, simply add this data to the save/load script for recordings.
 
 ### Floating-Point Error Accumulation
  
 The other possiblity is accumulating floating-point errors, however there is very little that can be done about this.
 This will only show up as a problem if the recording was created on a computer with a different architecture than yours,
 and it is still altogether unlikely to have a noticable effect.
 
