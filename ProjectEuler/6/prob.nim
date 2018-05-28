import math
proc sum_of_sq( r1, r2: int ): int =
  result = 0
  for i in r1 .. r2:
    result += i ^ 2

proc sq_of_sum( r1, r2: int ): int =
  result = 0
  for i in r1 .. r2:
    result += i
  result = result ^ 2


let diff = sq_of_sum( 1, 100 ) - sum_of_sq( 1, 100 )
echo diff
