# Pubdraft

Publication state management for the Neoteric Design CMS

## Installation

Neoteric CMS gems are served from a private host. Replace `SECURE_GEMHOST` with the source address.

```ruby
# Gemfile
source SECURE_GEMHOST do
  gem 'pubdraft'
end
```

```sh
$ bundle install
```

## Usage

Pubdraft requires a string column on your parent model.

```ruby
class MyModel < ActiveRecord::Base
  pubdraft

  # or

  pubdraft field: :publication_status,
           states: { in_review: :mark_for_review, drafted: :draft },
           default: :in_review
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


### Options

You can customize Pubdraft per model by setting options when calling the `pubdraft` method.

| Option  | Default        | Description                                 |
|---------|----------------|---------------------------------------------|
|`field`  | `'state'`      | Name of the attribute to use to store state |
|`states` | `{ published: :publish, drafted: :draft }`| Hash of states to use. See [States](states)|
|`default`| `'published'`  | Default state to set when none is provided. Disable setting a default by setting this to `false` |


### States

When setting up pubdraft on a model, you can supply your own custom set of states. States consist of a name, and an action descriptor. THe name is used as the value of the state, while the action is the natural language verb to put in that state.

```ruby
  {
    # Name        # Action
    published:    :publish,
    drafted:      :draft
    in_review:    :mark_for_review
  }

  @post.publish!
  @post.published?                 #=> true
  Post.published.includes?(@post)  #=> true

  @post.mark_for_review!
  @post.in_review?                 #=> true
  Post.in_review.includes?(@post)  #=> true
```

### View Helpers

The gem provides a view helper to easily populate select boxes
```erb
<!-- Standard Form Helpers -->
<%= form_for @record do |f| %>
  <%= f.select :state, pubdraft_state_options(f.object.class) %>
<% end %>

<!-- Formtastic -->
<%= semantic_form_for @record do |f| %>
  <%= f.input :state, :as => :select,
              :collection => pubdraft_states_for_select(f.object.class) %>
<% end %>
```

## Contributing

### Testing

In the base directory:

```bash
$ rspec
````

