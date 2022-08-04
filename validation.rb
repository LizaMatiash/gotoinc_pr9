# frozen_string_literal: true

# gggg
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :all_validates
    def validate(atr, type, arg= '')


      validation = "#{atr}_#{type}".to_sym

      puts validation

      # presence
      case type
      when :presence
        define_method(validation) do
          !instance_variable_get("@#{atr}").nil?
        end
      when :format
        define_method(validation) do
          # puts instance_variable_get("@#{atr}")
          instance_variable_get("@#{atr}") =~ arg
        end
      when :type
        define_method(validation) do
          instance_variable_get("@#{atr}").instance_of?(arg)
        end
      end

      self.all_validates ||= []
      self.all_validates << validation

      # puts all_validates
      # @number = number
      # @format = format
      # @valid = valid
    end


  end

  # Fg
  module InstanceMethods
    def validate!
      # validate
      self.class.all_validates.each do |valid|
        raise "Number can't be that" unless send(valid)
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end
  end
end

# class Test
#   include Validation
#   attr_accessor :name
#
#   validate :name, :type, Integer
#   # validate :name, :presence
#
#   def initialize(name)
#     @name = name
#     validate!
#   end
# end
# #
# g = Test.new(12453)
# k = Test.new('124-35')
# g = Test.new(k)
# puts g.class
# 1.to_s
# # g.name = nil
# g.validate!
# g = Test.new('1243')
# g.validate!
