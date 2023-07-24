5.times do |i|
  Post.seed([
    {
      title: Faker::Game.title,
      description: Faker::Game.genre,
      status: rand(0..1),
      create_user_id: 1,
      updated_user_id: 1,
    }
  ])
end
