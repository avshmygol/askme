# README

____

The "askme" is a training clone of the application "askme.fm"

____

## Versions

* Ruby version 3.1.2
* Rails version 7.0.4

## Start settings

```
bundle
bundle exec rails assets:precompile
```

## Database

Rename the database.yml.example file to the database.yml file.
Edit the database.yml file to configure for your database.

```
rails db:create
rails db:migrate
```

## Start server

```
rails s
```
