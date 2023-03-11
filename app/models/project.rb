# frozen_string_literal: true

# Model for Projects
class Project < ApplicationRecord
  has_many :transitions, class_name: 'ProjectTransition', autosave: false, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :comments, through: :events, source: :eventable, source_type: 'Comment'

  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: ProjectTransition,
    initial_state: :draft
  ]

  # Initialize the state machine
  def state_machine
    @state_machine ||= ProjectStateMachine.new(self, transition_class: ProjectTransition,
                                                     association_name: :transitions)
  end

  # Optionally delegate some methods

  delegate :can_transition_to?,
           :current_state, :history, :last_transition, :last_transition_to,
           :transition_to!, :transition_to, :in_state?, to: :state_machine
end
