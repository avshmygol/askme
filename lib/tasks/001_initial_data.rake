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
    user_1 = User.create!(
      name: lines[0],
      nickname: lines[1],
      email: lines[2],
      password_digest: BCrypt::Password.create(lines[3])
    )

    # Пользователь 2
    user_2 = User.create!(
      name: lines[4],
      nickname: lines[5],
      email: lines[6],
      password_digest: BCrypt::Password.create(lines[7])
    )

    # Пользователь 3
    user_3 = User.create!(
      name: lines[8],
      nickname: lines[9],
      email: lines[10],
      password_digest: BCrypt::Password.create(lines[11])
    )

    # Вопрос 1
    Question.create!(
      body: lines[12],
      user: user_1
    )

    # Вопрос 2
    Question.create!(
      body: lines[14],
      user: user_1,
      author_id: user_2.id
    )

  end
end
