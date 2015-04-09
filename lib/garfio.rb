module Garfio
  class GarfioHooks
    attr_reader :hook_before, :hook_after
    def initialize(&block)
      instance_eval &block
    end

    private
    [:before, :after].each do |name|
      define_method name do |method_name = nil, &block|
        instance_variable_set("@hook_#{name}", method_name || block)
      end
    end
  end

  def set_hook(original_method, _v = "", &block)
    gar = GarfioHooks.new &block
    send :alias_method, "old_#{original_method}", original_method
    send :define_method, original_method do |*args|
      _v.is_a?(Proc) ? instance_eval(&_v) : send(_v) if _v = gar.hook_before
      send "old_#{original_method}", *args
      _v.is_a?(Proc) ? instance_eval(&_v) : send(_v) if _v = gar.hook_after
    end
  end
end