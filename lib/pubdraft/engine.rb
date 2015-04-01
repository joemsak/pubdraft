module Pubdraft
  class Engine < ::Rails::Engine
    isolate_namespace Pubdraft

    initializer 'pubdraft.action_controller',
                :before => :load_config_initializers do
      ::ActiveSupport.on_load :action_controller do
        helper PubdraftHelper
      end
    end

    initializer 'pubdraft.extend_active_record',
                :after => :load_config_initializers do
      ::ActiveSupport.on_load :active_record do
        ::ActiveRecord::Base.extend(::Pubdraft::ClassMethods)
      end
    end
  end
end