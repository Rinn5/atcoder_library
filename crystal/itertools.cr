def run_length_encoding(arr : Array)
  result = [] of String
  current = arr.first
  cnt = 1
  arr[1..].each do |ele|
    if ele == current
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