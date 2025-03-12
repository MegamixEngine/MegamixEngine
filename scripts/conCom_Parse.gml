/// conCom_Parse
/*Shortcut to add */

if (string_count("~",argument[0]) % 2)
{
    print("Odd number of tildes. Command cancelled.",WL_SHOW,c_white,true);
    return "";
}

hashSep = stringSplit_Proper(argument[0],"~",false);



var sepComs = makeArray('','conCom("','");');

finalBuild = "";
var i = 0;
while (i < array_length_1d(hashSep))
{
    finalBuild += sepComs[i%3];
    finalBuild += hashSep[i];
    i++;
}
return finalBuild;
