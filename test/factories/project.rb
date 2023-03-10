# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { 'Test Title' }

    trait :active do
      after(:create) { |project| project.transition_to! :active }
    end

    trait :cancelled do
      after(:create) { |project| project.transition_to! :cancelled }
    end

    trait :complete do
      after(:create) do |project|
        project.transition_to! :active
        project.transition_to! :complete
      end
    end

    trait :on_hold do
      after(:create) { |project| project.transition_to! :on_hold }
    end
  end
end
