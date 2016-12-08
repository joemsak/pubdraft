require "pubdraft/version"
require "pubdraft/engine"
require "pubdraft/state"

module Pubdraft
  module InstanceMethods
    def self.included(base)
      base.cattr_accessor :pubdraft_states
      base.cattr_accessor :pubdraft_options

      base.send :before_create, :set_pubdraft_default,
                unless: -> { pubdraft_options[:default] == false }
    end

    private
    def set_pubdraft_default
      return unless self[pubdraft_options[:field]].blank?
      self[pubdraft_options[:field]] = pubdraft_options[:default]
    end
  end

  module ClassMethods
    def pubdraft(**options)
      send(:include, InstanceMethods)

      states = options.delete(:states) || {
        drafted: :draft,
        published: :publish
      }

      default_options = { field: 'state', default: 'published' }

      self.pubdraft_states = State.new_set(states)
      self.pubdraft_options = default_options.merge(options)

      build_state_methods
    end

    private

    def build_state_methods
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
end
