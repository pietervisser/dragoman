module Dragoman
  module MapperRails4

    include Mapper

    def self.included(base)
      base.send :alias_method_chain, :add_route, :localization
      base.send :alias_method_chain, :scope, :localization

      base.send :alias_method_chain, :resources, :localization

      base::Mapping.extend Mapping
      base::Mapping.class_eval do
        class << self
          alias_method_chain :build, :localization
        end
      end
    end

  end
end