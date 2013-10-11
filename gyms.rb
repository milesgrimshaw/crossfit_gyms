## MILES GRIMSHAW
require 'csv'
require 'open-uri'
require 'pp'

require 'nokogiri'

CSV.open("crossfits.csv", "wb") do |csv|

	csv << ['name', 'url', 'address line 1', 'address line 2', 'phone']

	for i in 1..8452
		## Open up the page
		page = Nokogiri::HTML(open("http://map.crossfit.com/affinfo.php/?a=#{i}&t=0"))

		if page.text != ""
			## Get the URL and Name
			if page.css("a")[0] != nil
				name = page.css("a")[0].text
			else
				name = 'NA'
			end

			if page.css("a")[0] != nil
				url = page.css("a")[0]["href"]
			else
				url = 'NA'
			end
			
			## Get the address and phone number which are seperated by <br>
			if page.xpath("//body").children[2] != nil
				address_1 = page.xpath("//body").children[2].text
			else
				address_1 = 'NA'
			end
			if page.xpath("//body").children[4] != nil
				address_2 = page.xpath("//body").children[4].text
			else
				address_2 = 'NA'
			end
			if page.xpath("//body").children[6] != nil
				phone = page.xpath("//body").children[6].text
			else
				phone = 'NA'
			end

			csv << [name, url, address_1, address_2, phone]

			pp 'new box'
		end	
	end

end