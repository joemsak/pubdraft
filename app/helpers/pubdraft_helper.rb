module PubdraftHelper
  def pubdraft_states_for_select
    [['Published', 'published'], ['Drafted', 'drafted']]
  end

  def pubdraft_state_options
    options_for_select(pubdraft_states_for_select)
  end
end