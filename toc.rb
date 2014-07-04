require 'nokogiri'

def get_nav(file_name)
  @doc = Nokogiri::XML(File.read(file_name))
  @contents_list = @doc.at_css("nav ol.contents")
  @ncx = File.new('toc.ncx', 'w+')
  @count = 1
  header
  parse(@contents_list)
  footer
end

def parse(list)
  list.element_children.each do | li |
    link = li.at_css('a')
    id = identify(link['href'])
    text = link.text if link
    @ncx.puts <<_EOS_
	<navPoint id="#{id}" playOrder="#{@count.to_s}">
		<navLabel><text>#{text}</text></navLabel>
		<content src="#{link['href']}" />
_EOS_
    @count += 1
    parse(li.at_css('ol')) if li.at_css('ol')
    @ncx.puts "  </navPoint>"
  end
end

def identify(link)
  link.gsub!(/\d/,"")
  link.gsub!(/\W/,"_")
  link.gsub!(/^_/,"")
end

def footer
  @ncx.puts <<_EOS_
</navMap>

</ncx>
_EOS_
end

def header
  @ncx.puts <<_EOS_
<?xml version="1.0" encoding="UTF-8" ?>
<ncx version="2005-1" xml:lang="en" xmlns="http://www.daisy.org/z3986/2005/ncx/">

<head>
	<meta name="dtb:uid" content="isbn"/>
	<meta name="dtb:depth" content="1"/>
</head>

<docTitle>
	<text></text>
</docTitle>

<navMap>
_EOS_
end

get_nav('toc.xhtml')
