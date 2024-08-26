require "csv"
require 'google/apis/civicinfo_v2'
require 'erb'


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read('../secret.key').strip

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(homephone)
 # Remove any non-digit characters
 digits = homephone.gsub(/\D/, '')

 # Check the number of digits
 if digits.length < 10 || digits.length > 11
   return "0000000000"
 elsif digits.length == 10
   return digits
 elsif digits.length == 11 && digits[0] == '1'
   return digits[1..-1] # Trim the leading '1'
 else
   return "0000000000"
 end
end

puts 'Event Manager Initialized!'

contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode =  clean_zipcode(row[:zipcode])
  homephone = clean_phone_number(row[:homephone])

  puts homephone
  # legislators = legislators_by_zipcode(zipcode)

  # form_letter = erb_template.result(binding)

  # save_thank_you_letter(id, form_letter)
end
