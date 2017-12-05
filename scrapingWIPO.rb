require 'rubygems'
require 'mechanize'
require 'watir'
require 'json'
require 'open-uri'

def busy (browser)
  if browser.text.include? "Sorry, the page is busy processing"
    puts "Sorry the scraping page is having some problems. Please try later."
  end
end

def check_if_zero_results (browser)
  if browser.text.include? 'No documents match your query'
    exit
  end
end

url = 'http://www.wipo.int/branddb/en/index.jsp#'
browser = Watir::Browser.new :chrome, headless: true
browser.goto(url)
Watir::Wait.until { browser.text.include? 'Names' }
busy browser
browser.link(text: 'Names').click
busy browser
browser.input(id: 'HOL_input').send_keys(ARGV[0])
Watir::Wait.until { browser.text.include? 'search' }
busy browser
browser.send_keys :enter
Watir::Wait.until { (browser.text.include? 'options') || (browser.text.include? 'No documents match your query')}
busy browser
check_if_zero_results browser
browser.link(:visible_text => /options/).click
Watir::Wait.until { browser.text.include? 'Add All' }
busy browser
browser.link(:visible_text => /Add All/).click
Watir::Wait.until { browser.text.include? 'Ok' }
busy browser
browser.button(:visible_text => /Ok/).click
busy browser
Watir::Wait.until { browser.text.include?('Remove All') == false }

doc = Nokogiri::HTML(browser.html)
number_of_rows =doc.xpath('//tr[@role = "row"]').count

i = 0
while i <= number_of_rows-3 do
  elements = doc.xpath('//tr[@id = "' + i.to_s + '"]//td[@role = "gridcell"]')
  hash = { owner_name: elements[11].text,
            trademark_name: elements[6].text,
            trademark_number: elements[13].text,
            application_date: elements[15].text,
            registration_date: elements[14].text,
            status: elements[8].text}

  puts hash.to_json
  i = i + 1
end
