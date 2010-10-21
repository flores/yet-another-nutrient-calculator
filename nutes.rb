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
constants = YAML.load_file 'compound_constants.yml'
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
      tsp_con = Float(value)
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
    dose_calc *= tsp_con
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
  @range = YAML.load_file 'graph_ppmconstants.yml'

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

get '/dry' do
  haml :dry
end

error do
  ':('
end

 
#  %input{:type => "select", :name => "compound", :values=>['KNO3','KH2PO4','K2HPO4','KCl','K2SO4']}
 
  #  <option value="kno3">KNO3</option>  
  # <option value="k2hpo4">K2HPO4</option>  
  # <option value="kh2po4">KH2PO4</option>  
  # <option value="k2so4">K2SO4</option>  
  # <option value="kcl">KCl</option>  
  # <option value="plantex">Plantex CSM+B</option>  
  # <option value="microplex">Miller's Microplex</option>  
__END__

@@ layout
%html
  %head
    %title Yet Another Nutrient Calculator
    <meta name="google-site-verification" content="myGZDO_VKmO0z1LnbxckrPQYcS_bEXo3m3NYjqdkAf4" />
  %body
    #header
   
    #content
    =yield
    %footer
      %p
      %a(href='/')Start over
      %br
      %a(href='http://wet.biggiantnerds.com') Back to wet.biggiantnerds.com

@@ ask

%p Yet Another Nutrient Calculator
%form{:action => "/", :method => "post"}
  %p 
  %label My aquarium is 
  %input{:type => "text", :name => "tank_vol", :length => 4, :size => 4}
  %input{:type => "radio", :name => "tank_units", :value=> "gal"}
  gal
  %input{:type => "radio", :name => "tank_units", :value=> "L"}
  L
  %p 
  %label I'm dosing with
  <select name="compound">
  - COMPOUNDS.each do |c| 
    <option value="#{c}">#{c}</option>
  </select>
  %p 
  %label using
  %input{:type => "radio", :name=> "method", :value=> "solution", :onClick => "document.getElementById('sol').style.display='block';"}
  a solution
  %input{:type => "radio", :name=> "method", :value=> "dry", :onClick => "document.getElementById('sol').style.display='none';"}
  dry dosing
  %br
  #sol{:style => 'display:none'}
    %label while using a
    %input{:type => "int", :name=> "sol_volume", :length => 4, :size => 4, :value => 500}
    mL container
    %br
    %label with doses of   
    %input{:type => "int", :name=> "sol_dose", :length => 4, :size => 4, :value => 5}
    mL
    %br
    if you are calculating for dose below,
    %br
    add that amount to this container
  %p 
  %label and I'm calculating for
  %br
  %input{:type => "radio", :name=> "calc_for", :value=> "target", :onClick => "document.getElementById('dump').style.display='none';document.getElementById('target').style.display='block';"}
  what dose to reach a target
  %br
  %input{:type => "radio", :name=> "calc_for", :value=> "dump", :onClick => "document.getElementById('target').style.display='none';document.getElementById('dump').style.display='block';"}
  the result of my dose
  %br
  #dump{:style => 'display:none'}
    I am adding
    %input{:type => "int", :name=> "dose_amount", :length => 4, :size => 4}
    %input{:type => "radio", :name=> "dose_units", :value=> "mg"}
    mg
    %input{:type => "radio", :name=> "dose_units", :value=> "g"}
    g
    %input{:type => "radio", :name=> "dose_units", :value=> "tsp"}
    tsp 
    
  #target{:style => 'display:none'}
    My target is
    %input{:type => "int", :name=> "target_amount", :length => 2, :size => 4}
    ppm


  %p
  %input{:type => "submit", :value => "Gimmie!"}


@@ dump
%p
Your dose of #{@dose_amount} #{@dose_units} #{@comp} into your<br> 
- if @sol_vol > 0
  #{@sol_vol} mL container, with doses of #{@sol_dose} mL<br>
  into a
#{@tank_vol_orig} #{@tank_units} tank gives:<br><br>
- @results.each do |result,result_value| 
  - if result =~ /dKH|dGH/
    #{result} = #{result_value}<br>
  - else
    #{result} = #{result_value}ppm<br>
