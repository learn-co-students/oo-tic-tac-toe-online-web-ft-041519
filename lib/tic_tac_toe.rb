require 'pry'

class TicTacToe
  
  attr_accessor :board, :index
  
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
  
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
  
  def input_to_index(board_input)
    board_input.to_i - 1 
  end 
  
  def move(index, token) 
    @board[index] = token
  end 
  
  def position_taken?(index)
    ["X", "O"].include?(@board[index]) 
  end 
  
  def valid_move?(index)
    ["X", "O"].include?(@board[index]) ? false : index.between?(0,8) 
  end 
  
  def turn_count
    (@board).count{|x| ["X", "O"].include?(x)}
  end 
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end 
  
  def turn
    user_input = gets.chomp
    index = input_to_index(user_input)
      if valid_move?(index)
        move(index, current_player)
        display_board
      else 
        user_input = gets.chomp
      end 
  end 
  
  def won?
    won = false
    element = []

    WIN_COMBINATIONS.each do |x|
          temp = []
          x.each do |y|
            temp << @board[y]
            if temp.uniq.size == 1 &&  temp.size == 3 && temp.include?(" ") == false
              won = temp
              element = x
              break
            end  
          end
          break if won != false    
    end
    if won != false 
      element
    end 
  end
  
  def full? 
    
    ended = false 

    WIN_COMBINATIONS.each do |x|
          temp = []
          x.each do |y|
            temp << @board[y]
            if temp.uniq.size == 1 &&  temp.size == 3 && temp.include?(" ") == false
              ended = true 
            end  
          end
          break if ended == true
    end

    if @board.size == 9 && @board.include?(" ") == false
      ended=true 
    end 
    
    ended 
  end 
  
  def draw?

    if won? != nil  
      false
    elsif full? == true
      true
    else 
      false
    end 

  end 
  
  def over? 
    if won? != nil
      true 
    elsif draw? 
      true
    end 
  end 
  
  def winner 
    if won? != nil 
      @board[won?[1]]
    else 
      nil
    end 
  end 
  
  def play
    9.times do |x|
      unless over? 
        turn
      end
    end
    if winner != nil
      puts "Congratulations #{winner}!"
    elsif draw? 
      puts "Cat's Game!"
    end
  end 
  
  
  
end 
