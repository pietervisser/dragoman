require 'spec_helper'

class ProductsController < ApplicationController
end

describe 'routes' do

  context "unlocalized routes" do
    it 'does not change routes' do
      expect(comments_path).to eq '/comments'
      expect(Rails.application.routes.url_helpers.respond_to? :comments_nl_path).to eq false
    end
  end

  it 'translates resources' do
    expect(products_en_path).to eq '/products'
    expect(new_product_en_path).to eq '/products/new'
    expect(edit_product_en_path(1)).to eq '/products/1/edit'
    expect(products_nl_path).to eq '/producten'
    expect(new_product_nl_path).to eq '/producten/nieuw'
    expect(edit_product_nl_path(1)).to eq '/producten/1/wijzigen'
  end

  it 'translates resource' do
    expect(account_en_path).to eq '/account'
    expect(edit_account_en_path).to eq '/account/edit'
    expect(new_account_en_path).to eq '/account/new'
    expect(account_nl_path).to eq '/profiel'
    expect(edit_account_nl_path).to eq '/profiel/wijzigen'
    expect(new_account_nl_path).to eq '/profiel/nieuw'
  end

  it 'translates namespaced routes' do
    expect(admin_customers_nl_path).to eq '/beheer/klanten'
    expect(admin_customers_en_path).to eq '/admin/customers'
  end

  it 'translates scoped routes' do
    expect(payments_nl_path).to eq '/geheim/betalingen'
    expect(payments_en_path).to eq '/secret/payments'
  end

  it 'sets the correct locale' do
    assert_routing '/producten', :controller => 'products', :action => 'index', :locale => :nl
    assert_routing '/products', :controller => 'products', :action => 'index', :locale => :en
  end

  describe 'adds untranslated path helpers' do
    it 'uses the I18n locale' do
      I18n.locale = :nl
      expect(payments_path).to eq '/geheim/betalingen'
    end
  end

  describe 'adds untranslated url helpers' do
    it 'uses the I18n locale' do
      print_routes
      I18n.locale = :nl
      expect(payments_url).to eq 'http://example.com/geheim/betalingen'
    end
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