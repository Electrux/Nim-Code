import math

proc is_prime( i: int ): bool =
  let sq_rt = int( sqrt( float( i ) ) )
  result = true
  for j in 2 .. sq_rt:
    if i mod j == 0:
      result = false
      break

var sum = 0
for i in 2 ..< 2_000_000:
  if is_prime( i ):
    sum += i

echo sum
