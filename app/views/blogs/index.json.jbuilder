json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :body, :topics
  json.url blog_url(blog, format: :json)
end
