Orbient:

	Header:
	first 8 bytes: 'signature'
	next 4 bytes: level width (float)
	next 4 bytes: level height (float)
	next 8 bytes: level creation date(64int unix time)
	next 4 bytes: level object count (unsigned int)
	next 4 bytes: buffer(signature 2)

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
	next byte: Orbit Step (signed int)
	next 4 bytes: X Position (float)
	next 4 bytes: Y Position (float)
	next 4 bytes: Size (float)
		Size calculated like this?:
			Floor(Size/25.0)
	next 4 bytes: Angle (float)
	next 4 bytes: Velocity (float)
	next 4 bytes: ??? (float?)
	next 4 bytes: ??? (float?)
	
Astronomical Leap:
	TBD
