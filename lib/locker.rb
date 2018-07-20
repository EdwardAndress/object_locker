class Locker
  def initialize(protected_object, locked: false)
    @protected_object = protected_object
    @locked = locked
  end

  def unlocked?
    !@locked
  end

  def method_missing(method, *args, &block)
    if !@protected_object.respond_to?(method)
      raise NoMethodError, "Neither #{self} nor the protected object #{@protected_object} implment #{method}"
    elsif unlocked?
      @protected_object.send(method)
    end
  end
end
