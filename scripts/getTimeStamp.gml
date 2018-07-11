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
var date = date_current_datetime();
var str = "";
str += string(date_get_year(date)) + "-";
str += string(date_get_month(date)) + "-";
str += string(date_get_day(date)) + " ";
str += string(date_get_hour(date)) + ":";
str += string(date_get_minute(date)) + ":";
str += string(date_get_second(date));

if (timezone == timezone_utc)
{
    str += " (UTC)";
}

date_set_timezone(preTZ);

return str;
