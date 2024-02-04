Orbient:

	Header:
	first 8 bytes: 'signature'
	next 4 bytes: level width (float)
	next 4 bytes: level height (float)
	next 8 bytes: level creation date(64int unix time)
	next 4 bytes: level object count (unsigned int)
	next 4 bytes: buffer

	Object:
	next byte: ID (unsigned int)
	next byte: Type (unsigned int)
	Types:
		00 - Player
		01 - Star
		02 - Goal Star
		03 - Asteroid
		04 - Moon
		05 - Barycenter
		06 - Black Hole
	next byte: Orbit Target ID (unsigned int)
	next byte: Orbit Direction and Speed (unsigned int)
		00 - Motionless
		01 to 7F - Counter Clockwise (in this range 01 is slowest (still moving) and 7F is fastest)
		80 to FF - Clockwise (in this range 80 is fastest and FF is slowest (still moving))
	next 4 bytes: X Position Not Orbiting (float)
	next 4 bytes: Y Position Not Orbiting (float)
	next 4 bytes: Size (float)
		Size calculated like this:
			Floor(Size/25.0)
	next 4 bytes: Angle (float)
	next 4 bytes: Velocity (float)
	next 4 bytes: X Position Orbiting (float)
	next 4 bytes: Y Position Orbiting (float)
	
Astronomical Leap:
	TBD
