/// enemy_can_step()
/// returns true if the enemy can perform its normal step event this step
/// (i.e. not frozen, iced, paused, etc.)

if (!global.frozen && !frozen) //Game frozen?
{
    if (!dead) //Alive?
    {
        if ((!global.timeStopped || !stopOnFlash) && iceTimer <= 0) //Time-stopped / iced?
        {
            return (true);
        }
    }
}

return (false);

