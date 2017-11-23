require 'rubygems'
require 'mechanize'
require 'watir'
require 'json'

browser = Watir::Browser.new
# agent = Mechanize.new


browser.goto('https://www.tmdn.org/tmview/welcome.html')
browser.link(text: 'Advanced search').click
browser.input(name: 'ApplicantName').send_keys('WITLOFT')
browser.input(value: 'Search').click
browser.table(:id => "grid").wait_until_present

#mikes code advice
# page.css("td.tmName__column.grid__tmName").map(&:title)

#optional for biger companies
#browser.link(text: '30').click



page = Nokogiri::HTML(browser.html)
 rows_length=page.xpath('//table[@id="grid"]/tbody/tr').length


first_hit_name = (page.xpath('//table[@id="grid"]/tbody/tr[2]/td[5]')).text

application_number = (page.xpath('//table[@id="grid"]/tbody/tr[2]/td[8]')).text

browser.link(text: first_hit_name).click

whole_text_of_frame = browser.iframes.first.text.gsub!(/.*?(?=sections)/im, "")


#my attempts
# browser.input(name: "localeCode").wait_until_present
# browser.wait_until(browser.text.include("Recordals"))
# browser.img(:id => 'anchorTrademark').wait_until_present
#Watir::Wait.until { browser.text.include? 'List of goods and services' }
#Watir::Wait.until { browser.img(id: "anchorOfficedetails").visible? }
Watir::Wait.until { browser.iframes.first.text.include? 'Renewals' }


page = Nokogiri::HTML(browser.html)



#getting
#//td[@class = "size70"]

elements_with_content = page.xpath('//table[@class = "detail"]')
#code for a first table
first_element =elements_with_content[0]

trademarkName = first_element.xpath('//span[@class = "trademarkName"]')
# puts trademarkName.text
values = first_element.xpath('//td[@class = "size70"]')
#
# puts values[0].text
# puts values[1].text
# puts values[2].text
hash = { trademark_name: trademarkName.text,
        application_number: values[0].text,
        application_language: values[1].text,
        application_date:values[2].text}

hash.to_json

puts hash

# names_of_vars = first_element.xpath('//table[@class = "marginTopLeftBottomExtraLeft"]//td')
# trademark_name=names_of_vars.shift
# names_of_vars.shift
# names_of_vars.shift
# puts "Trademark name : " + trademark_name
# names_of_vars.each_slice(2) do |a1,a2|
#   print a1.text + " : "
#   unless a2 == nil
#     puts a2.text
#   end
# end

# second_element = elements_with_content[1]
# to get inside more tables in the same element
# //table[@class = 'detail marginTopLeftBottom']
# require 'pry' ; binding.pry
# second_element.search('.//table[@class = "subdetail"]').remove
#require 'pry' ; binding.pry
# puts second_element.text
