/// mm_printManager

printErr("DEPRECATED (It crashes)");
exit;
print("Memory Manager Output Start");
var eventNums = makeArray(ev_create,ev_destroy,ev_step,ev_alarm,ev_keyboard,ev_keypress,ev_keyrelease,
ev_mouse,ev_collision,ev_other,ev_draw);

var eventNames = makeArray("Create","Destroy","Step","Alarm","Keyboard","KeyPress","KeyRelease","Mouse","Collision","Other","Draw");

var a = ev_step;

var eventNums_Sub = -1;
var eventNames_Sub = -1;

eventNums_Sub[indexOf(eventNums,a)] = makeArray(ev_step_normal,ev_step_begin,ev_step_end);

eventNames_Sub[indexOf(eventNums,a)] = makeArray("Step Normal","Step Begin", "Step End");

a = ev_alarm;

eventNums_Sub[indexOf(eventNums,a)] = makeArray(0,1,2,3,4,5,6,7,8,9,10,11);

eventNames_Sub[indexOf(eventNums,a)] = makeArray("0","1","2","3","4","5","6","7","8","9","10","11");


a = ev_mouse;

eventNums_Sub[indexOf(eventNums,a)] = makeArray(ev_left_button,ev_right_button,ev_middle_button,
ev_no_button,ev_left_press,ev_right_press,ev_middle_press,
ev_left_release,ev_right_release,ev_middle_release,ev_mouse_enter,
ev_mouse_leave,ev_mouse_wheel_up,ev_mouse_wheel_down,ev_global_left_button,
ev_global_right_button,ev_global_middle_button,ev_global_left_press,
ev_global_right_press,ev_global_middle_press,ev_global_left_release,
ev_global_right_release,ev_global_middle_release);
eventNames_Sub[indexOf(eventNums,a)] = makeArray("Left","Right","Middle","No Button",
"Left Press","Right Press", "Middle Press","Left Release","Right Release", "Middle Release",
"Mouse Enter","Mouse Leave","Mouse Wheel Up","Mouse Wheel Down","Left Button (Global)",
"Right Button (Global)","Middle Button (Global)","Left Press (Global)","Right Press (Global)", 
"Middle Press (Global)","Left Release (Global)","Right Release (Global)", "Middle Release (Global)");

a = ev_collision;

eventNums_Sub[indexOf(eventNums,a)] = array_create(0);
eventNames_Sub[indexOf(eventNums,a)] = array_create(0);

a = ev_other;

eventNums_Sub[indexOf(eventNums,a)] = makeArray(ev_outside,ev_boundary,ev_game_start,
ev_game_end,ev_room_start,ev_room_end,ev_no_more_lives,ev_no_more_health,ev_animation_end,
ev_end_of_path,ev_user0,ev_user1,ev_user2,ev_user3,ev_user4,ev_user5,ev_user6,ev_user7,ev_user8,
ev_user9,ev_user10,ev_user11,ev_user12,ev_user13,ev_user14,ev_user15);
var uE = 0;
eventNames_Sub[indexOf(eventNums,a)] = makeArray("Outside Room","Boundary Intersect","Game Start","Game End","Room Start","Room End","No More Lives","No More Health","Animation End","End of Path","User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++),"User " + string(uE++));

a = ev_draw;

eventNums_Sub[indexOf(eventNums,a)] = makeArray(ev_draw_begin,ev_draw_end,ev_draw_pre,ev_draw_post,ev_gui,ev_gui_begin,ev_gui_end);
eventNames_Sub[indexOf(eventNums,a)] = makeArray("Draw Begin","Draw End","Draw Pre","Draw Post","Draw GUI","Draw GUI Begin", "Draw GUI End");


//= {ev_step_normal,ev_step_begin,ev_step_end,};

var key = ds_map_find_first(global.memoryManager);
var totalOut = "";
var typeNames = makeArray("list","map","grid","surface");
if (key != "")
for (var i = 0; i < ds_map_size(global.memoryManager); i++)
{
    if (is_undefined(key))
    {
        i = ds_map_size(global.memoryManager);
        break;
    }
    var output = ds_map_find_value(global.memoryManager,key);
    
    
    var eName = "Unknown ID" + string(output[3]);
    var eNameSub = "Unknown SubID" + string(output[4]);
    var eIndex = indexOf(eventNums,output[3]);
    if (eIndex >= 0)
    {
        eName = eventNames[eIndex];
        var eIndexSub = indexOf(eventNums_Sub[eIndex],output[4]);
        if (eIndexSub >= 0)
        {
            eNameSub = eventNames_Sub[eIndexSub];
        }
    }
    
    //show_message(string(output));
    var outString = "{" + string(output[0]) + "," + typeNames[output[1]] + "," + output[2] + "," + eName + "," + eNameSub + "," + string(output[5]) + "}";
    print(key + ": " + outString);//string(output));
    
    if (i < ds_map_size(global.memoryManager)-1)
    {
        key = ds_map_find_next(global.memoryManager,key);
    }
    totalOut += outString + "#";
    
}
if (DEBUG_ENABLED && global.keyMap[0])
{
    clipboard_set_text(totalOut);
    playSFX(sfxTetrisTetris);//Heheheh funni jingle
}
print("Memory Manager Output End");
