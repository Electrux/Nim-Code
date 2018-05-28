proc largest_prime_factor( num: int64 ): int64 =
  var found_new = true
  result = num
  while found_new == true:
    found_new = false
    for i in 2 ..< result:
      if result mod i == 0:
        result = result div i
        found_new = true
        break

echo "Largest prime factor of 600851475143 = ", largest_prime_factor( 600851475143 )
