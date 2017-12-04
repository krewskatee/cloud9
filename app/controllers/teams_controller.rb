class TeamsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_rescue

  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
  end

  def show
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      UserTeam.create(user_id: current_user.id, team_id: @team.id)
      flash[:success] = "Succesfully created post."
      redirect_to '/teams'
    else
      @team.errors.full_messages.each do |error|
        flash[:danger] = "#{error}"
        redirect_to "/teams/new"
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team_users = UserTeam.where(team_id: @team.id)
    @user_team.destroy_all
    @team.destroy
    flash[:success] = "Succesfully disbanded Team"
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end


end
