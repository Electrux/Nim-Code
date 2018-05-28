import sequtils

type
  StackEmptyException = object of Exception

  Stack*[ T ] = ref object of RootObj
    data: seq[ T ]
    top: int

proc createStack*[ T ](): Stack[ T ] =
  result = Stack[ T ]()
  result.top = -1

proc push*[ T ]( stack: Stack[ T ], data: T ) =
  stack.data.add( data )
  stack.top += 1

proc pop*[ T ]( stack: Stack[ T ] ): T =
  if stack.top < 0:
    raise newException( StackEmptyException, "Stack is empty!" )
  stack.top -= 1
  result = stack.data[ stack.top + 1 ]
  stack.data.delete( stack.top + 1 )

proc popDiscard*[ T ]( stack: Stack[ T ] ) =
  if stack.top < 0:
    return
  stack.top -= 1
  stack.data.delete( stack.top + 1 )

proc get*[ T ]( stack: Stack[ T ], loc: int ): T =
  if stack.top < 0:
    raise newException( StackEmptyException, "Stack is empty!" )
  if loc < 0 or loc > stack.top:
    raise newException( StackEmptyException, "Location to access is out of bounds" )
  stack.data[ loc ]

proc getTop*[ T ]( stack: Stack[ T ] ): T =
  if stack.top < 0:
    raise newException( StackEmptyException, "Stack is empty!" )
  stack.data[ stack.top ]

proc size*[ T ]( stack: Stack[ T ] ): int =
  stack.top + 1

proc isEmpty*[ T ]( stack: Stack[ T ] ): bool =
  stack.top < 0

when isMainModule:
  var stack = createStack[ int ]()
  stack.push( 1 )
  assert stack.get( 0 ) == 1
  try:
    echo stack.get( 2 )
  except:
    let e = getCurrentException()
    let emsg = getCurrentExceptionMsg()
    echo "Exception: " & repr( e ) & emsg

  stack.push( 3 )
  echo repr stack
  assert stack.pop() == 3
  assert stack.size() == 1
  assert stack.getTop() == 1
  assert stack.pop() == 1
  assert stack.isEmpty() == true
  try:
    echo stack.pop()
  except StackEmptyException:
    let e = getCurrentException()
    let emsg = getCurrentExceptionMsg()
    echo "Exception: " & repr( e ) & emsg
  finally:
    echo "oh well.."
