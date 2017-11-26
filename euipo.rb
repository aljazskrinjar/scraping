# https://euipo.europa.eu/eSearch/#advanced/owners/1/100/n1=ApplicantName&v1=Krka
# https://euipo.europa.eu/eSearch/#advanced/owners/1/100/n1=ApplicantName&v1=Witloft%20B.V.&o1=AND&c1=IS&sf=ApplicantIdentifier&so=asc
#
# https://euipo.europa.eu/eSearch/#advanced/owners/1/100/n1=ApplicantName&v1=Krka&o1=AND&c1=IS&sf=ApplicantIdentifier&so=asc
# https://euipo.europa.eu/eSearch/#advanced/owners/1/100/n1=ApplicantName&v1=Krka&o1=AND&c1=CONTAINS&sf=ApplicantIdentifier&so=asc

require 'rubygems'
require 'mechanize'
require 'watir'
require 'json'
require 'open-uri'

name_of_owner=ARGV[0].gsub(/\s/,'%20')

url = "https://euipo.europa.eu/eSearch/#advanced/owners/1/100/n1=ApplicantName&v1=#{name_of_owner}&o1=AND&c1=IS&sf=ApplicantIdentifier&so=asc"


browser = Watir::Browser.new
# browser = Watir::Browser.new :chrome, :switches => %w[--load-extension= ~/.config/google-chrome/Default/Extensions/gkojfkhlekighikafcpjkiklfbnlmeio]

# browser = Watir::Browser.new :chrome, :extensions ['~/.config/google-chrome/Default/Extensions/gkojfkhlekighikafcpjkiklfbnlmeio']

browser.goto(url)
# browser.link(text: 'Advanced search').click
# browser.input(name: 'ApplicantName').send_keys(ARGV[0])
# browser.input(value: 'Search').click
Watir::Wait.until { browser.text.include? 'Modify search' }
doc = Nokogiri::HTML(browser.html)

number_of_results=doc.xpath('//div[@class = "box light"]//header//h3//a[@class = "detailsBt"]')
number_of_results.search('//span[@class = "more-info"]').remove
puts number_of_results[0].text.gsub(/\s/,'')
puts ARGV[0]
