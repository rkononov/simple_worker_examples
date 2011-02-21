require 'simple_worker'
SETTINGS = YAML.load_file('../config/face.yaml')
SimpleWorker.configure do |config|
  config.access_key = SETTINGS["sw_access_key"]
  config.secret_key = SETTINGS["sw_secret_key"]
end
load "spot_worker.rb"
tw_username       = "mrskutcher"
fw                = SpotWorker.new
fw.rss_feed       = "http://twitpic.com/photos/#{tw_username}/feed.rss"
fw.face_api_key        = SETTINGS["face_api_key"]
fw.face_api_secret     = SETTINGS["face_api_secret"]
fw.email_username = SETTINGS["email_username"]
fw.email_password = SETTINGS["email_password"]
fw.email_domain   = SETTINGS["email_domain"]
fw.send_to        = "user@email.com"
fw.title          = "Rss feed of #{tw_username}"
fw.last_date      = 1.years.ago.to_s
puts "running worker"
fw.queue