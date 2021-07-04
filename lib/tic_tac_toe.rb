require 'pry'

class TicTacToe
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(string)
    string.to_i - 1
  end

  def move(index, token = 'X')
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    @board[index] && !position_taken?(index)
  end

  def turn_count
    @board.select { |pos| pos != " " }.count
  end

  def current_player
    (turn_count + 1) % 2 == 0 ? 'O' : 'X'
  end

  def turn
    puts "Please input a number 1 - 9"
    begin
      input = input_to_index(gets.chomp)
      raise
    rescue
      if input < 0 || input > 8
        puts "Please input a valid number."
        retry
      end
    end

    if valid_move?(input)
      move(input, current_player)
    else
      puts "Please try again."
    end

    display_board
  end

  def won?
    WIN_COMBINATIONS.find do |combo|
      combo.all? { |i| @board[i] == 'X'} || combo.all? {|i| @board[i] == 'O' }
    end
  end

  def full?
    WIN_COMBINATIONS.all? do |combo|
      combo.all? { |i| @board[i] == 'X' || @board[i] == 'O' }
    end
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    won? ? @board[won?[0]] : nil
  end

  def play
    turn until over?
    if draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end
end
