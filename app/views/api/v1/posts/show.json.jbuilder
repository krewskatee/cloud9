json.title @post.title
json.user_id @post.user_id
json.content @post.content
json.comments do
  json.array! @comments, partial: 'comment', as: :comment
end
