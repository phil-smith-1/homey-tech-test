# frozen_string_literal: true

# Model for polymorphic Event association
class Event < ApplicationRecord
  belongs_to :eventable, polymorphic: true
  belongs_to :project
end
