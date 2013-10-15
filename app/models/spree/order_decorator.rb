Spree::Order.class_eval do
  # since we reverted this method a thousand times here is the basic breakdown of why you shouldn't try it anymore:
  # - OrderContents.add will try to assign more quantity to an already create line_item, consider the following scenario:
  # Product X is added with option A to the cart
  # Product Y which is the product inside the option A is added to the cart
  # IF this override is not in place the quantity of option A of product X will
  # with this override, it will create a new line item separate from that of the Product X kit
  #
  # a check was introduced to set the default behavior to filter out non parent items ( which is good for the example above ) that is needed to be able to remove options from products inside an order, like the following example:
  # - Product X is added to cart with Option A
  # - Customer wants to remove Option A
  # - If this new default check isn't in place we won't find any matches
  # - With this change in the default behavior we will always find them and be able to remove them

  def find_line_item_by_variant(variant, only_parents = true)
    line_items.detect do |line_item|
      if only_parents
        (line_item.variant_id == variant.id) && line_item.parent.blank? && line_item.children.blank?
      else
        line_item.variant_id == variant.id
      end
    end
  end
end
