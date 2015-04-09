# Copyright (c) 2015 Julio Lopez

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
module Garfio
  VERSION = "1.0.0"

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
      return_value = send "old_#{original_method}", *args
      _v.is_a?(Proc) ? instance_eval(&_v) : send(_v) if _v = gar.hook_after
      return_value
    end
  end
end