include RandomData

#Create Users
5.times do
  user = User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

6.times do |n|
  rate = Rate.create!(stars: n)
end

users = User.all

#Create Ads
5.times do 
  Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 10)
end

#Create Topics
15.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Posts
50.times do 
    post = Post.create!(
      user: users.sample,
      topic: topics.sample,
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph
    )

    post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
    rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all

# Create Sponsored Posts
30.times do |n|
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: rand(15..100)
  )
end

# Create Comments
100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

# Create Questions
25.times do
  Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)
end

admin = User.create!(
  name: 'Admin User',
  email: 'admin@bloccit.com',
  password: 'helloworld',
  role: 'admin'
)

member = User.create!(
  name: 'Member User',
  email: 'member@bloccit.com',
  password: 'helloworld'
)

moderator = User.create!(
  name: 'Moderator User',
  email: 'moderator@bloccit.com',
  password: 'helloworld',
  role: 'moderator'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
puts "#{Question.count} questions created"
puts "#{Advertisement.count} advertisements created"
