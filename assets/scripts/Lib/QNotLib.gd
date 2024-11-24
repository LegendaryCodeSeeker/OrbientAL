class Q: #QM.N M is integer bits, N is fractional bits. M+N = full word size
	
	static func Decode(_Bytes, _M, _N):
		breakpoint
		
		if typeof(_Bytes) == 29:
			if (_Bytes.size())*8 == (_M + _N):
				pass
			else:
				printerr("Incorrect Sizes Givin\nNumber: ", (_Bytes.size())*8, "\nM+N: ", (_M + _N))
				return ERR_PARAMETER_RANGE_ERROR
		else:
			printerr("Non Valid Input.\nExpected: ", type_string(29),".\nGot '", type_string(typeof(_Bytes)), "' Instead.")
			return ERR_INVALID_PARAMETER
			
		
		var EMF = load("res://assets/scripts/Lib/EMF.gd").new()
		var INT_PART
		var FRA_PART
		var FRA_BYTE = _Bytes
		var INT_BYTE = _Bytes
		
		INT_PART = INT_BYTE >> _N #masking Fractional part to get Integer
		for i in _N: #masking Integer part to get Fractional
			FRA_BYTE = FRA_BYTE & 0b1
			FRA_BYTE = FRA_BYTE >> 1
		FRA_BYTE = FRA_BYTE << _N
		
	
	static func Encode(_N, _M, _S):
		pass
		
	
