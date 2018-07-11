/// recordInputFidelityMessage(message)
/// if input is recording, submits this message into the recording.
/// on playback, if the same message is not received, an error will occur.

global.recordInputFidelityMessageBuffer += "{" + string(argument0) + "}";
