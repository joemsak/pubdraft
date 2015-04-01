require "pubdraft/version"
require "pubdraft/engine"

module Pubdraft
  module InstanceMethods
    def self.included(base)
      base.send :before_create, :set_pubdraft_state

      base.scope :published, lambda { base.where(:state => 'published') }
      base.scope :drafted,   lambda { base.where(:state => 'drafted') }
    end

    def published?
      state == 'published'
    end

    def drafted?
      state == 'drafted'
    end

    def publish!
      publish && save
    end

    def publish
      self.state = 'published'
    end

    def draft!
      draft && save
    end

    def draft
      self.state = 'drafted'
    end

    private
    def set_pubdraft_state
      return unless state.blank?
      publish
    end
  end

  module ClassMethods
    def pubdraft
      send(:include, InstanceMethods)
    end
  end
end
