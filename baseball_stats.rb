require File.join(File.dirname(__FILE__), 'improve_batting_09_10')
require File.join(File.dirname(__FILE__), 'slugging_percentage_oaks_07')
require File.join(File.dirname(__FILE__), 'triple_crown_winner_11_12')

def data_prepare(batting, master_small)
 	data_prepared = Assets.data_preparing(batting, master_small)
 	process(data_prepared)
end

def process(data_prepared)
	ipb910 = Improve_batting_09_10.new
	ipb910.process(data_prepared)
	slugging = Slugging_percentage_oaks_07.new
	slugging.process(data_prepared)
	tcrown = Triple_crown_winner_11_12.new
	tcrown.process(data_prepared)
end

def file_exist?(batting, master_small)
	files = Dir.glob("*")
	if (files.include?(batting) && files.include?(master_small)) && (batting.split(".")[1]="csv" && master_small.split(".")[1]="csv")
		data_prepare(batting, master_small)
	else
		puts "Files not found in current Directory or not csv format"
	end	
end

batting, master_small = ARGV[0], ARGV[1]
file_exist?(batting, master_small)


