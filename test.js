function function_name(a, b) {
	if ((a^b) > (a-b) && a < 5) {
		a = 2 + 3 + b
		b = 1 + 1 + b
		return a - function_name(b, b)
	}
	a = 3 + 2 + a
	return a - b + 1
}

o = function_name(1, 2)
console.log(o)
