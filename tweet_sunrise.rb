require 'sun_times'

# Be sure to setup your ~/.twitter file
# to setup run on command line: twitter setup

def tweet
  puts "Tweeting sunrise"
  exec "twitter tweet \"#{tweet_message}\""
end

def schedule_tweet(time)
  puts "Scheduling sunrise tweet for tomorrow!"
  puts "echo \"ruby #{File.absolute_path(__FILE__)}\" | at #{time.getlocal.strftime('%H:%M')} tomorrow"
end

def tweet_message
  "Good morning!"
end

# Set your lat and long here
LATITUDE = 38.89 # negative is south
LONGITUDE = -77.0164 # negative is west

rise_time_calculator = SunTimes.new
sun_rise_today = rise_time_calculator.rise Date.today, LATITUDE, LONGITUDE
sun_rise_tomorrow = rise_time_calculator.rise Date.today + 1, LATITUDE, LONGITUDE

# if we're within 30 minutes of sunrise and executing this, just tweet now
tweet if (Time.now - sun_rise_today).abs < 1800

schedule_tweet sun_rise_tomorrow
