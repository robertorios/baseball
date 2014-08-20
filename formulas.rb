module Formulas

	def self.batting_average(players, data)
		players[data]["AB"].join.to_f == 0.to_f ? 0.to_f : players[data]["H"].join.to_f/ players[data]["AB"].join.to_f
	end

	def self.formula_slugging(players, player, info=players[player])
		info["AB"] == 0 || info["AB"] == nil ? 0.to_f : ((info["H"].to_f - info["2B"].to_f - info["3B"].to_f - info["HR"].to_f)+(2*info["2B"].to_f)+(3*info["3B"].to_f)+(4*info["HR"].to_f))/info["AB"].to_f

		# ["H","2B", "3B", "HR", "AB"].each{|var| info[var]=info[var].join("").to_i}
		# info["AB"] == 0 ? 0.to_f : (((info["H"]-info["2B"]-info["3B"]-info["HR"])+(2*info["2B"])+(3*info["3B"])+(4*info["HR"])).to_f)/info["AB"]
	end	
end