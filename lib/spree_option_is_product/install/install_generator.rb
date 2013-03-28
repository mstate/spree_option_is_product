module SpreeOptionIsProduct
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def add_javascripts
        append_file "app/assets/javascripts/admin/all.js", "//= require admin/option_types\n"
        append_file "app/assets/javascripts/admin/all.js", "//= require fancybox\n"
      end
      def add_stylesheets
        append_file "app/assets/stylesheets/admin/all.css", "*= admin/spree_option_is_product\n"
        append_file "app/assets/stylesheets/admin/all.css", "*= fancybox\n"
      def add_migrations
        run 'rake railties:install:migrations FROM=spree_option_is_product'
      end
      def run_migrations
        res = ask "Would you like to run the migrations now? [Y/n]"
        if res == "" || res.downcase == "y"
          run 'rake db:migrate'
        else
          puts "Skipping rake db:migrate, don't forget to run them before trying it."
        end
      end
    end
  end
end