# frozen_string_literal: true

# Model for comments
class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_one :event, as: :eventable, dependent: :destroy
end
