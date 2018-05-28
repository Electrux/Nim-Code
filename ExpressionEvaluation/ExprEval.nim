import strutils, sequtils
import math
import tables
import bignum
import Stack

let SymPriority = {
  "(": -2,
  ")": -1,
  "+": 0,
  "-": 0,
  "*": 1,
  "/": 1,
  "%": 1,
  "^": 2,
}.toTable

let Symbols = [ "(", ")", "+", "-", "*", "/", "%", "^" ]

type InvalidSyntaxException = object of Exception

# idk why bignum does not contain power which takes BOTH parameters as Ints
# so here is my own function for that ( just wraps around multiple mulitiplications
proc pow( x, y: Int ): Int =
  if y == 0:
    return newInt( 1 )
  if x == 0:
    return newInt( 0 )
  result = x
  for i in 1 .. y:
    result *= i

proc contains( str: string, list: openarray[ string ] ): bool =
  for item in list:
    if str == item:
      return true
  false

proc gen_postfix( syms: openarray[ string ] ): seq[ string ] =
  var stack = createStack[ string ]()

  for item in syms:
    if item.contains( Symbols ):
      while not stack.isEmpty() and SymPriority[ item ] <= SymPriority[ stack.getTop() ] and item != "(":
        result.add( stack.pop() )
      if item == ")":
        if stack.isEmpty():
          raise newException( InvalidSyntaxException, "Found a closing parenthesis but there was no opening parenthesis to close!" )
        stack.popDiscard()
        continue
      stack.push( item )
    else:
      result.add( item )

  while not stack.isEmpty():
    result.add( stack.pop() )

proc eval_postfix( syms: openarray[ string ] ): Int =
  var res_stack = createStack[ string ]()

  for item in syms:
    if item.contains( Symbols ):
      if res_stack.size() < 2:
        raise newException( InvalidSyntaxException, "Found operator without there being operands to evaluate on, operand count is: " & $res_stack.size() )
      let b = newInt( res_stack.pop() )
      let a = newInt( res_stack.pop() )
      case item
      of "+": res_stack.push( $( a + b ) )
      of "-": res_stack.push( $( a - b ) )
      of "*": res_stack.push( $( a * b ) )
      of "/": res_stack.push( $( a div b ) )
      of "%": res_stack.push( $( a mod b ) )
      of "^": res_stack.push( $( pow( a, b ) ) )
      else:
        raise newException( InvalidSyntaxException, "Found invalid operator: " & item )
      continue
    res_stack.push( item )
  result = newInt( res_stack.pop() )

proc get_symbols( str: string ): seq[ string ] =
  var tmpstr = ""
  for ch in str:
    case ch
    of ' ', '(', ')', '+', '-', '*', '/', '%', '^':
      if tmpstr != "":
        result.add( tmpstr )
        tmpstr = ""
      if ch != ' ':
        result.add( $ch )
    else:
      tmpstr &= $ch
  if tmpstr != "":
    result.add( tmpstr )

  # this does not handle no spaces between values :( tokenize only works with separators
  # toSeq( str.tokenize ).filterIt( not it.isSep ).mapIt( it.token )

when isMainModule:
  let syms = readLine( stdin ).get_symbols()

  let postfix = gen_postfix( syms )
  echo "Postfix: ", $postfix
  echo "Result: ", eval_postfix( postfix )
