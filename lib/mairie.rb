require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"

page = Nokogiri::HTML(open(PAGE_URL))   
#page.xpath("//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']/a").each do |price|
   #puts price.content
#end

#page.xpath("//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']/a").each do |price|
   #puts price.content
#end

#page.xpath("//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol']").each do |symbol|
  #puts symbol.content
#end



#doc.xpath(“//td[@class=‘cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol’]//div”).each do |symbol|

#puts page.class   # => Nokogiri::HTML::Documentx


def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))   
  #page.xpath("//td[@class='txt-primary tr-last']").each do |mail|
    #puts mail.content
  #end
  #[contains(@href, "mailto")]'
  #puts page.xpath("//tr[contains(@tr, 'mail')]")
  #puts page.xpath("//tr[@class='txt-primary tr-last']")
  return page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
  #puts page
end



def get_townhall_urls
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  array=[]
  page.xpath("//*[contains(@class, 'lientxt')]/@href").each do |url|
    array << "http://annuaire-des-mairies.com/" + url.to_s[2..-1]
  end
  return array
end

def get_cities
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  cities=[]
  page.xpath("//*[contains(@class, 'lientxt')]").each do |city|
    cities << city.text
  end
  return cities
end

emails = []
urls = get_townhall_urls
urls.each do |url|
  emails << get_townhall_email(url)
end

cities = get_cities

hashed = Hash[cities.zip emails]
puts hashed