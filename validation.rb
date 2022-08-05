# frozen_string_literal: true

# gggg
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :all_validates, :message
    def validate(atr, type, arg= '')


      validation = "#{atr}_#{type}".to_sym
      # presence
      case type
      when :presence
        self.message ||= 'Error. Name can`t be nil'
        define_method(validation) do
          !instance_variable_get("@#{atr}").nil?
        end
      when :format
        self.message ||= "Error. Wrong name format. You need: #{arg}".to_s
        define_method(validation) do
          # puts instance_variable_get("@#{atr}")
          instance_variable_get("@#{atr}") =~ arg
        end
      when :type
        self.message ||= "Error. Wrong variable type. You need: #{arg}".to_s
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
        # puts
        raise puts self.class.message unless send(valid)
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
