Spree::OrderContents.class_eval do

  def add(variant, quantity=1, currency=nil, shipment=nil, price=nil, force_new_line_item=false)
    line_item = force_new_line_item ? nil : order.find_line_item_by_variant(variant)
    add_to_line_item(line_item, variant, quantity, currency, shipment, price)
  end

    # we need to override this as well because we added a new check to be able to
    # detect children from inside kits
    def remove(variant, quantity=1, shipment=nil)
      line_item = order.find_line_item_by_variant(variant, false) #allow kit childrens to be removed

      unless line_item
        raise ActiveRecord::RecordNotFound, "Line item not found for variant #{variant.sku}"
      end

      remove_from_line_item(line_item, variant, quantity, shipment)
    end

  private

  # Override from spree's original method to add the `price` argument passed by `add`
  def add_to_line_item(line_item, variant, quantity, currency=nil, shipment=nil, price=nil)
    if line_item
      line_item.target_shipment = shipment
      line_item.quantity += quantity.to_i
      line_item.currency = currency unless currency.nil?
      line_item.save
    else
      line_item = Spree::LineItem.new(quantity: quantity)
      line_item.target_shipment = shipment
      line_item.variant = variant
      if currency
        line_item.currency = currency unless currency.nil?
        line_item.price    = price || variant.price_in(currency).amount
      else
        line_item.price    = price || variant.price
      end
      order.line_items << line_item
      line_item
    end

    order.reload
    line_item
  end

end