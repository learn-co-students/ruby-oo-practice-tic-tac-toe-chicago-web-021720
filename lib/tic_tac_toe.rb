class TicTacToe
    attr_accessor :board, :turn
    attr_reader

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [6, 4, 2]
    ]

    TOKENS = ["X", "O"]

    WIN_TRIPS = [["X", "X", "X"], ["O", "O", "O"]]

    def initialize()
        @board = [" "] * 9
    end

    def display_board
        a = []
        for i in (0...3)
            ro = @board.slice(3 * i, 3)
            a << " " + ro.join(" | ") + " "
        end
        puts a.join("\n-----------\n")
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        ["O", "X"].include?(@board[index])
    end

    def valid_move?(index)
        !self.position_taken?(index) && (0...9).include?(index)
    end

    def turn
        prompt = "Please enter an integer between 1 and 9: "
        print prompt
        while input = gets.chomp
            index = self.input_to_index(input)
            if input.match(/^[1-9]$/) && self.valid_move?(index)
                self.move(index, self.current_player)
                self.display_board
                break
            else
                print "Invalid move. " + prompt
            end
        end

    end

    def turn_count
        @board.count { |h| TOKENS.include?(h) }
    end

    def current_player
        TOKENS[self.turn_count % 2]
    end

    def won?
        pot = WIN_COMBINATIONS.find { |c| WIN_TRIPS.include?(c.map { |h| @board[h] }) }
        pot ||= nil
    end

    def full?
        !@board.find{ |h| !TOKENS.include?(h) }
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.won? || self.draw?
    end

    def winner
        self.won? ? @board[self.won?[0]] : nil
    end

    def play
        while !self.over?
            self.turn
        end
        
        if self.draw?
            puts "Cat's Game!"
        else
            puts "Congratulations #{self.winner}!"
        end

    end

end