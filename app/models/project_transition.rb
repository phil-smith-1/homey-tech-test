# frozen_string_literal: true

# Statesman Transition model linked to Project
class ProjectTransition < ApplicationRecord
  # include Statesman::Adapters::ActiveRecordTransition

  # If your transition table doesn't have the default `updated_at` timestamp column,
  # you'll need to configure the `updated_timestamp_column` option, setting it to
  # another column name (e.g. `:updated_on`) or `nil`.
  #
  # self.updated_timestamp_column = :updated_on
  # self.updated_timestamp_column = nil

  belongs_to :project, inverse_of: :transitions
  has_one :event, as: :eventable, dependent: :destroy

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = project.transitions.order(:sort_key).last
    return if last_transition.blank?

    last_transition.most_recent = true
    last_transition.save
  end
end
