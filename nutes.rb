#!/usr/bin/env ruby

# this here dirty script was written by wet@petalphile.com
# for fellow aquatic plant nerds.  As long as you keep 
# this notice you can do what you want with it.  But 
# if you have ideas or make it better, please let me 
# know.  I'll probably want to help, like to learn,
# and like new ideas.
#
# :) - c

require 'rubygems'
require 'sinatra'
require 'haml'
require 'yaml'

set :environment, :production 
#set :bind, 'localhost'

# the constants array is every compound we support
constants = YAML.load_file 'constants/compounds.yml'
COMPOUNDS =  constants.keys.sort

get '/' do
	haml :ask
end
 
post '/' do
  cons 			= Hash.new
  @results		= Hash.new

# the Stuff while trying to limit what's global
  @tank_vol		= Float(params["tank_vol"]) || 0
  @tank_units		= params["tank_units"]
  @comp 		= params["compound"]
  @dose_method		= params["method"]
    
  @dose_units		= params["dose_units"]
  calc_for		= params["calc_for"]

# i just need this later
  @tank_vol_orig=@tank_vol
  

  if (@tank_units =~ /gal/)
    @tank_vol = @tank_vol * 3.78541178
    @tank_vol = Float(@tank_vol)
  end

# we'll populate everything from the constants hash we created earlier
  pop=constants[@comp]
  pop.each do |junk,value|
    if (junk =~ /tsp/)
      tsp_con = Float("#{value}")
    elsif (junk =~ /target/)
      @element = value
    else
      cons["#{junk}"]=Float("#{value}")
    end
  end
# calculations on the onClick optional menus
  if (calc_for =~ /dump/)
    @dose_amount	= Float(params["dose_amount"])
  elsif (calc_for =~ /target/)
    @target_amount 	= Float(params["target_amount"])
    @dose_amount	= 0
  end	

  if (@dose_method =~ /sol/)
    @sol_vol		= Float(params["sol_volume"])
    @sol_dose		= Float(params["sol_dose"]) 
    dose_calc 		= @dose_amount * @sol_dose / @sol_vol
  else
    @sol_vol 		= 0
    @sol_dose		= 0
    dose_calc 		= @dose_amount
  end

#convert from tsp to mg
  if (@dose_units =~ /tsp/)
    dose_calc *= constants[@comp]['tsp']
  elsif (@dose_units =~ /^g$/)
    dose_calc *= 1000
  end

#convert solutions 

#two forms

  if (calc_for =~ /dump/)
    cons.each do |con,value|
      pie="#{value}"
      pie=Float(pie)
      @results["#{con}"] = dose_calc * pie / @tank_vol
      @results["#{con}"] = sprintf("%.3f", @results["#{con}"])
    end
    @target_amount = @results["#{@element}"]
    @mydose=@dose_amount
  
  elsif (calc_for =~ /target/)
    pie=Float(cons["#{@element}"])
    @mydose = @target_amount * @tank_vol / pie
    @mydose = sprintf("%.2f", @mydose)
    @mydose = Float(@mydose)
    if (@dose_method=~ /sol/ && calc_for =~ /target/)
      @dose_amount = @mydose * @sol_vol / @sol_dose
    else
      @dose_amount = @mydose
    end
    cons.each do |conc,values|
      pie="#{values}"
      pie=Float(pie)
      @results["#{conc}"] = @mydose * pie / @tank_vol
      @results["#{conc}"] = sprintf("%.3f", @results["#{conc}"])
    end
    @dose_amount = @dose_amount / 1000
  end

# fancy graphs -- we're showing ranges recommended by various well regarded methods
#   vs what we just calculated.

# this yml file has The Estimative Index, PPS-Pro, and Walstad recommended values
  @range = YAML.load_file 'constants/dosingmethods.yml'

# if the data is smaller than our largest range above...
  if ( ( @results["#{@element}"].to_f ) <  ( @range["#{@element}"]["EI"]["high"].to_f ) )

# we know the div will be 300 pixels wide.  So, let's get an amount for pixel per ppm
    pie=Float(@range["#{@element}"]["EI"]["high"])
  else
    pie=Float(@results["#{@element}"])
  end
# this will be our ppm at the highest pixel
  @pixel_max=pie * 1.25
  @pixel_per_ppm=300/@pixel_max
# and convert the pixel/ppm to integers so our graph does not break
  if @pixel_max > 1
  	@pixel_max=@pixel_max.to_int
  else
	@pixel_max=100 * @pixel_max.to_f / 100
  end
  
# we convert everything in our range from ppm to pixels, standardized off that ppm/pixel
  @range.each do |compound,method|
	method.each do |specific,value|
		value.each do |wtf,realvalue|
   			value[wtf]=realvalue.to_f * @pixel_per_ppm
			value[wtf]=value[wtf].to_int
			if ( value[wtf] < 4 )
				value[wtf] = 3
			end
   		end
	end
  end 
  @results_pixel=@results["#{@element}"].to_f * @pixel_per_ppm
  @results_pixel=@results_pixel.to_int
  
# and we finally display all of it.
  if (calc_for =~ /dump/)
  	haml :dump
  else
        haml :target
  end  

end

error do
  ':('
end

 

