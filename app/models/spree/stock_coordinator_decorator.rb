# module Spree
#   module Stock
#     class Coordinator
#     	def build_packages(packages = Array.new)
# 			  StockLocation.active.each do |stock_location|
# 			    next unless stock_location.stock_items.where(:variant_id => order.line_items.pluck(:variant_id)).exists?

# 			    packer = build_packer(stock_location, order)
# 			    packages += packer.packages
# 			  end
# 		  	debugger
# 			  packages
# 			end
# 		end
# 	end
# end