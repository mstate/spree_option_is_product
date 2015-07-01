Spree::OrderContents.class_eval do

  def add(variant, quantity=1, options={})
    # force spree to create a new line item for products that are options instead of adding the quantity to those already on the order.
    line_item = options[:force_new_line_item] ? nil : order.find_line_item_by_variant_for_options(variant)
    line_item = add_to_line_item(line_item, variant, quantity, options)
    after_add_or_remove(line_item, options)
  end

  # Override from spree's original method to add the `price` argument passed by `add`
  # def add_to_line_item(variant, quantity, options = {})
  # def add_to_line_item(line_item, variant, quantity, currency=nil, shipment=nil, price=nil)

  private

  def add_to_line_item(line_item, variant, quantity, options={})
    if line_item
      line_item.quantity += quantity.to_i
      line_item.currency = currency unless currency.nil?
    else
      opts = ActionController::Parameters.new(options).
                permit((Spree::PermittedAttributes.line_item_attributes << :price).uniq)
      line_item = order.line_items.new(quantity: quantity,
                                        variant: variant,
                                        options: opts)
      line_item.target_shipment = options[:shipment] if options.has_key? :shipment
    end
    line_item.save!

    # set currency if line_item didn't take care of it.
    line_item.update_attributes(currency: order.currency) if line_item.currency.nil?

    order.reload

    line_item
  end

end
