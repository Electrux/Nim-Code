import math

var i = 1
var ctr = 0

proc is_prime( i: int ): bool =
  let sq_rt = int( sqrt( float( i ) ) )
  result = true
  for j in 2 .. sq_rt:
    if i mod j == 0:
      result = false
      break

while ctr != 10001:
  i += 1
  if is_prime( i ):
    ctr += 1

echo i
