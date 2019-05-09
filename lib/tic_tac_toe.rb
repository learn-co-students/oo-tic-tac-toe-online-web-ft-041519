require 'pry'


class TicTacToe 
  
  attr_accessor :board, :token
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],   
    [2,4,6]
  ]
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
 
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
 
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
 
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  
  def input_to_index(string)
    @index = (string.to_i)-1
  end
      
  def move (index, token ="X")
    @board[index] = token
  end

  def position_taken? (index)
    @board[index] == "X" || @board[index] == "O" ? true : false
        
  end

  def valid_move?(index)
    !position_taken?(index) && (0..8).include?(index) ? true : false
  end
      

  def turn
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      token = current_player
      move(index, token)
      display_board
    else
      input = gets.strip
    end
  end

  def won?
    if WIN_COMBINATIONS.any? { |i, j, k| board[i] == board[j] && board[i] == board[k] && board[i] != " " && board[i] != " " && board[i] != " " }
      WIN_COMBINATIONS.find { |i, j, k| board[i] == board[j] && board[i] == board[k] }
    else
      false
    end
  end

  def full?
    @board.include?(" ") ? false : true
  end

  def draw?
    won? || @board.include?(" ") ? false : true
      
  end

  def over?
    won? || draw? ? true : false
  end

  def winner
    @board[won?[0]] if won?
  end

  def play
    while !over?
      turn
    end
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw?
  end
 
end