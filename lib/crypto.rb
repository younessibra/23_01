require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_symbols(page)
  symbols = []
  page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol"]').each do |symbol|
    symbols << symbol.text
  end
  return symbols
end

def get_prices(page)
  prices = []
  page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]').each do |price|
    prices << price.text
  end
  return prices
end

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
puts hashed = Hash[get_symbols(page).zip get_prices(page)]

