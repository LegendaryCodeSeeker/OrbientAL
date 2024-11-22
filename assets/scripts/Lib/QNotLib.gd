class QN: #QM.N M is integer bits, N is fractional bits. M+N = full word size
	
	static func Decode(_Bytes, _N, _M):
		var EMF = load("res://assets/scripts/Lib/EMF.gd").new()
		breakpoint
		if typeof(_Bytes) != TYPE_INT || TYPE_FLOAT || TYPE_PACKED_BYTE_ARRAY:
			printerr("Not a Valid Number Input.\nExpected One Of: TYPE_INT, TYPE_FLOAT, TYPE_PACKED_BYTE_ARRAY.\nGot '", typeof(_Bytes), "' Instead.")
			return ERR_INVALID_PARAMETER
		print(typeof(_Bytes))
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
		
	
