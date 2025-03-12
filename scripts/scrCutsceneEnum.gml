// This enum will list the "saveable" cutscenes in our game
// That is, cutscenes that will be recorded in the player's save file once they finish,
// making them only run once.
//
// So, as an example:
// - The cutscene before any Tier Boss wouldn't be included here,
//   as they can be re-triggered again & again.
// - The cutscene for when the game starts would count,
//   as it's only meant to be seen once

enum Cutscenes {
    // Example
    EXAMPLE = 0, // Plays when you start a new game
}

