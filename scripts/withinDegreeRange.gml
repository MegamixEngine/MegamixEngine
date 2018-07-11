/// withinDegreeRange(rangeStart, rangeStartInclusive, rangeEnd, rangeEndInclusive, angle);

// returns true if the angle is in the given range of angles, accounting for degree looping

_rangeStart = loopDegrees(argument[0]);
_rangeStartInclusive = argument[1];
_rangeEnd = loopDegrees(argument[2]);
_rangeEndInclusive = argument[3];
_angle = loopDegrees(argument[4]);

if (_rangeEnd < _rangeStart)
{
    _rangeEnd += 360;
    
    if (_angle < _rangeEnd && _angle < _rangeStart)
    {
        _angle += 360;
    }
}

return ((_rangeStartInclusive && _angle >= _rangeStart) || (!_rangeStartInclusive && _angle > _rangeStart))
    && ((_rangeEndInclusive && _angle <= _rangeEnd) || (!_rangeEndInclusive && _angle < _rangeEnd));
