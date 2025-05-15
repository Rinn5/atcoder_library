class SegmentTree
  attr_reader :size, :tree

  def initialize(arr)
    @n = arr.size
    @size = 1 #木の深さ（ただし親は0とみる）
    @size = @size * 2 while @size < @n
    @tree = Array.new(@size * 2, -Float::INFINITY)
    # 1. 葉に代入（配列の値）
    arr.each_with_index do |val, i|
      @tree[@size + i] = val
    end

    # 2. 内部ノードを下から構築
    (@size - 1).downto(1) do |i|
      @tree[i] = [@tree[i * 2], @tree[i * 2 + 1]].max
    end
  end

  def 


end
