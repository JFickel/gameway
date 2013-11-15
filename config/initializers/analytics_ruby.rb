Analytics = AnalyticsRuby

Analytics.init({
  puts "HELLO HELLO"
  puts "HELLO HELLO"
  puts "HELLO HELLO"
  puts "HELLO HELLO"
  puts ENV['SEGMENTIO_SECRET']
  puts ENV.keys
  puts "HELLO"
  puts "HELLO"
  puts "HELLO"
  puts "HELLO"
  puts "HELLO"
  secret: ENV['SEGMENTIO_SECRET'],
  on_error: Proc.new { |status, msg| print msg }  # Optional error handler
})
