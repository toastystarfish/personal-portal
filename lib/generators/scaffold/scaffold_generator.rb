require "rails/generators/rails/scaffold/scaffold_generator"
require "generators/query/query_generator"

module Rails
  module Generators
    class ScaffoldGenerator < ResourceGenerator
      # create a query object with the rest of the scaffold
      def create_query
        QueryGenerator.start [name, "--as-resource"], behavior: behavior
      end
    end
  end
end
