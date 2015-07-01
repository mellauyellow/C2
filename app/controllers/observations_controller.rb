class ObservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_proposal
  before_action ->{authorize @proposal, :can_edit!}


  def index
    @observer = User.new
    @observation = Observation.new(user: @observer, proposal: @proposal)
  end

  def create
    observation = @proposal.add_observer(params[:observation][:user][:email_address])
    Dispatcher.on_observer_added(observation)

    observer = observation.user
    flash[:success] = "#{observer.full_name} has been added as an observer"
    # TODO store an activity comment
    redirect_to proposal_observations_path(@proposal)
  end

  # TODO allow them to be removed


  protected

  def find_proposal
    @proposal ||= Proposal.find(params[:proposal_id])
  end
end
