module Write_in_out

	def self.print_names(result, mas, answer)
		code = result.map{|q| q[0].split("_")[0]}
		code.map!{|q| "/#{q}/"}.map!{|q| mas.keys.grep eval q}
		slugging = result.map{|q| q[1]}
		final_array = code.flatten.zip slugging.flatten
		puts "*****************************"
		puts answer
		puts "*****************************"
		final_array.map{|q| puts "#{q[0].split("_")[2..3].join(" ")} --> #{q[1]}"}
	end
end