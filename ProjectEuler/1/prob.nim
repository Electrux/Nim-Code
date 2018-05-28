var sum = 0

for i in 1 ..< 1000:
  if i mod 3 == 0 or i mod 5 == 0:
    sum += i

echo "Sum of all numbers divisible by either 3 or 5 between 1 and 1000 is: ", sum