%br
Relative #{@element} ppm for <font color="green">Walstad</font>, <font color="orange">PPS-Pro</font>,
%br the <font color="blue">Estimative Index</font>, and <font color="red">you</font></center>
%br
<div style="position: relative; float:top; width: 330px; height: 35px;">
<div style="position: absolute; top:1px; left: 15px; width:300px;">
<div style="position: absolute; top:7px; left: 0; width:300px;">
<hr width=100%>
</div>
<div style="position: absolute; top:4px; left: #{@range[@element]['EI']['low']}px; width:  #{@range[@element]['EI']['margin']}px; height: 20px; background-color: blue; fiter:alpha(opacity=50); opacity:.5; center">
</div>
<div style="position: absolute; top:7px; left:  #{@range[@element]['PPS']['low']}px; width: #{@range[@element]['PPS']['margin']}px; height: 14px; background-color: orange; fiter:alpha(opacity=50); opacity:.5; center">
</div>
<div style="position: absolute; top:2px; left:  #{@range[@element]['Walstad']['low']}px; width: #{@range[@element]['Walstad']['margin']}px; height: 24px; background-color: green; fiter:alpha(opacity=50); opacity:.5; center">
</div>
<div style="position: absolute; top:1px; left:  #{@results_pixel}px; width: 4px; height: 26px; background-color: red; fiter:alpha(opacity=1); -moz-opacity:1; center">
</div>
</div>
</div>
<div style="position: relative; float:top; width: 330px; height: 50px">
<div style="position:relative; float:left; left: 10px; height 15px">
0
</div>
<div style="position:relative; float:right; right:10px; height 15px">
#{@pixel_max}
</div>
</div>
</div>
%b Want to model long term effects of<br> #{@element} dosing? Click 
%a(href="http://wet.biggiantnerds.com/ei/con_v_time.pl?stuff=#{@element};dose=#{@target_amount}")here!


@@ target
%p
To reach your target of #{@target_amount} ppm #{@element},
%br you'll need to add #{@dose_amount} grams of #{@comp} 
- if @sol_vol > 0 
  into your #{@sol_vol} mL container.<br>
  Each #{@sol_dose} mL of that mix into #{@tank_vol_orig} #{@tank_units} is:<br><br>
- if @sol_vol == 0
  to #{@tank_vol_orig} #{@tank_units} for:<br><br>
- @results.each do |result,result_value| 
  - if result =~ /dKH|dGH/
    #{result} = #{result_value}<br>
  - else
    #{result} = #{result_value}ppm<br>
%br
Relative #{@element} for <font color="green">Walstad</font>, <font color="orange">PPS-Pro</font>,
%br the <font color="blue">Estimative Index</font>, and <font color="red">you</font></center>
%br
<div style="position: relative; float:top; width: 330px; height: 35px;">
<div style="position: absolute; top:1px; left: 15px; width:300px;">
<div style="position: absolute; top:7px; left: 0; width: 300px">
<hr width=100%>
</div>
<div style="position: absolute; top:4px; left: #{@range[@element]['EI']['low']}px; width:  #{@range[@element]['EI']['margin']}px; height: 20px; background-color: blue; fiter:alpha(opacity=50); opacity:.5; center">
</div>
<div style="position: absolute; top:7px; left:  #{@range[@element]['PPS']['low']}px; width: #{@range[@element]['PPS']['margin']}px; height: 14px; background-color: orange; fiter:alpha(opacity=50); opacity:.5; center">
</div>
<div style="position: absolute; top:2px; left:  #{@range[@element]['Walstad']['low']}px; width: #{@range[@element]['Walstad']['margin']}px; height: 24px; background-color: green; fiter:alpha(opacity=50); opacity:.5; center">
</div>
<div style="position: absolute; top:1px; left:  #{@results_pixel}px; width: 4px; height: 26px; background-color: red; fiter:alpha(opacity=1); -moz-opacity:1; center">
</div>
</div>
</div>

<div style="position: relative; float:top; width: 330px; height: 50px;">
<div style="position:relative; float:left; left: 10px">
0
</div>
<div style="position:relative; float:right; right:10px">
#{@pixel_max}
</div>
</div>
</div>
%p
%b Want to model long term effects of<br> #{@element} dosing? Click 
%a(href="http://wet.biggiantnerds.com/ei/con_v_time.pl?stuff=#{@element};dose=#{@target_amount}")here!

