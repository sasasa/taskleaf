```
bin/rails generate scaffold project name:string
bin/rails g scaffold skill name:string category:int
bin/rails g migration add_project_id_to_tasks
bin/rails g model skills_users skill:references user:references proficiency:integer
bin/rails g mailer TaskMailer
bin/rails active_storage:install
bin/rails g kaminari:views bootstrap4
bundle exec sidekiq
```

# README
動かないとき
```
config/boot.rbをコメントアウト　# require 'bootsnap/setup'
yarn install --check-files
config/webpacker.ymlを修正　check_yarn_integrity: false
```

Rspecジェネレーター
```
bin/rails g rspec:model user
bin/rails g factory_bot:model user
bin/rails g rspec:controller tasks
bin/rails g rspec:system users
bin/rails g rspec:feature sign_up
bin/rails g rspec:request projects_api
bin/rails g rspec:job geocode_user
bin/rails g rspec:mailer user_mailer

```





This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
