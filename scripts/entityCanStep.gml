/// enemy_can_step()
/// returns true if the enemy can perform its normal step event this step
/// (i.e. not frozen, iced, paused, etc.)

return (!global.frozen && (!global.timeStopped || !stopOnFlash) && !dead && iceTimer <= 0);
