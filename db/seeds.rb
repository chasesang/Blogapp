['Books', 'TV shows', 'Movies', 'Clothse', 'Music', 'Food'].each do |category|
Category.create(name: category)
end

20.times do
  User.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: '12345678',
                password_confirmation: '12345678'
    )
    puts "Product created!"
  end


100.times do
  category = Category.all.sample
   user = User.all.sample
  Post.create({ title: Faker::Friends.character,
                body: Faker::Friends.quote,
                category_id: category.id,
                user_id: user.id
                })
end

posts = Post.all

posts.each do |post|
  rand(0..10).times do
     user = User.all.sample
    post.comments.create({
      body: Faker::Friends.quote,
      user_id: user.id
      })
  end
end



posts_count = Post.count
comments_count = Comment.count
puts Cowsay.say "Created #{posts_count }", :cow
puts Cowsay.say "Created #{comments_count} comments", :cow
