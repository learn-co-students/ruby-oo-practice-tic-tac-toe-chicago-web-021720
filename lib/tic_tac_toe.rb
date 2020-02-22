class TicTacToe
    attr_accessor :board
    WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    def initialize
        @board = create_board
    end

    def display_board
        puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
        puts "-----------"
        puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
        puts "-----------"
        puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
    end

    def turn
        user_input = gets.chomp
        user_input_index = self.input_to_index(user_input)
        if valid_move?(user_input_index) == false || position_taken?(user_input_index) == true
            self.turn
        else
            self.move(user_input_index, self.current_player)
            self.display_board
        end
    end
    
    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def turn_count
        self.board.count {|position| position != " "}
    end

    def current_player
        if self.turn_count.even? == true
            return "X"
        else
            return "O"
        end
    end

    def move(user_input_index, x_or_o)
        self.board[user_input_index] = x_or_o
    end

    def valid_move?(user_input_index)
        if position_taken?(user_input_index) == true || user_input_index > 8 || user_input_index < 0
            return false
        else
            return true
        end
    end

    def position_taken?(user_input_index)
        if self.board[user_input_index] == " "
            return false
        else
            return true
        end
    end

    def over?
        if self.won? || self.draw? == true
            return true
        else
            return false
        end
    end

    def winner
        winning_combo = self.won?
        if winning_combo == false
            return nil
        else
            return self.board[winning_combo[0]]
        end
    end

    def won?
        #find all positions occupied by the current player and return array of indices
        #for each win combo, search for same combo in player positions
        #return true of there are any matches
        winning_combo = WIN_COMBINATIONS.find do |combo|
            win_combo_on_board?(combo, "X") == true || win_combo_on_board?(combo, "O") == true
        end
        if winning_combo == nil
            return false
        else
            return winning_combo
        end
    end

    def full?
        !self.board.any?(" ")
    end

    def draw?
        if self.full? == true && self.won? == false
            return true
        else
            return false
        end
    end

    def play
        while self.over? == false do
            self.turn
        end
        if self.draw? == true
            puts "Cat's Game!"
        else
            puts "Congratulations #{self.winner}!"
        end     
    end

    private

    def create_board
        [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def win_combo_on_board?(combo, x_or_o)
        boolean_array = combo.map do |position|
            self.board[position] == x_or_o
        end
        if boolean_array == [true, true, true]
            return true
        else
            return false
        end
    end
end