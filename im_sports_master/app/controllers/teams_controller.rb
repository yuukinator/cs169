class TeamsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :set_league
  before_filter :set_division
  # GET /teams
  # GET /teams.json
  def index
    @teams = @division.teams.where(:placeholder=>false)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  def invite
    @team = Team.find_by_id(params[:team_id])
    user = User.find_by_email(params[:to_invite])
    invitation = Invitation.new('user' => user, 'team' => @team)
    @team.invitations << invitation
    user.invitations << invitation
    flash[:notice] = "#{user.email} has been invited."
    redirect_to [@league, @division, @team]
  end 

  def add_member
    @team = Team.find_by_id(params[:team_id])
    @user = User.find_by_id(params[:user_id])
    @invite = Invitation.find_by_id(params[:invite_id])
    @team.users << @user
    @user.invitations.delete(@invite)
    redirect_to @user, notice: "Successfully joined #{@team.name}"
  end

  # POST /teams
  # POST /teams.json
  def create
    params[:team][:placeholder] = false
    @team = Team.new(params[:team])

    if @team.save
      @division.teams << @team
      @team.users << current_user
      @division.replace_fake_team(@team)
      redirect_to [@league, @division, @team], notice: 'Team was successfully created.' 
    else
      render action: "new"
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(params[:team])
      redirect_to [@league, @division, @team], notice: 'Team was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @division.restore_fake_team(@team)
    @team.destroy

    redirect_to league_division_teams_url
  end

  private
    def set_league
      @league = League.find_by_id(params[:league_id])
    end

    def set_division
      @division = Division.find_by_id(params[:division_id])
    end
end
