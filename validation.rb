# frozen_string_literal: true

# gggg
module Validation
  def self.included(base)
    base.send :include, InstanceMethods
  end

  def validate(number, format, valid)
    @number = number
    @format = format
    @valid = valid
  end

  # Fg
  module InstanceMethods
    def validate!
      # validate
      raise "Number can't be that" if @number !~ @valid

      true
    end

    def valid?
      validate!
    rescue
      false
    end
  end
end

class Test
  include Validation

  def initialize(number)
    validate number, :format, /^[a-z 0-9]{3}-?[a-z 0-9]{2}$/i
    validate!
  end

end
#
# g = Test.new('12346')
# g.validate
