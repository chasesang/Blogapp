['Books', 'TV shows', 'Movies', 'Clothse', 'Music', 'Food'].each do |category|
Category.create(name: category)
end

100.times do
  category = Category.all.sample
  Post.create({ title: Faker::Friends.character,
                body: Faker::Friends.quote,
                category_id: category.id
                })
end

posts = Post.all

posts.each do |post|
  rand(0..10).times do
    post.comments.create({
      body: Faker::Friends.quote,
      })
  end
end



posts_count = Post.count
comments_count = Comment.count
puts Cowsay.say "Created #{posts_count }", :cow
puts Cowsay.say "Created #{comments_count} comments", :cow
