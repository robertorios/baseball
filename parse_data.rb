require 'pry'

module Parse_data

	def self.parse(file, hash={})
		bat = File.open(file).read.split("\r")
		bat[1..-1].map{|q| code = q.split(",")[0...4].join("_"); data = q.split(",")
		if hash.has_key?(code)
			puts "Warning double entry for same player #{code}"
			hash[code] 
		else 
			keys = bat[0].split(",")
			hash[code]={}
			keys.each_with_index.map{|k, ki| hash[code].store k, data[ki]}
		end
		}
		hash	
	end

end