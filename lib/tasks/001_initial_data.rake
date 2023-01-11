namespace :setup do
  desc "Added first data"
  task initial_data: :environment do
    # puts "*** Drop old database***"
    # Rake::Task["db:drop"].invoke

    puts "*** Do migrate ***"
    Rake::Task["db:migrate"].invoke

    puts "*** Add initial data ***"
    lines = File.readlines("#{__dir__}/001_initial_data.txt", encoding: "UTF-8", chomp: true)

    # Пользователь 1
    user1 = User.create!(
      name: lines[0],
      nickname: lines[1],
      email: lines[2],
      password_digest: BCrypt::Password.create(lines[3])
    )

    # Пользователь 2
    user2 = User.create!(
      name: lines[4],
      nickname: lines[5],
      email: lines[6],
      password_digest: BCrypt::Password.create(lines[7])
    )

    # Пользователь 3
    user3 = User.create!(
      name: lines[8],
      nickname: lines[9],
      email: lines[10],
      password_digest: BCrypt::Password.create(lines[11])
    )

    # Вопрос 1
    q1 = Question.create(
      body: lines[12],
      user: user1
    )
    q1.save

    # Вопрос 2
    q2 = Question.create(
      body: lines[14],
      user: user1,
      author_id: user2.id
    )
    q2.save

  end
end
