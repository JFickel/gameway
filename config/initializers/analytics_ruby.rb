Analytics = AnalyticsRuby

Analytics.init({
  secret: "u0yahi9lt5q4z9muohu7",
  on_error: Proc.new { |status, msg| print msg }  # Optional error handler
})
