require 'faker'
namespace :dev do
  DEFAULT_PASSWORD = 123456

  desc "Set up the development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Deleting BD...") {%x(rails db:drop)}
      show_spinner("Creating BD...") {%x(rails db:create)}
      show_spinner("Migrating the BD...") {%x(rails db:migrate)}
      show_spinner("Registering the customer and account default...") {%x(rails dev:add_default_customer)}
    else
      puts "You are not in the development environment."
    end
  end

  desc "Add the default customer"
  task add_default_customer: :environment do
    first_name = "John"
    last_name = "Doe"
    customer = Customer.new(
      first_name: first_name,
      last_name: last_name,
      email: "#{first_name.downcase}#{last_name.downcase}@example.com",
      address: Faker::Address.street_address,
      rg: Faker::IDNumber.brazilian_id,
      cpf: Faker::IDNumber.brazilian_citizen_number,
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
    customer.save!
    account = Account.new(
      customer_id: customer.id,
      balance: 0.0,
      account_number: (SecureRandom.random_number * (10**5)).round,
    )
    account.save!
  end


  private
  def show_spinner(msg_start, msg_end = "Concluido")
    spinner = TTY::Spinner.new("[:spinner) #{msg_start}", format: :dots_9)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end
end