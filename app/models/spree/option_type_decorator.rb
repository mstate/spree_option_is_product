Spree::OptionType.class_eval do
  # attr_accessible :product_based, :optional #removed for rails 4 compatibility
  scope :product_based, where(:product_based => true)
end
