# Some ways to call a method in rails.


def hello
  puts "Hello"
end

1. The obvious way
user.hello()

2. Skip the brackets
user.hello

3. Using send or public_send
user.send(:hello)
user.public_send(:hello)


