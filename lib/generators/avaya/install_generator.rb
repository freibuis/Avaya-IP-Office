module Avaya
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      desc "This generator creates an initializer file for Avaya Gem -> config/initializers/avaya.rb"

      def copy_initializer
        template 'initializer.rb', 'config/initializers/avaya.rb'
      end

      def self.banner
        "rails generate avaya:install"
      end


    end
  end
end