module PubdraftHelper
  def pubdraft_states_for_select(klass)
    klass.pubdraft_states.map(&:to_select_option)
  end

  def pubdraft_state_options(klass)
    options_for_select pubdraft_states_for_select(klass)
  end
end
