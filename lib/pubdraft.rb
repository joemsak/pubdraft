require "pubdraft/version"
require "pubdraft/engine"
require "pubdraft/state"
require "pubdraft/model"

module Pubdraft
  def pubdraft(**options)
    include Model::InstanceMethods
    extend Model::ClassMethods

    cattr_accessor :pubdraft_states
    cattr_accessor :pubdraft_options

    before_create :set_pubdraft_default,
              unless: -> { pubdraft_options[:default] == false }

    states = options.delete(:states) || Pubdraft.default_states

    self.pubdraft_states = State.new_set(states)
    self.pubdraft_options = Pubdraft.default_options.merge(options)

    build_pubdraft_methods!
  end

  def self.default_states
    { drafted: :draft, published: :publish }
  end

  def self.default_options
    { field: 'state', default: 'published' }
  end
end
