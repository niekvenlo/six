# I want to store diary entries in an external file, and display them.
require "json"

@entries = JSON.parse(File.open("diary_entries.txt", 'r') { |file| file.read })

def show_all
  @entries.each do |id,entry|
    puts id
    puts Time.at(entry["timestamp"].to_i).strftime("%F, %T")
    puts entry["title"]
    puts entry["body"]
    puts "\n"
  end
end

def add_entry(title,body)
  id = @entries.keys.max.to_i+1
  timestamp = Time.now.to_i
  @entries[id.to_s] = { "timestamp": timestamp, "title": title, "body": body }
  File.open("diary_entries.txt", 'w') { |file| file.write(@entries.to_json) }
end

if ARGV.size == 2
  add_entry(ARGV[0], ARGV[1])
else
  show_all
end
