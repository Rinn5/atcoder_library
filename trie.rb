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

  # 追加クエリ（t == 2）
  def insert(s)
    node = @root
    path = []
    already_covered = false

    s.each_byte do |b|
      path << node
      already_covered ||= node.is_covered
      idx = b - 'a'.ord
      node.children[idx] ||= TrieNode.new
      node = node.children[idx]
    end

    path << node
    already_covered ||= node.is_covered

    unless already_covered
      path.each { |n| n.road_count += 1 }
      return 1
    end
    
    0
  end

  # カバークエリ（t == 1）フラグを立てる
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

if __FILE__ == $0 then
  trie = Trie.new

  puts trie.insert("apple")    # => 1（初めてなので追加される）
  puts trie.insert("apple")    # => 0（すでにカバーされているので追加されない）
  puts trie.cover("app")       # => 0（"app"自体はまだ追加されていないので何も削除されない）
  puts trie.insert("app")      # => 1
  puts trie.cover("app")       # => -1（"app"をカバー、1件削除）
  puts trie.insert("app")      # => 0（すでにカバーされたので追加されない）  
end