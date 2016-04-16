# Lazada Product Scraper

**Instructions**
* check your computer if you have a a nokogiri installed if not install it first
* Create a file name `lazada_scraper.rb` any name will do
* copy the code below

```ruby
require 'open-uri'
require 'nokogiri'
require 'csv'

url = 'http://www.lazada.com.ph/shop-computers-laptops/'
page = Nokogiri::HTML(open(url))

# Store data ins arrays

page_num = []
 
page.css('span.pages a[href]').each do |line|
	page_num << line.text.strip
end
	# max_page = page_num.max
	max_page = 5 # this are number of pages to be scrape most of the time you choose the max page number
	name = []
	price = []
	rating = []
	sale = []

max_page.to_i.times do |i|

	url = "http://www.lazada.com.ph/shop-computers-laptops/?page=#{i+1}"
	page = Nokogiri::HTML(open(url))
 
	page.css('span.product-card__name').each do |line|
		name << line.text.strip
	end

	page.css('div.product-card__price').each do |line|
		price << line.text.strip
	end
	
	page.css('span.rating__number').each do |line|
		rating << line.text.strip
	end
	
	page.css('div.product-card__sale').each do |line|
		sale << line.text.strip
	end
end

# # Write data to csv files
CSV.open('lazada_scraper.csv', 'w') do |file|
	file << ["Product Name", "Price", "Rating", "Sale"]
	name.length.times do |i|
		file << [name[i], price[i], rating[i], sale[i]]
	end
end
```
