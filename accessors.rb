# frozen_string_literal: true

# gggg
module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # fffffff
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        saved = []
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          saved << instance_variable_get(var_name)
        end
        # -----------------------------------------------------------------------------------
        define_method("#{name}_history".to_sym) { puts "History #{name} = #{saved}" }
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

Test.strong_attr_acessor(:d, Integer)
Test.strong_attr_acessor(:hd, String)
t.hd = 'hh'
t.d = 6

t.a = 6
t.a = 9
t.a = 8
t.a_history

# puts t.instance_variables
