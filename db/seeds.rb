include RandomData

5.times do 
  Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 10)
end

50.times do |n|
  if (n + 1) % 5 == 0
    Post.create!(title: "CENSORED", body: RandomData.random_paragraph)
  else
    Post.create!(
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph)
  end
end

post = Post.find_or_create_by(title: "Bloc", body: "The Bloc program is intense!")
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

25.times do
  Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)
end

comment = Comment.find_or_create_by(post: post, body: "This is my assignment comment.")

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Question.count} questions created"
puts "#{Advertisement.count} advertisements created"