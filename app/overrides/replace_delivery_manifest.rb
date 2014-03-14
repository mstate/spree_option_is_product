manifest_items_price = <<TEXT
<% debugger %>
  <%= display_price(item.line_item.price).to_html %>
TEXT
# manifest_items_price = <<TEXT
#   <%= Spree::Money.new(item.line_item.price).to_html %>
# TEXT
Deface::Override.new(
  # :virtual_path => 'spree/checkout/_line_item_manifest',
  :virtual_path => 'spree/checkout/_delivery',
  :name  => "replace_delivery_manifest_price",
  :replace_contents => "td.item-price",
  :text => manifest_items_price,
  :original => '791797226a3cfd68d45526c67d1fea2470aafbfc'
)
manifest_items_thumb = <<TEXT
  <% if(item.line_item.parent_id.nil? == false) %>
    <td class="line_item_arrow_bottom">
      <div class="middle-arrow-select">
      </div>
    </td>
  <% else %>
    <td class="item-image"><%= mini_image(item.variant) %></td>
  <% end %>
TEXT
order_details_items_thumb = <<TEXT
  <% if(item.parent_id.nil? == false) %>
    <td data-hook="order_item_image" class="line_item_arrow_bottom">
      <div class="middle-arrow-select">
      </div>
    </td>
  <% else %>
    <td data-hook="order_item_image">
      <% if item.variant.images.length == 0 %>
        <%= link_to small_image(item.variant.product), item.variant.product %>
      <% else %>
        <%= link_to image_tag(item.variant.images.first.attachment.url(:small)), item.variant.product %>
      <% end %>
    </td>
  <% end %>
TEXT
Deface::Override.new(
  :virtual_path => 'spree/checkout/_line_item_manifest',
  :name  => "replace_delivery_manifest_thumb",
  :replace => "td.item-image",
  :text => manifest_items_thumb,
)
Deface::Override.new(
  :virtual_path => 'spree/shared/_order_details',
  :name  => "replace_delivery_confirm_manifest_thumbs",
  :replace => "td[data-hook='order_item_image']",
  :text => order_details_items_thumb
)
Deface::Override.new(
  :virtual_path => 'spree/shared/_order_details',
  :name  => "replace_delivery_confirm_manifest_details",
  :set_attributes => "td[data-hook='order_item_description']",
  :attributes => {:class => 'order_item_description'}
)

Deface::Override.new(
  :virtual_path => 'spree/admin/orders/_shipment_manifest',
  :name  => "replace_line_item_find",
  :replace => "erb[silent]:contains('line_item = order.find_line_item_by_variant_for_options(item.variant)')",
  :text => "<% line_item = order.line_items.find_by(variant: item.variant) %>",
)

