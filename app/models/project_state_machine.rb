class ProjectStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :active
  state :cancelled
  state :complete
  state :on_hold

  transition from: :draft,     to: [:active, :cancelled, :on_hold]
  transition from: :active,    to: [:draft, :cancelled, :complete, :on_hold]
  transition from: :cancelled, to: :draft
  transition from: :complete,  to: :active
  transition from: :on_hold,   to: [:draft, :active, :cancelled, :complete]

end