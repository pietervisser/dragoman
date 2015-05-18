require 'spec_helper'

class ProductsController < ApplicationController; end
class VotesController < ApplicationController; end

describe 'routes' do

  context "unlocalized routes" do
    it 'does not change routes' do
      expect(comments_path).to eq '/comments'
      expect(Rails.application.routes.url_helpers.respond_to? :comments_nl_path).to eq false
    end
  end

  it 'translates resources' do
    expect(products_en_path).to eq '/en/products'
    expect(new_product_en_path).to eq '/en/products/new'
    expect(edit_product_en_path(id: 1)).to eq '/en/products/1/edit'
    expect(products_nl_path).to eq '/nl/producten'
    expect(new_product_nl_path).to eq '/nl/producten/nieuw'
    expect(edit_product_nl_path(id: 1)).to eq '/nl/producten/1/wijzigen'
  end

  it 'translates resource' do
    expect(account_en_path).to eq '/en/account'
    expect(edit_account_en_path).to eq '/en/account/edit'
    expect(new_account_en_path).to eq '/en/account/new'
    expect(account_nl_path).to eq '/nl/profiel'
    expect(edit_account_nl_path).to eq '/nl/profiel/wijzigen'
    expect(new_account_nl_path).to eq '/nl/profiel/nieuw'
  end

  it 'translates namespaced routes' do
    expect(admin_customers_nl_path).to eq '/nl/beheer/klanten'
    expect(admin_customers_en_path).to eq '/en/admin/customers'
  end

  it 'translates scoped routes' do
    expect(payments_nl_path).to eq '/nl/geheim/betalingen'
    expect(payments_en_path).to eq '/en/secret/payments'
  end

  it 'sets the correct locale' do
    expect(get: '/nl/producten').to route_to(controller: 'products', action: 'index', locale: 'nl')
    expect(get: '/nl/products').not_to be_routable
    expect(get: '/products').not_to be_routable
    expect(get: '/en/products').to route_to(controller: 'products', action: 'index', locale: 'en')
    expect(get: '/en/producten').not_to be_routable
  end

  it 'skips empty paths' do
    expect(empty_nl_path).to eq '/nl'
    expect(empty_en_path).to eq '/en'
  end

  it 'skips empty scopes' do
    expect(empty_books_nl_path).to eq '/nl/boeken'
    expect(empty_books_en_path).to eq '/en/books'
  end

  it 'looks up translations by the path option if present' do
    expect(edit_invitation_nl_path(id: 2)).to eq '/nl/uitnodigingen/2/accepteren'
  end

  it 'looks up resources translations by the path option if present' do
    expect(chairs_nl_path).to eq '/nl/stoelen'
    expect(chairs_en_path).to eq '/en/seats'
  end

  it 'translates shallow paths' do
    expect(driver_nl_path(id: 3)).to eq '/nl/snelle/bestuurders/3'
    expect(driver_en_path(id: 3)).to eq '/en/fast/drivers/3'
  end

  it 'skips blank translations' do
    expect(music_nl_path).to eq '/nl/music'
  end

  it 'uses the default path if no translation is present' do
    expect(sounds_en_path).to eq '/en/glitches'
    expect(sounds_nl_path).to eq '/nl/sounds'
  end

  it 'translates routes in the original order as specified in routes.rb' do
    expect(get: '/en/votes/positive').to route_to(action: 'positive', controller: 'votes', locale: 'en')
    expect(get: '/nl/votes/positief').to route_to(action: 'positive', controller: 'votes', locale: 'nl') # should use 'positive' action instead of 'show'
  end

  it 'uses the I18n locale to add untranslated path helpers' do
    I18n.locale = :nl
    expect(product_path(id: 1)).to eq '/nl/producten/1'
    expect(payments_path).to eq '/nl/geheim/betalingen'

    I18n.locale = :en
    expect(product_path(id: 1)).to eq '/en/products/1'
    expect(payments_path).to eq '/en/secret/payments'
  end

  it 'uses the I18n locale to add untranslated url helpers' do
    I18n.locale = :nl
    expect(product_url(id: 1)).to eq 'http://example.com/nl/producten/1'
    expect(payments_url).to eq 'http://example.com/nl/geheim/betalingen'

    I18n.locale = :en
    expect(product_url(id: 1)).to eq 'http://example.com/en/products/1'
    expect(payments_url).to eq 'http://example.com/en/secret/payments'
  end

end

def print_routes
  all_routes = Rails.application.routes.routes
  if Rails::VERSION::MAJOR >= 4
    require 'action_dispatch/routing/inspector'
    inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    puts '', inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
  else
    require 'rails/application/route_inspector'
    inspector = Rails::Application::RouteInspector.new
    puts inspector.format(all_routes, ENV['CONTROLLER']).join "\n"
  end
end