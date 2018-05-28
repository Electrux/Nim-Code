type
  Node* = ref object of RootObj
    prev, next: Node
    data: string

  List* = ref object of RootObj
    starting, ending: Node
    count: int

proc addItem*( list: List, val: string ): int =
  if list.count == 0:
    list.starting = Node()
    list.starting.data = val
    list.ending = list.starting
  else:
    list.ending.next = Node()
    list.ending.next.prev = list.ending
    list.ending = list.ending.next

  list.ending.data = val
  list.count += 1
  result = list.count

proc delItem*( list: List, val: string ): int =
  if list.count == 0: return -1

  var itr = list.starting

  while itr != nil:
    if itr.data == val:
      break
    itr = itr.next

  if itr == nil: return -1

  if itr.prev != nil:
    itr.prev.next = itr.next
  if itr.next != nil:
    itr.next.prev = itr.prev

  itr = nil
  list.count -= 1
  result = list.count

proc getItem*( list: List, loc: int ): string =
  if loc < 0 or loc >= list.count: return ""
  var temp = list.starting
  for i in 0 ..< loc:
    temp = temp.next
  result = temp.data

iterator items*( list: List ): string =
  var itr = list.starting
  while itr != nil:
    yield itr.data
    itr = itr.next

iterator reversed*( list: List ): string =
  var itr = list.ending
  while itr != nil:
    yield itr.data
    itr = itr.prev

proc test() =
  var list: List = List( starting: nil, ending: nil, count: 0 )
  discard addItem( list, "hello" )
  discard addItem( list, "world" )
  echo "Items in the beginning are:"
  for elem in list.reversed:
    echo elem
  echo "Count on 2 additions: ", list.count

  discard delItem( list, "world" )
  echo "Count on 1 deletion: ", list.count

  assert( getItem( list, 0 ) == "hello", "Failed assertion for a location which should exist!" )
  assert( getItem( list, 1 ) == "", "Failed assertion for a location which should not exist!" )

if isMainModule:
  test()
