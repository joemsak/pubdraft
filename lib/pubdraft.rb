require "pubdraft/version"

module Pubdraft
  module InstanceMethods
    def self.included(base)
      base.send :before_create, :set_pubdraft_state
      base.attr_accessible :state

      base.scope :published, base.where(:state => 'published')
      base.scope :drafted,   base.where(:state => 'drafted')
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

  module HelperMethods
    def pubdraft_states_for_select
      [['Published', 'published'], ['Drafted', 'drafted']]
    end

    def pubdraft_state_options
      options_for_select(pubdraft_states_for_select)
    end
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.extend Pubdraft::ClassMethods
  end

  if defined?(ActionView::Base)
    ActionView::Base.send(:include, Pubdraft::HelperMethods)
  end
end
