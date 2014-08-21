require 'pry'

module Assets

	def self.data_preparing(bat, mas, bat_hash={}, mas_hash={})
		bat, mas = File.open(bat).read.split("\r"), File.open(mas).read.split("\r")
		[[bat, bat_hash],[mas, mas_hash]].each{|file, hash|
			file[1..-1].map{|q| 
				code = q.split(",")[0...4].join("_"); data = q.split(",")
				if hash.has_key?(code)
					puts "Warning double entry for same player #{code}, using only first data"
					hash[code] 
				else 
					keys = file[0].split(",")
					hash[code]={}
					keys.each_with_index.map{|k, ki| hash[code].store k, data[ki]}
				end
			}
		}	
		[bat_hash, mas_hash]
	end

	def self.print_names(result, mas, answer)
		code = result.map{|q| q[0].split("_")[0]}
		code.map!{|q| "/#{q}/"}.map!{|q| mas.keys.grep eval q}
		slugging = result.map{|q| q[1]}
		final_array = code.flatten.zip slugging.flatten
		puts "***********************************************************"
		puts answer
		puts "***********************************************************"
		final_array.map{|q| puts "#{q[0].split("_")[2..3].join(" ")} --> #{q[1]}"}
	end


end