# Abc

Start Rails 6 project with custom scaffold, decorators, slim template, datatables, redis, sidekiq, devise, paper_trail, turbolinks, jquery, bootstrap, pg_search, annotate, dalli, lograge, pagy, rspec etc.

Install gems e packages:
```
bundle
yarn
```

Setup database:
```
bundle exec rails db:create
```

Run migrates:
```
bundle exec rails db:migrate
bundle exec rails db:migrate RAILS_ENV=test
```

Run seeds:
```
bundle exec rails db:seed
```

Run tests:
```
bundle exec rspec
```

Start app:
```
bundle exec rails s
```

### Scaffold

Generates full scaffold with tests and datatable(run both commands!), example:

```
bundle exec rails g scaffold Post title:string body:string
bundle exec rails g datatable Post
```
PS: please, check `index.html.slim` to cut javascript code and put in correct folder!

---

### Extras commands:

Generates model/controller/view without tests, example:
```
bundle exec rails g model Post title:string body:string --no-test-framework
bundle exec rails g scaffold_controller Posts title:string body:string --no-test-framework
bundle exec rails g slim:scaffold Post title body
```

## License

This project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
