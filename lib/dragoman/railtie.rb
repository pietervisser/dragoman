module Dragoman

  class Railtie < Rails::Railtie
    initializer 'dragoman.insert_into_routing_mapper' do |app|
      ActionDispatch::Routing::Mapper.send :include, Dragoman::Mapper
    end
  end

end