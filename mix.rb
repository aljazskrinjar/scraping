require 'rubygems'
require 'mechanize'
require 'watir'
require 'json'

# require 'headless'
# headless = Headless.new
# headless.start

def insideTM (browser)

  page = Nokogiri::HTML(browser.html)

  elements_with_content = page.xpath('//table[@class = "detail"]')
  first_element =elements_with_content[0]
  trademarkName = first_element.xpath('//span[@class = "trademarkName"]')
  values = first_element.xpath('//td[@class = "size70"]')

  hash = { trademark_name: trademarkName.text,
          application_number: values[0].text,
          application_language: values[1].text,
          application_date:values[2].text}

  puts hash.to_json

  browser.link(class: 'close_tab').click

end

browser = Watir::Browser.new :chrome, headless: true
# browser = Watir::Browser.new :chrome, :switches => %w[--load-extension= ~/.config/google-chrome/Default/Extensions/gkojfkhlekighikafcpjkiklfbnlmeio]

# browser = Watir::Browser.new :chrome, :extensions ['~/.config/google-chrome/Default/Extensions/gkojfkhlekighikafcpjkiklfbnlmeio']

browser.goto('https://www.tmdn.org/tmview/welcome.html')
browser.link(text: 'Advanced search').click
browser.input(name: 'ApplicantName').send_keys(ARGV[0])
browser.input(value: 'Search').click
# require 'pry' ; binding.pry
browser.table(:id => "grid").wait_until_present


page = Nokogiri::HTML(browser.html)
 rows_length=page.xpath('//table[@id="grid"]/tbody/tr').length
 number_of_content_window = page.xpath('//span[@id = "sp_1_grid_toppager"]')
 counter = 1
 browser.td(:id => "next_grid_pager").click
 i = 2
while i <= rows_length do
  application_number = (page.xpath('//table[@id="grid"]/tbody/tr[' + i.to_s + ']/td[8]')).text
  applicant_name = (page.xpath('//table[@id="grid"]/tbody/tr[' + i.to_s + ']/td[12]')).text

  if applicant_name == ARGV[0]
    browser.span(title: application_number).click
    Watir::Wait.until { browser.iframes.first.text.include? 'Renewals' }
    insideTM browser
  end

  if i == rows_length

    break if counter == number_of_content_window.text.to_i || counter == 5
    browser.td(:id => "next_grid_pager").click
    i = 1
    counter += 1

  end

 i += 1


end



# headless.destroy
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
