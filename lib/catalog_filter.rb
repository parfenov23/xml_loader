class CatalogFilter < Nokogiri::XML::SAX::Document
  def start_document
    @categories = []
    @products = []
    @offer_open = false
  end

  def start_element(name, attrs = [])
    attrs = attr_to_hash(attrs)
    @current_tag_name = name
    case name
    when 'category'
      @category = {uuid: attrs["id"], parent_id: attrs["parentId"]}
    when 'offer'
      @offer_open = true
      @offer_metadata = {}
      @offer = {uuid: attrs["id"], available: attrs["available"]}
    end
  end

  def characters(data)
    if @category.present?
      @category[:title] = data
    end
    if @offer_open
      @offer_metadata[@current_tag_name] = data if data.present?
    end
  end

  def end_element(name)
    case name
    when 'category'
      @categories << @category
      @category = nil
    when 'offer'
      @offer_open = false
      @offer.merge!({
        title: @offer_metadata["name"], 
        picture: @offer_metadata["picture"], 
        price: @offer_metadata["price"], 
        url: @offer_metadata["url"],
        metadata: @offer_metadata.except("name", "picture", "price", "url", "available")
        })
      product = Product.new(@offer)
      if @offer_metadata["categoryId"].present?
        @offer_metadata["categoryId"].split("|").join("|").split("|").each do |category_id| # split and join (id646 or [id646, id648])
          product.categories_products.build(category_id: category_id )
        end
      end
      @products << product
    end
  end

  def end_document
    Category._import @categories
    Product._import @products
  end

  private

  def attr_to_hash(attrs)
    attrs.map{|attr| {"#{attr.first}" => attr.last}}.reduce({}, :merge)
  end
end