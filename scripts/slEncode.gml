/// slEncode(map,encode?)

//Secure saving is handled by the writing part.

if (global.sl_b64encode)
{//Encrypted data (Checkpoint saves).

    var jCode = json_encode(argument[0]);
    return base64_encode(jCode);
}
else
{//Unencrypted data.
    return json_encode(argument[0]);
}
