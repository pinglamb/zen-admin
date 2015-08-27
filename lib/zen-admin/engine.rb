require 'zen-admin/helpers'

module ZenAdmin
  class Engine < ::Rails::Engine
    initializer 'zen-admin.assets.precompile' do |app|
      %w(stylesheets javascripts zen-admin-libs).each do |sub|
        app.config.assets.paths << root.join('assets', sub).to_s
      end
    end

    initializer 'zen-admin.helpers' do |app|
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, ZenAdmin::Helpers::MatchingHelper
        ActionView::Base.send :include, ZenAdmin::Helpers::WhatIfHelper
        ActionView::Base.send :include, ZenAdmin::Helpers::UsefulHelper
      end
    end

    initializer 'zen-admin.inputs' do |app|
      if Object.const_defined?('SimpleForm')
        require 'zen-admin/inputs'
      end
    end
  end
end
