require 'pry'
require File.join(File.dirname(__FILE__), 'parse_data')
require File.join(File.dirname(__FILE__), 'formulas')
require File.join(File.dirname(__FILE__), 'write_in_out')

class Triple_crown_winner_11_12

	def process(bat, mas)
		players = Parse_data.parse(bat)
		master = Parse_data.parse(mas)
		calculations(players, master)
	end

	 def calculations(players, mas)
	    data_set =[["2011", "NL"], ["2012", "NL"], ["2011", "AL"], ["2012", "AL"]].map{|q| get_data(q, players)}
	    pla_keys = players.keys;nil
	    pla_keys.map{|q| players[q]["H"]=[players[q]["H"].to_i]}
	    pla_keys.map{|q| players[q]["AB"]=[players[q]["AB"].to_i]}
	    pla_keys.map{|q| players[q]["RBI"]=[players[q]["RBI"].to_i]}
	    pla_keys.map{|q| players[q]["RBI"]=[players[q]["HR"].to_i]}
	    data_set.map{|data| data.map!{|w| [w, Formulas.batting_average(players, w), players[w]["HR"], players[w]["RBI"]]}}
	    binding.pry
        searching_tcw(mas, data_set)
	end

	def get_data(data, players)
        players.keys.select{|player|player.split("_")[1] == data[0] && player.split("_")[2] == data[1]}
	end
end