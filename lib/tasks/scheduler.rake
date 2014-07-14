desc "This task is called by the Heroku scheduler add-on"
task :autopost => :environment do
  puts "Autoposting..."
  Post.autopost
  puts "done."
end