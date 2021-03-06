Spree::OptionValue.class_eval do
  belongs_to :variant
  # attr_accessible :variant_id, :special_price, :quantity, :default_option #removed for rails 4 compatibility

  def is_a_variant?
    !variant_id.blank?
  end

  def to_hash
    {
      :id             => id,
      :presentation   => presentation,
      :quantity       => quantity,
      :variant_id     => variant_id,
      :state          => variant.default_stock_state,
      :available      => variant.default_stock_item.available?,
      :price          => special_price || variant.price,
      :default_option => default_option,
    }
  end
end
