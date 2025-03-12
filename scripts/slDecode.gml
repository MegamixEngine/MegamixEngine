/// slDecode(string)


if (global.sl_b64encode)
{//Encrypted data (Checkpoint saves).

    var jMap = base64_decode(argument[0]);
    return json_decode(jMap);
}
else
{//Unencrypted data.
    return json_decode(argument[0]);
}
