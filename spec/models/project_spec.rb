# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { is_expected.to have_many(:comments) }

  describe 'state transitions' do
    it { is_expected.to have_many(:transitions) }

    context 'when draft' do
      let(:project) { create :project }

      it 'is in state draft by default' do
        expect(project.current_state).to eq('draft')
      end

      it 'can transition from draft to active' do
        expect do
          project.transition_to!(:active)
        end.to change(project, :current_state).from('draft').to('active')
      end

      it 'can transition from draft to cancelled' do
        expect do
          project.transition_to!(:cancelled)
        end.to change(project, :current_state).from('draft').to('cancelled')
      end

      it 'can transition from draft to on hold' do
        expect do
          project.transition_to!(:on_hold)
        end.to change(project, :current_state).from('draft').to('on_hold')
      end

      it 'cannot transition from draft to complete' do
        expect { project.transition_to!(:complete) }.to raise_error(Statesman::TransitionFailedError)
      end
    end

    context 'when active' do
      let(:project) { create :project, :active }

      it 'can transition from active to draft' do
        expect do
          project.transition_to!(:draft)
        end.to change(project, :current_state).from('active').to('draft')
      end

      it 'can transition from active to cancelled' do
        expect do
          project.transition_to!(:cancelled)
        end.to change(project, :current_state).from('active').to('cancelled')
      end

      it 'can transition from active to complete' do
        expect do
          project.transition_to!(:complete)
        end.to change(project, :current_state).from('active').to('complete')
      end

      it 'can transition from active to on hold' do
        expect do
          project.transition_to!(:on_hold)
        end.to change(project, :current_state).from('active').to('on_hold')
      end
    end

    context 'when cancelled' do
      let(:project) { create :project, :cancelled }

      it 'can transition from cancelled to draft' do
        expect do
          project.transition_to!(:draft)
        end.to change(project, :current_state).from('cancelled').to('draft')
      end

      it 'cannot transition from cancelled to active' do
        expect { project.transition_to!(:active) }.to raise_error(Statesman::TransitionFailedError)
      end

      it 'cannot transition from cancelled to complete' do
        expect { project.transition_to!(:complete) }.to raise_error(Statesman::TransitionFailedError)
      end

      it 'cannot transition from cancelled to on hold' do
        expect { project.transition_to!(:on_hold) }.to raise_error(Statesman::TransitionFailedError)
      end
    end

    context 'when complete' do
      let(:project) { create :project, :complete }

      it 'can transition from complete to active' do
        expect do
          project.transition_to!(:active)
        end.to change(project, :current_state).from('complete').to('active')
      end

      it 'cannot transition from cancelled to draft' do
        expect { project.transition_to!(:draft) }.to raise_error(Statesman::TransitionFailedError)
      end

      it 'cannot transition from cancelled to complete' do
        expect { project.transition_to!(:complete) }.to raise_error(Statesman::TransitionFailedError)
      end

      it 'cannot transition from cancelled to on hold' do
        expect { project.transition_to!(:on_hold) }.to raise_error(Statesman::TransitionFailedError)
      end
    end

    context 'when on hold' do
      let(:project) { create :project, :on_hold }

      it 'can transition from on hold to active' do
        expect do
          project.transition_to!(:active)
        end.to change(project, :current_state).from('on_hold').to('active')
      end

      it 'can transition from on hold to draft' do
        expect do
          project.transition_to!(:draft)
        end.to change(project, :current_state).from('on_hold').to('draft')
      end

      it 'can transition from on hold to cancelled' do
        expect do
          project.transition_to!(:cancelled)
        end.to change(project, :current_state).from('on_hold').to('cancelled')
      end

      it 'can transition from on hold to complete' do
        expect do
          project.transition_to!(:complete)
        end.to change(project, :current_state).from('on_hold').to('complete')
      end
    end
  end
end
