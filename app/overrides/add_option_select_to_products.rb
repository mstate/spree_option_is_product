Deface::Override.new(
  :virtual_path => "spree/products/show",
  :name         => "add_option_select_to_products",
  :insert_after => "[data-hook='product_right_part_wrap'] #product-description",
  # :insert_before => 'erb[silent]:contains("@product.variants_and_option_values(current_currency).any")', #product_price',#' #inside-product-cart-form",
  :partial      => "spree/products/options_display",
  :original     => '52effc5c43a81b8283f5a315656b29408546620b'
)
