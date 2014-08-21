require 'pry'
require File.join(File.dirname(__FILE__), 'assets')
require File.join(File.dirname(__FILE__), 'formulas')

class Triple_crown_winner_11_12

	def process(data_prepared)
		players, mas = data_prepared[0], data_prepared[1]
		calculations(players, mas)
	end

	 def calculations(players, mas)
	    data_set =[["2011", "NL"], ["2012", "NL"], ["2011", "AL"], ["2012", "AL"]].map{|q| get_data(q, players)}
	    pla_keys = players.keys;nil
	    pla_keys.map{|q| players[q]["H"]=[players[q]["H"].to_i]}
	    pla_keys.map{|q| players[q]["AB"]=[players[q]["AB"].to_i]}
	    pla_keys.map{|q| players[q]["RBI"]=[players[q]["RBI"].to_i]}
	    pla_keys.map{|q| players[q]["HR"]=[players[q]["HR"].to_i]}
	    data_set.map{|data| data.map!{|w| [w, Formulas.batting_average(players, w), players[w]["HR"], players[w]["RBI"]]}}
        searching_tcw(mas, data_set)
	end

	def get_data(data, players)
        players.keys.select{|player|player.split("_")[1] == data[0] && player.split("_")[2] == data[1]}
	end

	def searching_tcw(mas, data_set, top_av_list=[], top_hr_list=[], top_rbi_list=[])
    	data_set.map{|q| q.flatten}
    	[0,1,2,3].each do |i|
            [["top_av",top_av_list=[],1,"to_f"], ["top_hr",top_hr_list=[],2,"join.to_i"], ["top_rbi",top_rbi_list=[],3,"join.to_i"]].each do |set|
				set[0] = data_set[i].map{|p| p[set[2]]}.sort.last
				data_set[i].map{|data| if data[set[2]] == set[0]; set[1] << data; end}
			end
			winner = top_hr_list & top_rbi_list & top_av_list
    		if winner.size > 0
    			write_out(get_names(winner, mas),"TRIPLE CROWN WINNER")
    		else
    		    out_data = top_hr_list.flatten[0].split("_")[1..2]
    		    Assets.print_names([out_data], mas, "NO WINNER IN LEAGUE #{out_data[1]} FOR THE YEAR #{out_data[0]}!!")
    		end	
    		top_av_list=[], top_hr_list=[], top_rbi_list=[]
    	end
	end	
end