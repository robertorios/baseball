require File.join(File.dirname(__FILE__), 'assets')
require File.join(File.dirname(__FILE__), 'formulas')

class Slugging_percentage_oaks_07

	def process(data_prepared)
		players, mas = data_prepared[0], data_prepared[1]
		calculations(players, mas)
	end

	private
	def calculations(players, mas)
		result = players.keys.select{|player|player.split("_")[1] == "2007" && player.split("_")[3] == "OAK"}
		result.map!{|q| [q, Formulas.formula_slugging(players, q)] }
		Assets.print_names(result, mas, "SLUGGING PERCENTAGE PER PLAYER on the Oakland A'S IN 2007")
	end
end