include RandomData

50.times do
  
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

post = Post.find_or_create_by(title: "Bloc", body: "The Bloc program is intense!")
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

comment = Comment.find_or_create_by(post: post, body: "This is my assignment comment.")

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"