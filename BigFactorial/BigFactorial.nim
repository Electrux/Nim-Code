from strutils import parseInt
import bignum

var facto_end = parseInt( readLine( stdin ) )

var res = newInt( 1 )

while facto_end > 1:
  res *= facto_end
  facto_end -= 1

echo "Result: ", $res
