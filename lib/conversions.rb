module Conversions
	def to_Liters(vol,units)
	
		vol = vol.to_f
	#is it a fraction?
		if (vol =~ /^(\d+\s*\d?)\/(\d+)$/)
			num = $1
			den = $2.to_f
			if ( num =~ /^(\d+)\s+(\d+)$/ )
				wholenumber = $1.to_i;
				num = $2.to_f;
				vol = wholenumber + ( num / den )
			else
				num.to_i
				vol = num/den
			end
		end

		if (units =~ /gal/)
			vol = (vol * 3.78541178)
		elsif (units =~ /^(milli|m)L?/)
			vol = vol / 1000
		end

		return vol
	end

	def to_mg(mass,units)
		mass = mass.to_f
		if (units =~ /teaspoon|tsp/)
			mass *= COMPOUNDS[@comp]['tsp']
		elsif (units =~ /^g(rams)?$/)
			mass *= 1000
		elsif (units =~ /^(milli|m)L/)
			mass *= 10
		elsif (units =~ /pump/)
			mass *= 12
		elsif (units =~ /cap/)
			mass *= 50 
		end
		return mass
	end
end

