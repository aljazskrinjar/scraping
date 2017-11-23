require 'rubygems'
require 'mechanize'
require 'watir'



agent = Mechanize.new
page = agent.get('https://www.tmdn.org/tmview/welcome.html')

# puts page.title

# page = mechanize.get('http://google.com/')

# page.links.each do |link|
#   puts link.text
# end

# tmdn_form = page.form('f')
# pp page

forms = page.forms # => Mechanize::Form
# form.fields.each { |f| puts f.name }

# form = page.form('TrademarkName')

# puts form.name

def give_me_form forms
  forms.each do |form|
    form.fields.each do |field|
      if field.name == 'TrademarkName'
        return form,field

      end
    end
  end
  return nil
end

(main_form,main_form_field) = give_me_form forms

unless main_form.nil?

  main_form_field.value = "Witloft"
  page = agent.submit main_form

  # trdemark_value = main_form.fields.name
  #  main_form.value = 'ruby mechanize'
  # page = agent.submit(main_form)
end

pp page
# main_form.q = 'ruby mechanize'
# page = mechanize.submit(main_form)



# a = Mechanize.new { |agent|
#   agent.user_agent_alias = 'Mac Safari'
# }
#
# a.get('http://google.com/') do |page|
#   search_result = page.form_with(:id => 'gbqf') do |search|
#     search.q= 'Hello world'
#   end.submit
#
#   search_result.links.each do |link|
#     puts link.text
#   end
# end

# {forms
#   #<Mechanize::Form
#    {name "f"}
#    {method "GET"}
#    {action "/search"}
#    {fields
#     [hidden:0x2b0bcb99ce18 type: hidden name: ie value: ISO-8859-1]
#     [hidden:0x2b0bcb99caf8 type: hidden name: hl value: nl]
#     [hidden:0x2b0bcb99c850 type: hidden name: source value: hp]
#     [hidden:0x2b0bcb99c51c type: hidden name: biw value: ]
#     [hidden:0x2b0bcb99c1d4 type: hidden name: bih value: ]
#     [text:0x2b0bcb999ee8 type:  name: q value: ]
#     [hidden:0x2b0bcb9994ac type: hidden name: gbv value: 1]}
#    {radiobuttons}
#    {checkboxes}
#    {file_uploads}
#    {buttons
#     [submit:0x2b0bcb999b50 type: submit name: btnG value: Google zoeken]
#     [submit:0x2b0bcb999880 type: submit name: btnI value: Ik doe een gok]}>}>
#


# require 'rubygems'
# require 'mechanize'
#
# agent = Mechanize.new
# page = agent.get('https://www.tmdn.org/tmview/welcome.html')
# google_form = page.form(nil)
# # google_form.q = 'ruby mechanize'
#  page = agent.submit(google_form)
# pp page
