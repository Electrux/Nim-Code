import strutils
proc rev( str: string ): string =
  result = newString( str.len )
  for i in 0 .. str.high:
    result[ i ] = str[ str.high - i ]

var maxi = 0
for i in 100 .. 999:
  for j in 100 .. 999:
    let val = ( i * j ).intToStr
    if val == rev( val ) and maxi < val.parseInt:
      maxi = val.parseInt

echo "max:  ", maxi
