module PubdraftHelper
  def pubdraft_states_for_select(klass)
    klass.pubdraft_states.map(&:to_select_option)
  end

  def pubdraft_state_options(klass)
    options_for_select pubdraft_states_for_select(klass)
  end

  def state_label(state)
    content_tag :span, state, class: "state-label #{state.downcase}"
  end
end
