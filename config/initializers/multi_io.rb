class MultiIO

  def initialize(*targets)
    @targets = targets
    unless Goliath.env?(:production)
      @targets.each {|t| t.sync = true}
    end
  end

  def write(*args)
    @targets.each {|t| t.write(*args)}
  end

  def close
    @targets.each(&:close)
  end

end
