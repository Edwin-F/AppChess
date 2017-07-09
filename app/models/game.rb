class Game < ApplicationRecord

  scope :available, -> { where(black_player_id: nil) }

  belongs_to :white_player, class_name: "User", foreign_key:"white_player_id", required: false
  belongs_to :black_player, class_name: "User", foreign_key:"black_player_id", required: false

  has_many :pieces

  def set_pieces_on_board
    #white pieces
    (0..7).each do |int|
      Pawn.create(game_id: id, user_id: white_player_id, position_row: 1, position_column: int, color: 'white', moves: 0)
    end

    King.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 4, color: 'white', moves: 0)
 
    Queen.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 3, color: 'white', moves: 0)
 
    Bishop.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 2, color: 'white', moves: 0)
 
    Bishop.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 5, color: 'white', moves: 0)
 
    Knight.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 1, color: 'white', moves: 0)
 
    Knight.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 6, color: 'white', moves: 0)
 
    Rook.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 0, color: 'white', moves: 0)
 
    Rook.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 7, color: 'white', moves: 0)

    
    #black pieces
    (0..7).each do |int|
      Pawn.create(game_id: id, user_id: black_player_id, position_row: 6, position_column: int, color: 'black', moves: 0)
    end

    King.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 4, color: 'black', moves: 0)
 
    Queen.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 3, color: 'black', moves: 0)
 
    Bishop.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 2, color: 'black', moves: 0)
 
    Bishop.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 5, color: 'black', moves: 0)
 
    Knight.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 1, color: 'black', moves: 0)
 
    Knight.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 6, color: 'black', moves: 0)
 
    Rook.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 0, color: 'black', moves: 0)
 
    Rook.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 7, color: 'black', moves: 0)
  end 

  def set_default_turn
    update_attributes(turn: white_player_id)
  end

  def switch_player_turn
    turn == white_player_id ? self.turn = black_player_id : self.turn = white_player_id
  end

  def data_method
    pieces_hash = Hash.new {|hash, key| hash[key]={}}

    pieces.each do |piece|
      pieces_hash[piece.position_column][piece.position_row]= piece
    end 
    
    pieces_hash
  end
  
    #check if move puts opponent in check
  def check?
    #puts "check started"
    #return false if beginning_of_game?
    #create storage of all game peices
    white_king = King.find_by(color: 'white')
    #p white_king
    black_king = King.find_by(color: 'black')
    white_pieces = Piece.where(color: 'white')
    black_pieces = Piece.where(color: 'black')
    #p black_pieces.first
    #check everygame piece if it is valid move on the king, if so the king is in check otherwise it is not
    #puts black_pieces.first.valid_move?(white_king.position_row, white_king.position_column) 
    #puts " "
    #puts Knight.where(color: 'black').first.valid_move?(0,4)
      #checks if a piece could move to the king spot
      black_pieces.each do | black_piece |
        #p black_piece
        #puts "This is the value of !black_piece.position_row.nil?:"
        #p  black_piece.position_row.nil? 
        if !black_piece.position_row.nil? && !black_piece.position_column.nil?
          if black_piece.valid_move?(white_king.position_row, white_king.position_column)  
           # puts black_piece.valid_move?(white_king.position_row, white_king.position_column) 
            return true
          end 
        end
      end
      white_pieces.each do |white_piece|
        if !white_piece.position_row.nil? && !white_piece.position_column.nil?
          if  white_piece.valid_move?(black_king.position_row, black_king.position_column)  && !white_piece.nil?
            return true
          end
        end
      end
    
   
    #puts "test returns false at this point"
    return false  
  end

  def beginning_of_game?
    self.pieces.all? { | piece | piece.moves == 0 }
  end  

end
