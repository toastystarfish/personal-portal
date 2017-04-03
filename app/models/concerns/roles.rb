
require 'enum'

module Roles
  def self.included base
    base.extend ClassMethods
  end

  def roles= roles
    self.roles_mask = self.class.enum_to_int roles
  end

  def roles
    self.class.roles.to_h.reject { |r,i|
      ((self.roles_mask || 0) & i).zero?
    }.keys
  end

  def has_role? role
    bits = (self.roles_mask & self.class.roles[role])
    !(bits || 0).zero?
  end

  def add_role role
    self.roles_mask |= self.class.enum_to_int(role)
  end

  module ClassMethods
    def define_roles *roles
      @roles = Enum.new(*roles.insert(1, 0))
      roles.each do |r|
        define_method :"#{r}?" do
          self.has_role? r
        end
      end
    end

    def all_roles
      @roles.symbols
    end

    def roles
      Enum.new(*all_roles.flat_map {|r| [r, 2**@roles[r]]})
    end

    def enum_to_int roles
      Array(roles).reduce(0) do |bin, p|
        bin |= 2 ** (@roles[p] || 0)
      end
    end
  end
end
