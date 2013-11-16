Spree::OrderContents.class_eval do

  def add(variant, quantity=1, currency=nil, shipment=nil, price=nil, force_new_line_item=false)
    # force spree to create a new line item for products that are options instead of adding the quantity to those already on the order.
    line_item = force_new_line_item ? nil : order.find_line_item_by_variant(variant)
    line_item = add_to_line_item(line_item, variant, quantity, currency, shipment, price)
    # line_item = add_to_line_item(variant, quantity, currency, shipment)
    # order_updater.update_item_total
    order.update_totals
    # Spree::PromotionHandler::Cart.new(order, line_item).activate
    # Spree::ItemAdjustments.new(line_item).update
    # reload_totals
    line_item
  end

  # Override from spree's original method to add the `price` argument passed by `add`
  def add_to_line_item(line_item, variant, quantity, currency=nil, shipment=nil, price=nil)
    if line_item
      line_item.target_shipment = shipment
      line_item.quantity += quantity.to_i
      line_item.currency = currency unless currency.nil?
      line_item.save
    else
      line_item = order.line_items.new(quantity: quantity, variant: variant)
      # line_item = Spree::LineItem.new(quantity: quantity)
      line_item.target_shipment = shipment
      line_item.variant = variant
      if currency
        line_item.currency = currency unless currency.nil?
        line_item.price    = price || variant.price_in(currency).amount
      else
        line_item.price    = price || variant.price
      end
      # order.line_items << line_item
      # line_item
    end
    
    line_item.save
    order.reload
    line_item
  end

end