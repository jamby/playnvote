module CommentsHelper
  def get_ttl_cmts(comment_id)
    ttl_cmts = 1
    cmt = Comment.find(comment_id)
    while cmt.parent_id
      ttl_cmts += 1
      cmt = Comment.find(cmt.parent_id)
    end
    ttl_cmts
  end
end
