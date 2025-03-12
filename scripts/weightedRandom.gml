/// weightedRandom(value, weight, ...)
// A function to return a random value from a given set,
// with weights given to each possible value to make them either more or less likely.
// Think of if as an alternative to using the 'choose' function
//
// This script expects pairs of arguments, consisitng of a possible value & its corresponding weight
//
// e.g. weightedRandom("a", 1, "b", 2, "c", 3);
// [value: "a", weight: 1]
// [value: "b", weight: 2]
// [value: "c", weight: 3]

assert(argument_count > 0 && !(argument_count & 1), "An odd number of arguments was supplied to weightedRandom. Use even arguments only! Each value needs a corresponding weight");

var length = argument_count * 0.5,
    accumulator = 0,
    cumulative_weights = array_create(length);

// Go through the argument list for the weights
for (var i = 0; i < length; i++) {
    accumulator += max(argument[(i * 2) + 1], 0);
    cumulative_weights[i] = accumulator;
}

// Now generate a random number
// & pick a value based on that number
var rand = random(accumulator);

for (var i = 0; i < length; i++) {
    if (rand <= cumulative_weights[i] && argument[(i * 2) + 1] > 0)
        return argument[i * 2];
}

// Fallback return
show_debug_message("weightedRandom failed to get a random value. Defaulting to the first given value...");
return argument[0];
