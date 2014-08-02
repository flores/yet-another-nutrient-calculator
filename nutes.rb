require 'lib/conversions'
include Conversions

class YANC < Sinatra::Base

  register Sinatra::R18n
  set :root, File.dirname(__FILE__)

  [ "/cu", "/readme", "/contribute_translation" ].each do |md|
    get md do
      markdown :"#{md}"
    end
  end


  [ '/formy_yanc.css',
    '/markdown.css',
    '/ga.js',
    '/js/ga.js',
    '/js/toggle_input_fields.js',
    '/js/ajax.js',
    '/api/compounds.json',
    '/api/commercial_products.json',
    '/api/dosing_methods.json',
    '/api/resources.json',
    ].each do |staticfile|

    get staticfile do
      File.read(File.join('public', staticfile))
    end

  end

  [ '/bootstrap/js/bootstrap.min.js',
    '/bootstrap/js/bootstrap.js',
    '/bootstrap/js/bootstrap-dropdown.js',
    '/bootstrap/css/bootstrap-responsive.css',
    '/bootstrap/css/bootstrap-responsive.min.css',
    '/bootstrap/js/bootstrap-collapse.js',
    '/bootstrap/js/bootstrap-transition.js',
    '/bootstrap/css/bootstrap.min.css',
    '/bootstrap/css/bootstrap.css',
    '/bootstrap/img/glyphicons-halflings-white.png',
    '/bootstrap/img/glyphicons-halflings.png'
    ].each do |staticfile|

    get staticfile do
      File.read(File.join('public/vendor', staticfile))
    end

  end

  ["/","/:locale/","/:locale/non-mobile/?"].each do |path|
    get path do

      erb :ask
    end

    post path do

    # dosing standards
      METHODS = YAML.load_file 'constants/dosingmethods.yml'
      @results    = Hash.new

    # the Stuff while trying to limit what's global
      tank_vol_calc    = unfractionify(params["tank_vol"])
      @tank_units      = params["tank_units"]
      source           = params["source"]
      @round_to        = params["round_to"]


      @method_instruct = ""
      urea             = ""
      pump	       = ""

      @tank_vol_orig  = tank_vol_calc
      tank_vol        = to_Liters(tank_vol_calc,@tank_units)
      cons            = Hash.new

      if ( source == "diy" )
        concentrations = COMPOUNDS
        @comp         = params["compound"]
        @dose_method  = params["method"]
        @dose_units   = params["dose_units"]
        @dose_amount  = unfractionify(params["dose_amount"])
        @target_amount = unfractionify(params["target_amount"])
        calc_for      = params["calc_for"]
      else
        concentrations = COMMERCIAL
        @comp         = params["premix"]
        @dose_method  = params["premix_method"]
        @dose_units   = params["premix_dose_units"]
        @dose_amount  = unfractionify(params["premix_dose_amount"])
        @target_amount = unfractionify(params["premix_target_amount"])
        calc_for      = params["premix_calc_for"]
      end

    # we'll populate everything from the constants hash [ cons ]

      pop=concentrations[@comp]
      pop.each do |junk,value|
        if (junk == 'tsp')
          tsp_con = Float("#{value}")
        elsif (junk == 'sol')
          @solubility = value
        elsif (junk == 'target')
          @element = value
        elsif (junk == 'urea')
          urea = 'yes'
        elsif (junk == 'pump')
          pump = value
        else
          if (source == 'diy')
            cons["#{junk}"]=Float("#{value}")
          else
            cons["#{junk}"]=Float("#{value}")
          end
        end
      end

      @method_instruct = ''
      @dose_freq      = 3
      @pwc            = 50
      @pwc_freq       = "every week"
    # calculations on the onClick optional menu
      if (calc_for == 'dump')
        @dose_amount = unfractionify(@dose_amount)
      elsif (calc_for == 'target')
        @target_amount = unfractionify(@target_amount)
        @dose_amount  = 0
      else
    # some warnings dependent on method
        if (calc_for == 'ei')
          @target_amount = METHODS[@element]["EI"]["method"]
          @method_instruct = t.methods_text.ei
          @dose_freq = 3
          @pwc = 50
          @pwc_freq = "every week"
        elsif (calc_for == "pps")
          @target_amount = METHODS[@element]["PPS"]["method"]
          @method_instruct = t.methods_text.pps
          @dose_freq = 7
          @pwc = 20
          @pwc_freq = "every month"
        elsif (calc_for == "pmdd")
          @target_amount    = METHODS[@element]["PMDD"]["method"]
          if (@target_amount == 0)
            @method_instruct = t.methods_text.pmdd(@element)
          end
          @dose_freq = 7
          @pwc = 50
          @pwc_freq = "every two weeks"
        elsif (calc_for == "wet")
          @target_amount    = METHODS[@element]["Wet"]["method"]
        elsif (calc_for == "ei_low")
          @target_amount = METHODS[@element]["EI_low"]["method"]
          @method_instruct = t.methods_text.ei_low
          @dose_freq = 1
          @pwc = 50
          @pwc_freq = "every two weeks"
        elsif (calc_for =="ei_daily")
          @target_amount    = METHODS[@element]["EI_daily"]["method"]
          @method_instruct        = t.methods_text.ei_daily
          @dose_freq              = 7
          @pwc                    = 50
          @pwc_freq               = "every week"
        end
        @dose_amount    = 0
      end


      if (@comp == 'ADA')
        @method_instruct    = @method_instruct + "<br /> <br />" + t.methods_text.ada
      end

      if (@dose_method == 'sol' && source == 'diy')
        @sol_vol    = unfractionify(Float(params["sol_volume"]))
        @sol_dose    = unfractionify(Float(params["sol_dose"]))
        dose_calc     = @dose_amount * @sol_dose / @sol_vol
      else
        @sol_vol     = 0
        @sol_dose    = 0
        dose_calc     = @dose_amount
      end


      if (@dose_units == 'tsp')
        sol_check = @dose_amount * concentrations[@comp]['tsp']
      elsif (@dose_units == 'g')
        sol_check = @dose_amount * 1000
      else
        sol_check = 0
      end

      if (@comp =~/RootMedic/ && @dose_units =~ /pump/)
        dose_calc = dose_calc * 5
      else
        dose_calc = to_mg(dose_calc,@dose_units)
      end

      if (calc_for == 'dump')
        cons.each do |conc,value|
	  value = value.to_f
          @results["#{conc}"] = dose_calc * value / tank_vol
          @results["#{conc}"] = sprintf( "%.#{@round_to}f", @results["#{conc}"] )
        end
        @target_amount = @results[@element]
        @mydose = @dose_amount
  	@dose_units = translate_units(@dose_units)

      elsif (calc_for =~ /target|ei|pps|pmdd|wet|daily|low/)
	cons_element = Float(cons["#{@element}"])
	@mydose = @target_amount * tank_vol / cons_element
        @mydose = sprintf("%.#{@round_to}f", @mydose).to_i
        if (@dose_method == /sol/)
          @dose_amount = @mydose * @sol_vol / @sol_dose
          sol_check = @dose_amount
        else
          @dose_amount = @mydose
        end
        cons.each do |conc,values|
	  values = values.to_f
          @results["#{conc}"] = @mydose * values / tank_vol
          @results["#{conc}"] = sprintf( "%.#{@round_to}f", @results["#{conc}"] )
        end

        # use grams when the output is over 1000 milligrams, liters when >1000 mL, etc
        if (@dose_amount.to_i > 1000 && source =~ /diy/)
          @dose_amount = @dose_amount / 1000
          @dose_amount = (@dose_amount.to_f * 10**3).round.to_f / 10**3
          @dose_units  = t.units.grams
        elsif (@dose_amount.to_i > 10000 && source =~ /premix/)
          @dose_amount = @dose_amount / 10000
          @dose_amount = (@dose_amount.to_f * 10**3).round.to_f / 10**3
          @dose_units  = t.units.Liter
        elsif (@dose_amount.to_i < 10)
          @dose_amount = (@dose_amount.to_f * 10**2).round.to_f / 10**2
          if (source =~ /diy/)
            @dose_units = t.units.milligrams
          else
            @dose_amount = @dose_amount / 10
            @dose_units  = t.units.milliliter
          end
        else
          @dose_amount = @dose_amount.to_i
          if (source =~ /diy/)
            @dose_units = t.units.milligrams
          else
            @dose_amount = @dose_amount / 10
            @dose_units  = t.units.milliliter
          end
        end
        if (@tank_units =~ /gal/)
          @tank_units = t.units.us_gal
        elsif (@tank_units =~ /L/)
          @tank_units = t.units.Liter
        end
      end

    #check solubility
      if (concentrations[@comp]['sol'] && (@sol_vol > 1))
        sol_ref = concentrations[@comp]['sol'] * 0.8
        sol_check = sol_check / @sol_vol
        if ( sol_ref <  sol_check )
          @sol_error = t.warnings.solubility(@comp, "#{concentrations[@comp]['sol']} #{t.units.milligrams}/#{t.units.milliliter}")
        end
      end

    #K3PO4 is tricky
      if (@comp =~ /K3PO4/ )
        @toxic = t.warnings.k3po4
      end

    #copper toxicity
      cu_toxicity = 0.072
      if (concentrations[@comp]['Cu'])
        if(@results['Cu'].to_f > cu_toxicity)
          toxic = ( @results['Cu'].to_f - cu_toxicity ) / cu_toxicity
          less_dose = @dose_amount - ( @dose_amount * cu_toxicity / @results['Cu'].to_f )
          if (@dose_amount =~ /\./)
            less_dose = less_dose.round_to(3)
          else
            less_dose = less_dose.to_i
          end
          percent_toxic = (toxic * 100).to_i
          @toxic = t.warnings.cu(percent_toxic, @comp, "#{less_dose} #{@dose_units}")
        end
      end

      if (urea == "yes")
        @toxic = t.warnings.urea
      end

    # EDDHA tints the water red
      if (@comp =~ /EDDHA/)
        if (@results['Fe'].to_f > 0.002)
          @toxic = t.warnings.eddha
        end
      end

    # fancy graphs -- we're showing ranges recommended by various well regarded methods
    #   vs what we just calculated.

    # if the data is smaller than our largest range above...
      unless ( METHODS[@element]["EI"]["high"] )
        METHODS[@element]["EI"]["high"] = 0
      end

      if ( ( @results[@element].to_f ) <  ( METHODS[@element]["EI"]["high"].to_f ) )
    # we know the div will be 300 pixels wide.  So, let's get an amount for pixel per ppm
        pie=Float(METHODS[@element]["EI"]["high"])
      else
        pie=Float(@results[@element])
      end
    # this will be our ppm at the highest pixel
      @pixel_max=pie * 1.1
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
        haml :dump, :layout => false
      else
        haml :target, :layout => false
      end
    end
  end

  not_found do
    haml :not_found, :layout => false
  end

  error do
    haml :error, :layout => false
  end

end

__END__
