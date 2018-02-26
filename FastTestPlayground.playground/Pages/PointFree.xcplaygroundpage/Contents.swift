import Foundation

// *********************************************************************
// MARK: - Episode 1

// Option 1

incr(2)
square(incr(2))

// Option 2

2.incr()
2.incr().square()

// Option 3

2 |> incr
2 |> incr |> square

incr >>> square
square >>> incr

(incr >>> square)(2)

2 |> incr >>> square

2.incrAndSquare()

2 |> incr >>> square >>> String.init

[1, 2, 3]
	.map(incr)
	.map(square)
	.map(String.init)

[1, 2, 3]
	.map(incr >>> square >>> String.init)
