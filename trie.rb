# 仕様補足
# insert時の返り値は[新しいnodeが追加されたかのフラグ、最深根の深さ、登録されている最深根をとおる文字列の数]
# coverで何にもヒットされなかったら精査されたところのnodeが自動で作られる
# coverの返り値
# coverされていれば1
#      されていなければ0

class TrieNode
  attr_accessor :children, :is_covered, :road_count

  def initialize
    @children = Array.new(26) # 'a'..'z'
    @is_covered = false
    @road_count = 0
  end
end

class Trie
  def initialize
    @root = TrieNode.new
  end

  def insert(s)
    node = @root
    path = []
    already_covered = false
    lcp_depth, lcp_sum, lcp_total = nil, nil, 0
  
    s.each_byte do |b|
      path << node
      if node.is_covered
        path.each { |n| n.road_count -= 1 }
        return [0, lcp_depth, lcp_sum, lcp_total]
      end
  
      idx = b - 'a'.ord
      if lcp_sum.nil? && node.road_count > 0
        lcp_sum = node.road_count
        lcp_depth = path.length - 1
      end
      node.children[idx] ||= TrieNode.new
      node = node.children[idx]
      lcp_total += node.road_count
  
      node.road_count += 1
    end

    path << node
    if node.is_covered
      path.each { |n| n.road_count -= 1 }
      return [0, lcp_depth, lcp_sum, lcp_total]
    end
  
    [1, lcp_depth, lcp_sum, lcp_total]
  end
  

  def cover(s)
    node = @root
    path = []

    s.each_byte do |b|
      break if node.is_covered
      path << node
      idx = b - 'a'.ord
      node.children[idx] ||= TrieNode.new
      node = node.children[idx]
    end

    return 0 if node.is_covered

    removed = node.road_count
    if removed > 0
      path.each { |n| n.road_count -= removed }
      node.road_count = 0
    end

    node.is_covered = true
    -removed
  end
end

