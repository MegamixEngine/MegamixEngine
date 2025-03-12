/// applyRumble(playerID,priority,initial,dampen,timeInFrames,[initialRight],[dampenRight],[timeInFramesRight])

//Applies rumble to a player's controller, assuming the player ID corresponds to a controller (and said controller supports rumble in the first place).
//Higher priority will override lower or equal priorities.

//Initial is what percentage of power the rumble should start at, range between 0 and 1.
//Dampen is for how much to dampen the rumble over time (*or* raise it. Sine wave-like movement is not supported natively). Should not be 0, otherwise the motor won't actually move!
//timeInFrames  is the end-all time the rumble will end by (Minimum of 1 frame).

//The [Right] arguments above corresponds to dual-motor support. If specified, argument 2, 3 & 4 will correspond to the left motor,
//otherwise, it will correspond to both left and right.

with (objGlobalControl)
{
    var pID = argument[0];
    var cID = controllerID[pID];
    
    var priority = argument[1];
    
    //0 = left | 1 = right
    initial = makeArray(argument[2], argument[2]);
    dampen  = makeArray(argument[3], argument[3]);
    time    = makeArray(argument[4], argument[4]);
    
    //right
    if (argument_count > 5)
    {
        initial[1] = argument[5];
        dampen[ 1] = argument[6];
        time[   1] = argument[7];
    }
    
    //Apply rumble
    if (cID >= 0)
    {
        if (rumblePriority[cID] <= priority)
        {
            rumblePriority[cID] = priority;
            
            var i = (cID * 2);
            var ii = 0;
            
            //Two cycles | one for each motor
            repeat(2)
            {
                //Apply dampen in reverse since the decrement in global control will remove it later.
                rumbleCurrent[i] = (initial[ii] - dampen[ii]);
                rumbleDampenAmount[i] = dampen[ii];
                rumbleTimers[i] = max(1, time[ii]);
                
                i ++;
                ii ++;
            }
        }
    }
}

