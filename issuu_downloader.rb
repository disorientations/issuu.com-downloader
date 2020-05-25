#!/usr/bin/ruby
require 'image_size'
require 'mechanize'
require 'prawn'

$stdout.sync = true

document_id = ARGV[0].to_s
magazine_name = ARGV[1].to_s

agent = Mechanize.new
pages = 0
more = true

print "Downloading "
while more
  print "."
  page = pages + 1
  filename = "page_#{page.to_s}.jpg"
  link = "http://image.issuu.com/#{document_id}/jpg/#{filename}"
  begin
    image = agent.get(link)
    image.save filename
    pages = page
  rescue Mechanize::ResponseCodeError => e
    more = e.response_code == "404"
  end
end
puts

print "Generating "
Prawn::Document.generate("#{magazine_name}.pdf", :page_layout => :portrait) do |pdf|
  for page in 1..pages
    print "."
    filename = "page_#{page.to_s}.jpg"
    size = ImageSize.path(filename)
    pdf.image filename, {
      :width => size.width,
      :height => size.height,
      :position => :center,
      :vposition => :center,
      :fit => [pdf.bounds.right.to_i, pdf.bounds.top.to_i]
    }
    pdf.start_new_page if page != pages
  end
end
puts

print "Cleaning up "
for page in 1..pages
  print "."
  File.delete("page_#{page.to_s}.jpg")
end
puts

puts "Done"
