module Conversions
  def to_Liters(vol,units)

    vol = vol.to_f

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
    elsif (units == 'pump')
      mass *= 12
    elsif (units == 'cap')
      mass *= 50
    end
    return mass
  end

  def unfractionify(value)
    return nil if ! value
    if value.is_a? Numeric
    else
      value = value.gsub(/,/, '.')
    end
    # is it a fraction
    if (value =~ /^(\d+\s*\d?)\/(\d+)$/)
      num = $1
      den = $2.to_f
      # is it a number like 1 1/2
      if ( num =~ /^(\d+)\s+(\d+)$/ )
        wholenumber = $1.to_i;
        num = $2.to_f;
        value = wholenumber + ( num / den )
      else
        num.to_f
        value = num/den
      end
    end

    return value.to_f
  end

  def translate_units(units)
    case units
      when "caps"
        t.units.five_milliliter
      when "tsp"
        t.units.five_milliliter
      when "pumps"
        t.units.pump_bottle
      when "g"
        t.units.grams
      when "mg"
        t.units.milligrams
      when "ml"
        t.units.milliliter
    end
  end
end

