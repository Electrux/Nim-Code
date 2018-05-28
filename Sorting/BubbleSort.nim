proc bubble_sort( arr: var openarray[ int ] ) =
  for i in low( arr ) .. high( arr ):
    for j in low( arr ) .. high( arr ) - i - 1:
      if arr[ j ] > arr[ j + 1 ]:
        swap arr[ j ], arr[ j + 1 ]
  echo repr( arr )

var arr = @[ 5, 6, 2, 1, 3 ]

bubble_sort( arr )

echo repr( arr )
