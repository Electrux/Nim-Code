proc fib_sum( maxi: int ): int =
  var
    i1 = 1
    i2 = 2

  while i2 <= 4_000_000:
    if i2 mod 2 == 0:
      result += i2
    let temp = i1 + i2
    i1 = i2
    i2 = temp

echo "Sum: ", fib_sum( 20 )
