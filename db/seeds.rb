User.create!(
  user_name: "Example User",
  name: "example user",
  email: "example@example.com", 
  password: "foovar",
  password_confirmation: "foovar"
  )
  
50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(
    name: name,
    user_name: name,
    email: email,
    password: password,
    password_confirmation: password
    )
end

users = User.order(:created_at).take(6)
30.times do
  content = Faker::Lorem.sentence
  users.each { |user| user.posts.create!(picture: open("#{Rails.root}/public/sample1.jpeg"), 
                                         content: content)}
end

users = User.all
user = users.first
following = users[2..40]
followers = users[3..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
