class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)
	strategies = ['r', 'p', 's']
	p1move = player1[1].downcase
	p2move = player2[1].downcase
	if strategies.include?(p1move) == false
		raise RockPaperScissors::NoSuchStrategyError, ("Strategy must be one of R,P,S")
	end
	if strategies.include?(p2move) == false
		raise RockPaperScissors::NoSuchStrategyError, ("Strategy must be one of R,P,S")
	end
	if p1move == "r"
		if p2move == "r"
			return player1
		elsif p2move == "s"
			return player1
		elsif p2move == "p"
			return player2
		end
	elsif p1move  == "s"
		if p2move == "r"
			return player2
		elsif p2move == "s"
			return player1
		elsif p2move == "p"
			return player1
		end
	elsif p1move == "p"
		if p2move == "r"
			return player1
		elsif p2move == "s"
			return player2
		elsif p2move == "p"
			return player1
		end
	end
  end

  def self.tournament_winner(tournament)
	#base case
	if tournament[0][1].class == String
		if tournament[0][1].length == 1
			winner(tournament[0], tournament[1])
		end
	
	else
		t1 = tournament_winner(tournament[0])
		t2 = tournament_winner(tournament[1])
		tournament_winner([t1, t2])
	end
  end

end
