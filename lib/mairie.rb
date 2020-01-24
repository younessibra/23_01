require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))   
  return page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
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

def get_all_emails
  emails = []
  urls = get_townhall_urls
  urls.each do |url|
    emails << get_townhall_email(url)
  end
  return emails
end

puts hashed = Hash[get_cities.zip get_all_emails]