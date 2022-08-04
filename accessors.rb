# frozen_string_literal: true

# gggg
module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # fffffff
  module ClassMethods
    attr_accessor :all_validates

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          v = instance_variable_get("@#{name}_history")
          v ||= []
          v << value
          instance_variable_set("@#{name}_history", v)
          instance_variable_set(var_name, value)
        end

        define_method("#{name}_history".to_sym) do
          instance_variable_get("@#{name}_history") || []
        end
      end
    end

    def strong_attr_acessor(name, clas)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| value.instance_of?(clas) ? instance_variable_set(var_name, value) : (puts "Err") }
    end
  end

  # ljh
  module InstanceMethods
    def history
      puts "Saved = #{self.saved}"
    end
  end
end

class Test
  include Accessors

  attr_accessor_with_history :as, :hff
end

Test.attr_accessor_with_history :a, :i
t = Test.new
t1 = Test.new

Test.strong_attr_acessor(:d, Integer)
Test.strong_attr_acessor(:hd, String)
t.hd = 'hh'
t.d = 6

t.a = 6
t.a = 9
t.a = 8
puts t.a_history

t1.a = 1
t1.a = 2
t1.a = 3
puts t1.a_history
# puts t.instance_variables
