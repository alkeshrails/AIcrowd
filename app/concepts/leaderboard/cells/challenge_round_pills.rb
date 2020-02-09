class Leaderboard::Cell::ChallengeRoundPills < Leaderboard::Cell
  def show
    render :challenge_round_pills if challenge_rounds.count > 1
  end

  def challenge
    model
  end

  def current_round
    options[:current_round]
  end

  def challenge_rounds
    challenge.started_rounds
  end

  def tab_class(challenge_round)
    if challenge_round.id == current_round.id
      return 'nav-link active'
    else
      return 'nav-link'
    end
  end
end
