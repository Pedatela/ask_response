namespace :dev do

  DEFAULT_PASSWORD = "123456"
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      showSpinner("Apagando Banco de dados ..." ) { %x(rails db:drop)}
      showSpinner("Criando Banco de dados ..." ) {%x(rails db:create) }
      showSpinner("Criando tabelas do Banco de dados ..." ) {%x(rails db:migrate)}
      showSpinner("Populando Banco de dados com Admin Padrão ..." ) {%x(rails dev:add_default_admin)}
      showSpinner("Populando Banco de dados com Administradores Extras ..." ) {%x(rails dev:add_extras_admin)}
      showSpinner("Populando Banco de dados com User Padrão ..." ) {%x(rails dev:add_default_user)}
      showSpinner("Populando Banco de dados com assutos Padrões ..." ) {%x(rails dev:add_subjects)}
      showSpinner("Adicionando perguntas e respostas ..." ) {%x(rails dev:add_aswers_and_questions)}
    else
      puts "Você não esta em ambiente de desenvolvimento!"
    end
  end

  desc "Adicionar o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD,
    )
  end

  desc "Adicionar administradores extras"
  task add_extras_admin: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD,
      )
    end
  end

  desc "Adicionar o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD,
    )
  end

  desc "Adicionar Assuntos"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adicionar Perguntas e Respostas"
  task add_aswers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5...10).times do |i|
        Question.create!(
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject
        )
      end
    end
  end

  private
  def showSpinner(msg_start, msg_end='Concluido')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :dots)
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
