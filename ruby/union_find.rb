# UnionFind / disjoint set union
# グラフにおいて、特定の2点が複数の線経由でつながっているか？を考えるときに使うことを考える。
# 経路圧縮済み

class UnionFind
  def initialize(n)
    @parent = Array.new(n) {|i| i} # 要素 i の親（代表元）
    @size = Array.new(n, 1) # i を根とする木のサイズ
  end
  
  def size_array
    @size
  end
  
  def parent_array
    @parent
  end

  # 根の番号を返す
  def find(x)
    @parent[x] = find(@parent[x]) if x != @parent[x]
    @parent[x]
  end

  def unite(x, y)
    x_root = find(x)
    y_root = find(y)
    return if x_root == y_root #もし根が同じであればもうuniteされているのでスキップ

    # 常に大きい数字に小さい数字を統合.x_rootの方を大きくする。
    if @size[x_root] < @size[y_root]
      x_root, y_root = y_root, x_root
    end

    @parent[y_root] = x_root
    @size[x_root] += @size[y_root]
    true
  end

  def same?(x, y)
    find(x) == find(y)
  end

  def size(x)
    @size[find(x)]
  end
end

