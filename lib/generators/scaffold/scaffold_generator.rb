require "rails/generators/rails/scaffold/scaffold_generator"
require "generators/query/query_generator"
require 'generators/policy/policy_generator'

module Rails
  module Generators
    class ScaffoldGenerator < ResourceGenerator
      # create a query object with the rest of the scaffold
      def create_query
        QueryGenerator.start [name, "--as-resource"], behavior: behavior
      end

      # create a policy for the resource
      def create_policy
        PolicyGenerator.start [name, *attributes_names], behavior: behavior
      end
    end
  end
end
