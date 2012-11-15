# Pubdraft

Quickly add published/drafted states to your ActiveRecord models, with helpful scopes and instance methods for querying and changing the states

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pubdraft'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pubdraft

## Usage

```ruby
# requires string column `state` to exist
# $ rails g migration AddStateToMyModels state

class MyModel < ActiveRecord::Base
  pubdraft
end

record = MyModel.create!
record.published? #=> true

record.draft!
record.drafted?   #=> true

record.publish!
record.published? #=> true

MyModel.published #=> [published records]
MyModel.drafted   #=> [drafted records]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
