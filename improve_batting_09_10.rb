require 'pry'
require File.join(File.dirname(__FILE__), 'assets')
require File.join(File.dirname(__FILE__), 'formulas')

class Improve_batting_09_10
	def process(data_prepared)
		players, mas = data_prepared[0], data_prepared[1]
		calculations(players, mas)
	end

	def calculations(players, mas, results=[], nine=[], ten =[] )
		relevant_data = players.keys.select{|player| player.split("_")[1] == "2009" || player.split("_")[1] == "2010" }.group_by{|q| q.split("_")[0]}.map{|w| w}.reject{|r| r[1].size < 2}
		relevant_data.map{|q| ten << q[1].select{|w| w =~ /2010/}; nine << q[1].select{|w| w =~ /2009/}}
		array_nine = miba(selecting(nine, players, relevant_data), players)
		array_ten = miba(selecting(ten, players, relevant_data), players)
		array_ten.map{|ten| array_nine.map{|nine|  if ten[0] == nine[0]; results << [ten[0],nine[3],ten[3]]; next; end }}
		result = results.map{|q| [q[0], q[2]-q[1]]}.reject{|w| w[1] < 0}.sort_by{|a,b| b}.last
		Assets.print_names([result], mas, "MOST IMPROVE BATTING AVERAGE FROM 2009 TO 2010")
	end	

	def selecting(year, players, relevant_data)
		ab_year = year.map{|q| q.map{|w| players[w]["AB"]}}.map{|r| r.map{|p| p.to_i}}.map{|t| t.inject(:+)}
		hi_year = year.map{|q| q.map{|w| players[w]["H"]}}.map{|r| r.map{|p| p.to_i}}.map{|t| t.inject(:+)}
		array = relevant_data.map{|q| q[0]}.zip (hi_year.zip ab_year)
		array.map!{|q| q.flatten}.reject!{|q| q[1] == nil || q[2] == nil || q[2].to_i < 200}
	end

	def miba(data_array, players)
		data_array.map!{|p,h,ab|[p, h, ab, Formulas.batting_average(hash={p=>{"H"=>[h],"AB"=>[ab]}}, p)]}
	end

end