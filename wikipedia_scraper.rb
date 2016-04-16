require 'open-uri'
require 'nokogiri'

url = 'https://en.wikipedia.org/wiki/List_of_current_NBA_team_rosters'
page = Nokogiri::HTML(open(url))

page.css('td[style="text-align:left;"]').each do |line|
	puts line.text
end