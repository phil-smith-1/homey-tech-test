# frozen_string_literal: true

# Statesman state machine definition for Project
class ProjectStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :active
  state :cancelled
  state :complete
  state :on_hold

  transition from: :draft,     to: %i[active cancelled on_hold]
  transition from: :active,    to: %i[draft cancelled complete on_hold]
  transition from: :cancelled, to: :draft
  transition from: :complete,  to: :active
  transition from: :on_hold,   to: %i[draft active cancelled complete]

  after_transition do |project, transition|
    Event.new(project: project, eventable: transition).save
  end
end
