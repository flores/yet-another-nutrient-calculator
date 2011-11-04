require 'rubygems'
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'thin'

require 'lib/conversions'
include Conversions

class YANC < Sinatra::Base
        get '/', :agent => /iphone|webos|mobile/i do
                redirect '/mobile'
        end

        
	["/","/non-mobile"].each do |path|
		get path do
			haml :ask
		end
			
		post path do

		# dosing standards
			METHODS = YAML.load_file 'constants/dosingmethods.yml'
			@results		= Hash.new
		
		# the Stuff while trying to limit what's global
			tank_vol_calc		= Float(params["tank_vol"].sub(/,/, '.')) || 0
			@tank_units		= params["tank_units"]
			
				

			source			= params["source"]
			
			@method_instruct	= ""
			urea			= ""
                        pump			= ""
		
			@tank_vol_orig		= tank_vol_calc
			tank_vol 		= to_Liters(tank_vol_calc,@tank_units)
	
			cons 			= Hash.new
	
			if ( source =~ /diy/ )
				concentrations 	= COMPOUNDS
				@comp		= params["compound"]
				@dose_method	= params["method"]
				@dose_units    	= params["dose_units"]
				@dose_amount	= params["dose_amount"]
				@target_amount	= params["target_amount"].sub(/,/, '.').to_f
				calc_for	= params["calc_for"]
			else
				concentrations 	= COMMERCIAL
				@comp		= params["premix"]
				@dose_method	= params["premix_method"]
				@dose_units    	= params["premix_dose_units"]
				@dose_amount	= params["premix_dose_amount"]
				@target_amount	= params["premix_target_amount"].sub(/,/, '.').to_f
				calc_for	= params["premix_calc_for"]
			end
		
		# we'll populate everything from the constants hash [ cons ]
			
			pop=concentrations[@comp]
			pop.each do |junk,value|
				if (junk =~ /tsp/)
					tsp_con = Float("#{value}")
				elsif (junk =~ /sol/)
					@solubility = value
				elsif (junk =~ /target/)
					@element = value
				elsif (junk =~ /urea/)
					urea = 'yes'
                                elsif (junk =~ /pump/)
                                        pump = value
				else
					if (source =~ /diy/)
						cons["#{junk}"]=Float("#{value}")
					else
						cons["#{junk}"]=Float("#{value}")
					end
				end
			end
		
			
		# calculations on the onClick optional menu
			if (calc_for =~ /dump/)
				@dose_amount	= @dose_amount.sub(/,/, '.')
		# is dose amount a fraction?
				if (@dose_amount =~ /^(\d+\s*\d?)\/(\d+)$/)
					num = $1
					den = $2.to_f
					if ( num =~ /^(\d+)\s+(\d?)/ )
						wholenumber = $1.to_i;
						num = $2.to_f;
						@dose_amount = wholenumber + ( num / den )
					else
						@dose_amount = num.to_f/den
					end
				end
				@dose_amount = @dose_amount.to_f
			elsif (calc_for =~ /target/)
				@target_amount 	= @target_amount
				@dose_amount	= 0
			else
                  # some warnings dependent on method
				if (calc_for == 'ei')
					@target_amount		= METHODS[@element]["EI"]["method"] 
					@method_instruct	= "Classic EI depends on good CO2, good circulation, and regular water changes.<br />Light past moderation is not so important.<br />"
				elsif (calc_for == "pps")
					@target_amount		= METHODS[@element]["PPS"]["method"] 
					@method_instruct	= "We've calculated for PPS-Pro's daily dose.<br />The recommended range below is for a stabilized mature tank.<br />"
				elsif (calc_for == "pmdd")
					@target_amount		= METHODS[@element]["PMDD"]["method"]
					if (@target_amount == 0)
						@method_instruct = "PMDD does not dose #{@element}.<br />(But maybe you should.)<br />"
					end
				elsif (calc_for == "wet")
					@target_amount  	= METHODS[@element]["Wet"]["method"]
					@method_instruct 	= "This is basically EI with my personal daily dosing.  Under high light, be prepared to trim often,<br />change water often, and keep the CO2 high and steady."
				elsif (calc_for == "ei_low")
					@target_amount          = METHODS[@element]["EI_low"]["method"]
					@method_instruct	= "This is EI scaled for once a week dosing under low light. The EI ranges below are over time for most tanks."
				elsif (calc_for =="ei_daily")
					@target_amount		= METHODS[@element]["EI_daily"]["method"]
                                        @method_instruct        = "This is traditional EI, just reduced for daily dosing"
				end
				@dose_amount		= 0
			end	
                
			if (@comp =~ /ADA/)
				@method_instruct		= "ADA's fertilization system includes nutrient-rich substrate, while their liquid fertilizers supplement the water column until the substrate is depeleted.<br /> <br />ADA analysis courtesy of Plantbrain/Tom Barr<br />available at <a href='http://barrreport.com'>The Barr Report</a> <br /> <br /> #{@method_instuct}"
			end

			if (@dose_method =~ /sol/ && source =~ /diy/)
				@sol_vol		= Float(params["sol_volume"].sub(/,/, '.'))
				@sol_dose		= Float(params["sol_dose"].sub(/,/, '.')) 
				dose_calc 		= @dose_amount * @sol_dose / @sol_vol
			else
				@sol_vol 		= 0
				@sol_dose		= 0
				dose_calc 		= @dose_amount
			end

			if (@dose_units =~ /tsp/)
				sol_check = @dose_amount * concentrations[@comp]['tsp']
			elsif (@dose_units =~ /^g$/)
				sol_check = @dose_amount * 1000
			else
				sol_check = 0
			end

			if (@comp =~/RootMedic/ && @dose_units =~ /pump/)
				dose_calc = dose_calc * 5
			else
				dose_calc = to_mg(dose_calc,@dose_units)
			end

			if (calc_for =~ /dump/)
				cons.each do |conc,value|
					pie="#{value}"
					pie=pie.to_f
					@results["#{conc}"] = dose_calc * pie / tank_vol
       	                                 if ( @results["#{conc}"] > 0.005 )
       	                                         @results["#{conc}"] = sprintf( '%.2f', @results["#{conc}"] )
               	                        else
                       	                        @results["#{conc}"] = sprintf( '%.4f', @results["#{conc}"] )
                               	        end
				end
				@target_amount = @results["#{@element}"]
				@mydose=@dose_amount
			
			else (calc_for =~ /target|ei|pps|pmdd|wet|daily|low/)
				pie=Float(cons["#{@element}"])
				@mydose = @target_amount * tank_vol / pie
				#@mydose = sprintf("%.2f", @mydose)
				@mydose = Float(@mydose)
				if (@dose_method=~ /sol/)
					@dose_amount 	= @mydose * @sol_vol / @sol_dose
					sol_check	= @dose_amount
				else
					@dose_amount 	= @mydose
				end
				cons.each do |conc,values|
					pie="#{values}"
					pie=pie.to_f
					@results["#{conc}"] = @mydose * pie / tank_vol
                                        if ( @results["#{conc}"] > 0.005 )
                                                @results["#{conc}"] = sprintf( '%.2f', @results["#{conc}"] )
                                        else
                                                @results["#{conc}"] = sprintf( '%.4f', @results["#{conc}"] )
                                        end
				end

				
				if (@dose_amount.to_i > 1000 && source =~ /diy/)
					@dose_amount = @dose_amount / 1000
					@dose_amount = (@dose_amount.to_f * 10**3).round.to_f / 10**3
					@dose_units  = 'grams'
				elsif (@dose_amount.to_i > 10000 && source =~ /premix/)
					@dose_amount = @dose_amount / 10000
					@dose_amount = (@dose_amount.to_f * 10**3).round.to_f / 10**3
					@dose_units  = 'L'
				elsif (@dose_amount.to_i < 10)
					@dose_amount = (@dose_amount.to_f * 10**2).round.to_f / 10**2
					if (source =~ /diy/)
						@dose_units = 'mg'
					else
						@dose_amount = @dose_amount / 10
						@dose_units  = 'mL'
					end
				else
					@dose_amount = @dose_amount.to_i
					if (source =~ /diy/)
						@dose_units = 'mg'
					else
						@dose_amount = @dose_amount / 10
						@dose_units  = 'mL'
					end
					
				end
			end
		
		#check solubility
			if (concentrations[@comp]['sol'] && (@sol_vol > 1))
				sol_ref = concentrations[@comp]['sol'] * 0.8
				sol_check = sol_check / @sol_vol
				if ( sol_ref <	sol_check )
					@sol_error = "<font color='red'>#{@comp}'s solubility at room temperature<br>is #{concentrations[@comp]['sol']} mg/mL.<br>You should adjust your dose.</font><br>"
				end
			end
		
		#K3PO4 is tricky
			if (@comp =~ /K3PO4/ )
				@toxic="K3PO4 in solution tends to raise pH due to<br/>
		the nature of KOH, a strong base. <br/>
		ray-the-pilot explains this for us gardeners here:<br/>
		<a href='http://bit.ly/ev7txA'>'K3PO4 instead of KH2PO4?' at Aquatic Plant Central'</a></br>"
			end
			
		#copper toxicity
			if (concentrations[@comp]['Cu'])
				if(@results['Cu'].to_f > 0.072)
					toxic = ( @results['Cu'].to_f - 0.072 ) / 0.072 
					less_dose = @dose_amount - ( @dose_amount * 0.072 / @results['Cu'].to_f )
					if (@dose_amount =~ /\./)
						less_dose = less_dose.round_to(3)
					else
						less_dose = less_dose.to_i
					end
					percent_toxic = (toxic * 100).to_i
					@toxic = "<font color='red'>Your Cu dose is #{percent_toxic}% more than recommended<br />for sensitive fish and inverts. Consider<br />reducing your #{@comp} dose by #{less_dose} #{@dose_units}.</font><br /><a href='/cu' target='_blank'>Read more about Cu toxicity here</a>.<br />"
				end
			end

			if (urea == "yes")
				@toxic = "this product has some unknown percentage of N as Urea and as NO3.  The calculation and chart below works off NO3 equivalents."
			end
		
		# EDDHA tints the water red	
			if (@comp =~ /EDDHA/)
				if (@results['Fe'].to_f > 0.002)
					@toxic = "<font color='red'>Be aware that EDDHA will tint the water pink to red<br /> at even moderate doses.</font><br />You can check out a video of a 0.2ppm dose <a href='http://www.youtube.com/watch?v=ZCTu8ClcMKc' target='_blank'>here</a>.<br />"
				end
			end
		
		# fancy graphs -- we're showing ranges recommended by various well regarded methods
		#	 vs what we just calculated.
		
		# if the data is smaller than our largest range above...
			unless ( METHODS[@element]["EI"]["high"] )
				METHODS[@element]["EI"]["high"] = 0
			end
			
			if ( ( @results[@element].to_f ) <	( METHODS[@element]["EI"]["high"].to_f ) )
		# we know the div will be 300 pixels wide.	So, let's get an amount for pixel per ppm
				pie=Float(METHODS[@element]["EI"]["high"])
			else
				pie=Float(@results[@element])
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
			METHODS.each do |compound,method|
				if (method == "Wet")
					next
				end
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
			
			if (calc_for =~ /dump/)
				haml :dump
			else
				haml :target
			end
		end
	end
	
	get '/cu' do
		markdown :cu
	end

	get '/readme' do
		markdown :README
	end

	get '/formy_yanc.css' do
		File.read(File.join('public', 'formy_yanc.css'))
	end

	not_found do
		haml :not_found
	end
	
	error do
		haml :error
	end

end	

__END__
