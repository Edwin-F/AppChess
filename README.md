# MightyPawn - Chess Application built with Team Agile Development
This Chess application is the capstone project of the Firehose Project. Under the leadership of a senior developer, a team of
5 developers built a Ruby on Rails Chess application that fully enforces the rules of the game.

Contributors:
- Chelsea
- Edwin
- Jeff
- Smith
- Patrick

Lead By:
Sam


The following technologies were used to create this application:
* Ruby on Rails
* Bootstrap
* PostgreSQL
* Heroku
* RSpec & FactoryGirl
* AJAX requests
* jQuery

# Install
      
### System Requirements
- Ruby 2.3.1 recommended
- Rails 5.0.3
- Postgres 9.2+
 
### Fork and bundle
- Fork the project
- Run bundle to install gems

  `bundle install`   
        
### Database setup

If needed, download and install [Postgres](https://www.postgresql.org/download/)

- Create the databases:

  `rails db:create`
        
- Run migrations to create tables:

  `bundle exec rake db:migrate`

### Run RSpec

- Run the test suite by running the following command:

  `bundle exec rspec`
