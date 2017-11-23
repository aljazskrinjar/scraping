
require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'


url = "https://www.tmdn.org/tmview/welcome?TrademarkName=Witloft&TrademarkApplicationNumber=&TrademarkReferenceNumber=&ApplicantName=&NiceClass=&ViennaClass=&ApplicationDateFrom=&ApplicationDateTo=&RegistrationDateFrom=&RegistrationDateTo=&cmbSortField=score&cmbOrder=ASC#monitortabs-advancedSearch.html"

puts Crack::JSON.parse(RestClient.get(url))
