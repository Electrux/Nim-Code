import math
var found = false

for i in 1 .. 1000:
  for j in i .. 1000:
    for k in j .. 1000:
      if ( ( i ^ 2 ) + ( j ^ 2 ) == k ^ 2 ) and i + j + k == 1000:
        echo i * j * k
        break
