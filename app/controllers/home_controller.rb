require "catalog_filter"
class HomeController < ApplicationController
  def load_xml
    parser = Nokogiri::XML::SAX::Parser.new(CatalogFilter.new)
    parser.parse(File.open("#{Rails.root}/public/example.xml"))
    render json: {success: true}
  end
end

