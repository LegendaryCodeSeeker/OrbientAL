class Q: #QM.N M is integer bits, N is fractional bits. M+N = full word size
	
	static func Decode(_Bytes, _M, _N):
		breakpoint
		
		if typeof(_Bytes) == 29:
			if (_Bytes.size())*8 == (_M + _N):
				pass
			else:
				printerr("Incorrect Bit Sizes Givin\nNumber Size: ", (_Bytes.size())*8, "\nM+N: ", (_M + _N))
				return ERR_PARAMETER_RANGE_ERROR
		else:
			printerr("Non Valid Input.\nExpected: ", type_string(29),".\nGot '", type_string(typeof(_Bytes)), "' Instead.")
			return ERR_INVALID_PARAMETER
			
		 #TODO convert to binary and convert to SDF same distance float.
		var BYTES = _Bytes.decode_s32(0)
		#bytes to string binary
		var INT_PART
		var FRA_PART
		var FRA_BITS
		var INT_BITS
		
		
		
	
	static func Encode(_N, _M, _S):
		pass
		
	
