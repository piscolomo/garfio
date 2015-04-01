require File.expand_path("../lib/garfio", File.dirname(__FILE__))

class User
  extend Garfio

  @@sum = 0

  def send_greeting
    @@sum += 1
    puts "preparing the welcome message..."
  end

  def register_user
    @@sum += 2
    puts "registering_user"
  end

  def send_mail
    @@sum += 3
    puts "take your email"
  end

  def get_sum
    @@sum
  end
end

scope do
  test "hook before" do
    class User
      set_hook :register_user do
        before :send_greeting
      end
    end

    u = User.new
    u.register_user

    assert_equal 3, u.get_sum
  end
end