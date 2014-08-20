require 'pry'
require File.join(File.dirname(__FILE__), 'parse_data')
require File.join(File.dirname(__FILE__), 'formulas')
require File.join(File.dirname(__FILE__), 'write_in_out')

class Slugging_percentage_oaks_07

	def process(bat, mas)
		players = Parse_data.parse(bat)
		master = Parse_data.parse(mas)
		calculations(players, master)
	end

	def calculations(players, mas)
		result = players.keys.select{|player|player.split("_")[1] == "2007" && player.split("_")[3] == "OAK"}
		result.map!{|q| [q, Formulas.formula_slugging(players, q)] }
		Write_in_out.print_names(result, mas, "SLUGGING PERCENTAGE PER PLAYER on the Oakland A'S IN 2007")
	end
end