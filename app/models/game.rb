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
    #return false if beginning_of_game?
    #create storage of all game peices
    white_king = King.find_by(color: 'white')
    black_king = King.find_by(color: 'black')
    white_pieces = Piece.where(color: 'white')
    black_pieces = Piece.where(color: 'black')
    #check everygame piece if it is valid move on the king, if so the king is in check otherwise it is not
    self.pieces.each do |piece|
      #checks if a piece could move to the king spot
      black_pieces.each do | black_piece |
        if black_piece.valid_move?(white_king.position_row, white_king.position_column) 
         return true
        end 
      end
      white_pieces.each do |white_piece|
        if  white_piece.valid_move?(black_king.position_row, black_king.position_column)  
          return true
        end
      end
    
    #end
    
    return false  
  end

  def beginning_of_game?
    self.pieces.all? { | piece | piece.moves == 0 }
  end  
end
