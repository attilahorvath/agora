module TopicsHelper
  def for_each_children(comments, comment_id, before, after)
    s = ""
    children = comments[comment_id]
    if children
      comments[comment_id].each do |child|
        s += before
        s += yield child
        s += for_each_children(comments, child.id, before, after) {|c| yield c}
        s += after
      end
    end
    s.html_safe
  end
end
