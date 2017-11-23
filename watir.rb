require 'watir'

browser = Watir::Browser.new

browser.goto('https://www.tmdn.org/tmview/welcome.html')

browser.input(name: 'q').send_keys('Witloft')
#
 browser.input(value: 'Search').click
#
browser.link(text: 'HAND CRAFTED BY W L WITLOFT').click

browser.div(:class => "detailLeftMenu").wait_until_present
sleep(3)
# browser.div(id: 'results').h3s.each do |h3|
#   puts h3.text.strip
# end

browser.close

# https://readysteadycode.com/howto-scrape-websites-with-ruby-and-watir
