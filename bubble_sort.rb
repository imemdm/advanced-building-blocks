def bubble_sort arr
  swapped = true
  n = arr.length - 1
  until !swapped
    swapped = false

    for i in (1..n)
      if arr[i-1] > arr[i]
        arr[i-1], arr[i] = arr[i], arr[i-1]
        swapped = true
      end
    end
    n = n - 1
  end
  arr
end

p bubble_sort([4,3,78,2,0,2])

def bubble_sort_by arr
  swapped = true
  n = arr.length - 1
  until !swapped
    swapped = false

    for i in (1..n)
      if yield(arr[i-1], arr[i]) > 0
        arr[i-1], arr[i] = arr[i], arr[i-1]
        swapped = true
      end
    end
    n = n - 1
  end
  arr
end

result = bubble_sort_by(["hi","hello","hey"]) do |left, right|
  left.length - right.length
end

p result