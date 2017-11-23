
ht = '<td><<table class="subdetail" fsdfdsfdsfdsf </table><td>'
puts ht.gsub! /<table class="subdetail".+table>/m, ''
