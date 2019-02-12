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
        puts attributes
        PolicyGenerator.start [name], attributes_names: attributes_names
        # Pundit::Generators::PolicyGenerator.start options[:model_name]
        #
        # inject_into_file "app/policies/#{name}_policy.rb", after: "  def permitted_attributes\n" do
        #   "    [#{attributes_names.map { |name| ":#{name}" }.join(', ')}]\n"
        # end
      end
    end
  end
end
