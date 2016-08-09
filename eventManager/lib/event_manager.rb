puts "EventManager Initialized!"

#contents = File.read "event_attendees.csv"
#puts contents if File.exist? "event_attendees.csv"

#lines = File.readlines "event_attendees.csv"
#lines.each {|line| puts line}
#lines.each_with_index do |line, i|
#	next if i == 0
#	columns = line.split(",")
#	name = columns[2]
#	puts name
#end

require "csv"
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

@contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

def clean_zipcode(zipcode)
#	if zipcode.nil?
#		zipcode = "00000"
#	elsif zipcode.length < 5
#		zipcode = zipcode.rjust 5, "0"
#	elsif zipcode.length > 5
#		zipcode = zipcode[0..4]
#	else
#		zipcode
#	end
	zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
	Dir.mkdir("output") unless Dir.exists? "output"
	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end

def clean_phone_number(phone_number)
	digits = phone_number.scan(/\d/).join
	if digits.length == 10 || (digits.length == 11 && digits[0] == "1")
		digits.rjust(11, "1")[1..10]
	else
		"0000000000"
	end
end

def most_popular_hour(hour_hash)
	most_popular = hour_hash.select do |hour, registrations|
		registrations == hour_hash.values.max
	end
	most_popular.keys.join(", ")
end

def most_popular_weekday(weekday_hash)
	days = %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
	most_popular = weekday_hash.select do |weekday, registrations|
		registrations == weekday_hash.values.max
	end
	most_popular.keys.map {|weekday_code| days[weekday_code] }.join(", ")
end



	template_letter = File.read "form_letter.erb"
	erb_template = ERB.new template_letter

	hour_hash = {}
	weekday_hash = {}

	@contents.each do |row|
		id = row[0]
		name = row[:first_name]
		zipcode = clean_zipcode(row[:zipcode])
		legislators = legislators_by_zipcode(zipcode)

		form_letter = erb_template.result(binding)

		save_thank_you_letters(id, form_letter)

		datetime = DateTime.strptime(row[:reg_date], '%m/%d/%Y %H:%M')
		hour_hash[datetime.hour].nil? ? hour_hash[datetime.hour] = 1 : hour_hash[datetime.hour] += 1
		weekday_hash[datetime.wday].nil? ? weekday_hash[datetime.wday] = 1 : weekday_hash[datetime.wday] += 1
	end


puts "Most popular hour: #{most_popular_hour(hour_hash)}"
puts "Most popular weekday: #{most_popular_weekday(weekday_hash)}"