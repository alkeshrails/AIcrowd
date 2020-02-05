class LeaderboardsController < ApplicationController
  before_action :authenticate_participant!,
                except: :index
  before_action :set_challenge
  respond_to :js, :html

  def index
    @current_round    = current_round
    @post_challenge   = true if @challenge.completed? && params[:post_challenge] == "true"
    @challenge_rounds = @challenge.challenge_round_summaries.where(round_status_cd: ['history', 'current'])

    current_round_id = if @current_round.blank?
                         0
                       else
                         @current_round.id
                       end
    @leaderboards = if @post_challenge == 'on'
                      policy_scope(OngoingLeaderboard)
                          .where(challenge_round_id: current_round_id)
                          .page(params[:page])
                          .per(10)
                          .order(:seq)
                    else
                      policy_scope(Leaderboard)
                          .where(challenge_round_id: current_round_id)
                          .page(params[:page])
                          .per(10)
                          .order(:seq)
                    end

    if @challenge.challenge == "NeurIPS 2019 : Disentanglement Challenge"
      @leaderboards = DisentanglementLeaderboard
                          .where(challenge_round_id: @current_round)
                          .page(params[:page])
                          .per(10)
                          .order(:row_num)
    end
  end

  private

  def set_challenge
    @challenge = Challenge.friendly.find(params[:challenge_id])
  end

  def current_round
    if params[:challenge_round_id].present?
      ChallengeRound.find(params[:challenge_round_id].to_i)
    else
      @challenge.challenge_rounds.where(active: true).first
    end
  end
end
