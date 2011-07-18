module ActsAsKeyValue
  module Generators
    class KeyValueGenerator < Rails::Generators::Base
      namespace "key_value"
      source_root File.expand_path("../../templates", __FILE__)

      desc "Generates a model with the given NAME (if one does not exist) with devise " <<
           "configuration plus a migration file and devise routes."
      end
    end
  end
end 