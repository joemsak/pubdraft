module Pubdraft
  module Model
    module ClassMethods
      def build_pubdraft_methods!
        field = pubdraft_options[:field]

        pubdraft_states.each do |state|
          scope state.name, -> { where(field => state.name) }

          define_method state.action do
            self[field] = state.name
          end

          define_method "#{state.action}!" do
            self.update(field => state.name)
          end

          define_method "#{state.name}?" do
            self[field] == "#{state.name}"
          end
        end
      end
    end

    module InstanceMethods
      private
      def set_pubdraft_default
        return unless self[pubdraft_options[:field]].blank?
        self[pubdraft_options[:field]] = pubdraft_options[:default]
      end
    end
  end
end
