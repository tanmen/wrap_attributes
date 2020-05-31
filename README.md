# WrapAttributes
![test](https://github.com/tanmen/wrap_attributes/workflows/test/badge.svg)

add '_attributes' suffix in rails 

## Usage
```ruby
class ApplicationController < ActionController::API
  include WrapAttributes::AttributesWrapper # <- add
end
```

```ruby
 # request parameter
 # { 'username' => 'tanmen', 'posts' => [{'text' => 'hallo'}] }
 # ↓
 # wrapped parameter
 # { 'username' => 'tanmen', 'posts_attributes' => [{'text' => 'hallo'}] }
class UsersController < ApplicationController
  wrap_attributes :posts # <- add

  private

  def user_params
    params.require(:user).permit(:username, :posts_attributes)
  end
end
```


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'wrap_attributes'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install wrap_attributes
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
