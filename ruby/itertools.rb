def run_length_encoding(arr)
  result = Array.new
  current = arr.first
  cnt = 1
  arr[1..].each do |ele|
    if ele == current then
      cnt += 1
    else
      result << "#{current}#{cnt}"
      current = ele
      cnt = 1
    end
  end
  result << "#{current}#{cnt}"
  return result
end