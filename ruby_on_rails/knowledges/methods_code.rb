class Trading
  def initialize(coin_name)
    @coin_name = coin_name
  end

  def hello
    puts "Hello #{@coin_name}"
  end

  def method_missing(_)
    hello
  end
end

trading = Trading.new('Bitcoin')

puts "The obvious way: #{trading.hello()}"

puts "Skip the brackets: #{trading.hello}"

puts "Using send method: #{trading.send(:hello)}"

puts "Using public send method: #{trading.public_send(:hello)}"

puts "Using method and call: #{trading.method(:hello).call}"
puts "Using method and call: #{trading.method(:hello).()}"
puts "Using method and call: #{trading.method(:hello).[]}"

puts "Using tap: #{trading.tap(&:hello)}"

puts "Using to_proc: #{:hello.to_proc.call(trading)}"

