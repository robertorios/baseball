class Baseball

	def input_read_parse(batting, master_small)
		bat, mas = File.open(batting).read.split("\r"), File.open(master_small).read.split("\r")
		calculations(merge_data(bat), mas)
	end

	def merge_data(bat, players={})
		bat[1..-1].map{|q| code = q.split(",")[0...4].join("_"); data = q.split(",")[4..-1] 
		if players.has_key?(code)
			puts "Warning double entry for same player #{code}"
			players[code] 
		else 
			players[code]={"AB" => [data[1].to_i], "H" => [data[3].to_i], "2B" => [data[4].to_i], "3B" => [data[5].to_i], "HR" => [data[6].to_i], "RBI" => [data[7].to_i]}
		end
		}
		players		
	end

	def calculations(players, mas)
		miba(players, mas)
		sp_oak_07(players, mas)
		tcw(players, mas)
	end

	def miba(players,mas, results=[], nine=[], ten =[] )
		relevant_data = players.keys.select{|player| player.split("_")[1] == "2009" || player.split("_")[1] == "2010" }.group_by{|q| q.split("_")[0]}.map{|w| w}.reject{|r| r[1].size < 2}
		relevant_data.map{|q| ten << q[1].select{|w| w =~ /2010/}; nine << q[1].select{|w| w =~ /2009/}}
		array_nine = formula_miba(selecting(nine, players, relevant_data), players)
		array_ten = formula_miba(selecting(ten, players, relevant_data), players)
		array_ten.map{|q| array_nine.map{|w|  if q[0] == w[0]; results << [q[0],w[3],q[3]]; next; end }}
		b = results.map{|q| [q[0], q[2]-q[1]]}.reject{|w| w[1] < 0}
		write_out(get_names(results.map{|q| [q[0], q[2]-q[1]]}.select{|q| q[1] == b.map{|q| q[1]}.sort.last},mas),"MOST IMPROVE BATTING AVERAGE")
	end	

	def selecting(year, players, relevant_data)
		ab_year = year.map{|q| q.map{|w| players[w]["AB"]}}.map{|r| r.flatten}.map{|t| t.inject(:+)}
		hi_year = year.map{|q| q.map{|w| players[w]["H"]}}.map{|r| r.flatten}.map{|t| t.inject(:+)}
		array = relevant_data.map{|q| q[0]}.zip (hi_year.zip ab_year)
		array.map!{|q| q.flatten}.reject!{|q| q[1] == nil || q[2] == nil || q[2] < 200}
	end

	def formula_miba(data_array, players)
		data_array.map!{|p,h,ab|[p, h, ab, batting_average(hash={p=>{"H"=>[h],"AB"=>[ab]}}, p)]}
	end

	def sp_oak_07(players, mas)
		data = players.keys.select{|player|player.split("_")[1] == "2007" && player.split("_")[3] == "OAK"}
		data.map!{|q| [q, formula_slugging(players, q)] }
		write_out(get_names(data, mas),"SLUGGING PERCENTAGE PER PLAYER on the Oakland A'S IN 2007")
	end

	def formula_slugging(players, player, info=players[player])
		["H","2B", "3B", "HR", "AB"].each{|var| info[var]=info[var].join("").to_i}
		info["AB"] == 0 ? 0.to_f : (((info["H"]-info["2B"]-info["3B"]-info["HR"])+(2*info["2B"])+(3*info["3B"])+(4*info["HR"])).to_f)/info["AB"]
	end	

	def get_names(data, mas)
		code_mas = mas.map{|q| q.split(",")[0]}
		data.map{|q| [mas[code_mas.index(q[0].split("_")[0])].split(",")[2..3].join(" "), q[1]]}
	end

	def tcw(players, mas)
	    data_set =[["2011", "NL"], ["2012", "NL"], ["2011", "AL"], ["2012", "AL"]].map{|q| get_data(q, players)}
	    data_set.map{|data| data.map!{|w| [w, batting_average(players, w), players[w]["HR"], players[w]["RBI"]]}}
        searching_tcw(mas, data_set)
	end

	def batting_average(players, data)
		players[data]["AB"].join(" ").to_f == 0.to_f ? 0.to_f : players[data]["H"].join(" ").to_f/ players[data]["AB"].join(" ").to_f
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
    			write_out(get_names([], mas),"NO WINNER IN LEAGUE #{out_data[1]} FOR THE YEAR #{out_data[0]}!!")
    		end	
    		top_av_list=[], top_hr_list=[], top_rbi_list=[]
    	end
	end	

	def write_out(data, text)
		puts "************************************************"
		puts text
		puts data.map{|q| q.join(" --> ")}
	end	

end

def file_exist?(batting, master_small)
	files = Dir.glob("*")
	if files.include?(batting) && files.include?(master_small)
		hit = Baseball.new
		hit.input_read_parse(batting, master_small)
	else
		puts "Files not found in current Directory"
	end	
end

batting, master_small = ARGV[0], ARGV[1]
file_exist?(batting, master_small)
