require File.join(File.dirname(__FILE__), 'parse_data')
require File.join(File.dirname(__FILE__), 'improve_batting_09_10')
require File.join(File.dirname(__FILE__), 'slugging_percentage_oaks_07')
require File.join(File.dirname(__FILE__), 'triple_crown_winner_11_12')
require 'pry'

def process(batting, master_small)
	# ipb910 = Improve_batting_09_10.new
	# ipb910.process(batting, master_small)
	# slugging = Slugging_percentage_oaks_07.new
	# slugging.process(batting, master_small)
	tcrown = Triple_crown_winner_11_12.new
	tcrown.process(batting, master_small)
	binding.pry
end

def file_exist?(batting, master_small)
	files = Dir.glob("*")
	if (files.include?(batting) && files.include?(master_small)) && (batting.split(".")[1]="csv" && master_small.split(".")[1]="csv")
		process(batting, master_small)
	else
		puts "Files not found in current Directory or not csv format"
	end	
end

batting, master_small = ARGV[0], ARGV[1]
file_exist?(batting, master_small)


