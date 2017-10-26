json.user_id post.user.id
json.username post.user.username
json.id post.id
json.title post.title
json.content post.content
json.admin post.user.admin

json.post do
  json.title @post.title
  json.comments do
    json.array! @comments, partial: 'comment', as: :comment
  end
end

json.array!(@post.comments) do |post|
    json.restaurant post.restaurant.name
    json.reservation_time reservation.time
    json.name user.name
end
