require File.expand_path("../lib/garfio", File.dirname(__FILE__))

class User
  include Garfio

  def initialize
    @@sum = 0
  end

  def send_greeting
    @@sum += 1
    puts "preparing the welcome message..."
  end

  def register_user(n = 2)
    @@sum += n
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
    u = Class.new(User) do
        set_hook :register_user do
          before :send_greeting
        end
      end
    u_instance = u.new
    u_instance.register_user

    assert_equal 3, u_instance.get_sum
  end

  test "hook after" do
    u = Class.new(User) do
        set_hook :register_user do
          after :send_mail
        end
      end
    u_instance = u.new
    u_instance.register_user

    assert_equal 5, u_instance.get_sum
  end

  test "hook before and after" do
    u = Class.new(User) do
        set_hook :register_user do
          before :send_greeting
          after :send_mail
        end
      end
    u_instance = u.new
    u_instance.register_user

    assert_equal 6, u_instance.get_sum
  end

  test "respecting the sending variable" do
    u = Class.new(User) do
        set_hook :register_user do
          before :send_greeting
          after :send_mail
        end
      end
    u_instance = u.new
    u_instance.register_user(10)

    assert_equal 14, u_instance.get_sum
  end
end