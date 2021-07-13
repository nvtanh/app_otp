# README

* Ruby version `2.7.2`

* How to run app
1. Install some libs dependences
  ```
    bundle install
  ```

2. Setup DB and seed data
  ```
    bundle exec rails db:drop db:create db:migrate db:seed
  ```
3. Setup environment variables
  ```
    cp config/application.yml.sample config/application.yml
  ```

  Note:
  - By default, we run on DEBUG mode: this means, OTP default is `1234` when login, not send mail to send OTP to user.
  - If you want to run normal mode, please follow as step:
    + remove variable `APP_MODE` in `config/application.yml`
    + run mailcatcher(simple SMTP server in local) to catch email send from system:
      ```
        bundle exec mailcatcher
      ```
      Go to http://127.0.0.1:1080/ to check mail box.

4. Run server
  ```ruby
    bundle exec rails s
  ```

  Go to app at http://localhost:3000
