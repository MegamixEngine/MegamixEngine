/// getTimeStamp([timezone])
// returns a pretty timestamp
// optional: provide a timezone. Default: timezone_utc.

var timezone = timezone_utc;
if (argument_count > 0)
{
    timezone = argument_count[1];
}

var preTZ = date_get_timezone();
date_set_timezone(timezone);
var str = "";
str += string(current_year) + "-";
str += string(current_month) + "-";
str += string(current_day) + " ";
str += string(current_hour) + ":";
str += string(current_minute) + ":";
str += string(current_second);

if (timezone == timezone_utc)
{
    str += " (UTC)";
}

date_set_timezone(preTZ);

return str;
