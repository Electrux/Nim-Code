var i = 20

var found = false
while not found:
  var check = true
  for j in 2 .. 20:
    if i mod j != 0:
      check = false
      break

  if check:
    break

  i += 20

echo "Number: ", i
