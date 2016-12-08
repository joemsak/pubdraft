module Pubdraft
  class State
    attr_reader :action, :name

    def initialize(name:, action:)
      @name, @action = name, action
    end

    def self.new_set(states_hash)
      states_hash.map do |name, action|
        State.new(name: name, action: action)
      end
    end

    def to_select_option
      ["#{name}".titleize, name]
    end
  end
end
