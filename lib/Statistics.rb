class Statistics

  def mean(a)
    if a.nil? || a.empty?
      return "--"
    else
       result = (a.inject(0) {|sum,el| sum + el }.to_f) / a.to_a.length()
    end
    return result.round(1)
  end

  #I stole this from the internets. 
  def variance(a)
    n = 0
    mean = 0.0
    s = 0.0
    a.each { |x|
      n = n + 1
      delta = x - mean
      mean = mean + (delta / n)
      s = s + delta * (x - mean)
    }
    return s / n
  end

  # calculate the standard deviation of a population
  # accepts: an array, the population
  # returns: the standard deviation
  def stddev(a)
    if a.nil? || a.empty?
      "--"
    else
      Math.sqrt(variance(a)).round(1)
    end
  end

  def max(a)
    if a.nil? || a.empty?
      "--"
    else
      a.to_a.max.round(1)
    end
  end

  def min(a)
    if a.nil? || a.empty?
      "--"
    else
      a.to_a.min.round(1)
    end
  end

  def median(a)
    if a.nil? || a.empty? 
      return "--"
    end

    a = a.sort
    len = a.size
    if len % 2 == 0 then
      result = (a[len/2-1] + a[len/2]) / 2.0
    else
      result = a[len/2].to_f
    end
    return result.round(1)
  end

  def stats(pop)
    pop = pop.compact
    result = {}
    [:median, :min, :max, :mean, :stddev].each do |stat|
      result[stat] = self.send(stat, pop)
    end
    return result
  end
end
