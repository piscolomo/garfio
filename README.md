Garfio
====

Garfio helps you to build hooks in your ruby objects, is minimalist and  framework-agnostic.

## Introduction

With few lines of code, one method compilation, no monkey patching and no `method missing Garfio` lets you launch callbacks before and after of your methods as soon as you run them.

## Installation

Installing Garfio is as simple as running:

```
$ gem install garfio
```

Include Garfio in your Gemfile with gem 'garfio' or require it with require 'garfio'.

Usage
-----

Once you have extend Garfio, you can define your before and after callbacks in the `set_hook` method, your callback recognize the method sending his name as symbol

```ruby
class User
  extend Garfio

  def send_greeting
    puts "preparing the welcome message"
  end

  def register_user
    puts "registering user"
  end

  def send_mailer
    puts "sending to your email"
  end

  set_hook :register_user do
    before :send_greeting
    after :send_mailer
  end
end

User.new.register_user
#=> preparing the welcome message
#=> registering user
#=> sending to your email
```

Is not neccesary indicate both callbacks, you can work with just before or after

```ruby
  set_hook :register_user do
    before :send_greeting
  end
```

Also you can send blocks to your callbacks
```ruby
set_hook :register_user do
  before { puts "hello user!" }
  after { puts "Ok, bye" }
end

User.new.register_user
#=> hello user!
#=> registering user
#=> Ok, bye
```

And you can take advantage of them to do more complex stuff

```ruby
set_hook :register_user do
  after do
    update_status_with("activate")
    send_mailer
    notify_friends
  end
end
```