require 'uri'
require 'nokogiri'
require 'csv'
require 'net/http'

class LazadaScraper
  attr_reader :url

  def initialize(url)
    @url = url
  end

  # Scrape data from Lazada website
  def scrape_data(max_page)
    name = []
    price = []
    rating = []
    sale = []

    max_page.times do |i|
      current_page_url = "#{url}?page=#{i + 1}"
      page = fetch_page(current_page_url)
      next unless page

      # Extract data from page and append to respective arrays
      name.concat(page.css('span.product-card__name').map(&:text).map(&:strip))
      price.concat(page.css('div.product-card__price').map(&:text).map(&:strip))
      rating.concat(page.css('span.rating__number').map(&:text).map(&:strip))
      sale.concat(page.css('div.product-card__sale').map(&:text).map(&:strip))
    end

    [name, price, rating, sale]
  end

  private

  # Fetch page content from the given URL
  def fetch_page(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    return unless response.is_a?(Net::HTTPSuccess)

    Nokogiri::HTML(response.body)
  end
end

class CsvWriter
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  # Write data to a CSV file
  def write_data(headers, data)
    CSV.open(filename, 'w') do |file|
      file << headers
      data.each { |row| file << row }
    end
  end
end

# Set the URL to scrape
url = 'http://www.lazada.com.ph/shop-computers-laptops/'

# Set the maximum number of pages to scrape
max_page = 5

# Set the filename for the CSV output
filename = 'lazada_scraper.csv'

# Instantiate the LazadaScraper
lazada_scraper = LazadaScraper.new(url)

# Scrape data from Lazada website
name, price, rating, sale = lazada_scraper.scrape_data(max_page)

# Instantiate the CsvWriter
csv_writer = CsvWriter.new(filename)

# Write data to the CSV file
csv_writer.write_data(['Product Name', 'Price', 'Rating', 'Sale'], name.zip(price, rating, sale))
