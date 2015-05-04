module Dragoman

  class Railtie < Rails::Railtie
    initializer 'dragoman.insert_into_routing_mapper' do |app|
      if Rails::VERSION::MAJOR >= 4
        ActionDispatch::Routing::Mapper.send :include, Dragoman::MapperRails4
      else
        ActionDispatch::Routing::Mapper.send :include, Dragoman::MapperRails3
      end
    end
  end

end