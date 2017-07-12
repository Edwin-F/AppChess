require 'rails_helper'

RSpec.describe Game, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @bishop1 = Bishop.first #(position (0,2), color: white)
    @bishop2 = Bishop.second #(position (0,5), color: white)
    @bishop3 = Bishop.last #(position: (7,5), color: black)
    @pawn1 = Pawn.first #(position (1,0), color: white)
    @rook3 = Rook.last #(position: (7,7), color: black)
    @queen2 = Queen.last 
    @knight = Knight.last
    @king = King.last
    @king_white = King.first
    @pawn_last = Pawn.last
    
  end

  describe "Check method working" do
    context 'make sure check is false when the game starts' do 
      it 'returns false for starting board position' do
        expect(@game.check?).to be false
      end

      it 'returns true for king being in check if knight  ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @knight.update_attributes(position_row: 1, position_column: 2)
        @knight.reload
        expect(@game.check?).to be true 
      end   
      
      it 'returns true for king being in check if king ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @king.update_attributes(position_row: 1, position_column: 4)
        @king.reload
        expect(@game.check?).to be true 
      end   
      
      it 'returns true for king being in check if bishop  ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @bishop3.update_attributes(position_row: 1, position_column: 3)
        @bishop3.reload
        expect(@game.check?).to be true 
      end 
      
      it 'returns true for king being in check if Rook ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @rook3.update_attributes(position_row: 1, position_column: 4)
        @rook3.reload
        expect(@game.check?).to be true 
      end
      
      it 'returns true for king being in check if pawn ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @pawn_last.update_attributes(position_row: 3, position_column: 3, moves: 7)
        @pawn_last.reload
        King.first.update_attributes(position_row: 2, position_column: 4)
        expect(@game.check?).to be true 
      end
      
      it 'returns true for king being in check if queen ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @queen2.update_attributes(position_row: 1, position_column: 4)
        @queen2.reload
        expect(@game.check?).to be true 
      end
      
       it 'returns true for king being in check with pawns removed from row' do
        #remove pawns to check that king is not in check since no piece can get there in one mover
        Pawn.all.update_all(position_row: nil, position_column: nil) 
        expect(@game.check?).to be false 
      end 
      
        it 'remove all pieces on the board except 2 kings (in there starting position), game should not be in check' do
        #remove pawns to check that king is not in check since no piece can get there in one mover
        Pawn.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Bishop.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Rook.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Queen.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Knight.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        expect(@game.check?).to be false 
      end 
      
      it 'white Queen casuing white king to not be in check' do
        #Pawn.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        #Bishop.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        #Rook.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        #Queen.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        #Knight.all.update_all(position_row: nil, position_column: nil, moves: 1) 
      Queen.first.update_attributes(position_row: 3, position_column: 1, moves: 7)  
        @pawn_last.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_last.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?).to be true 
      end
      
      
      it 'bug test white queen causing king to no be in check?' do
      Queen.first.update_attributes(position_row: 0, position_column: 3, moves: 7)  
        @pawn_last.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_last.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?).to be true 
      end
      
      it 'bug test white queen causing king to no be in check?' do
      Queen.first.update_attributes(position_row: nil, position_column: nil, moves: 7)  
        @pawn_last.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_last.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?).to be true 
      end
      
      it 'bug test white queen causing king to no be in check?' do
        Queen.all.update_all(position_row: nil, position_column: nil, moves: 8) 
        @pawn_last.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_last.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?).to be true 
      end
      
      it 'bug test white queen causing king to no be in check?' do
        Queen.first.update_attributes(position_row: 5, position_column: 5, moves: 7)  
        @pawn_last.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_last.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?).to be true 
      end
      
      it 'bug test white queen causing king to no be in check?' do
        Pawn.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Queen.first.update_attributes(position_row: 1, position_column: 3, moves: 7)  
        @pawn_last.update_attributes(position_row: 2, position_column: 3, moves: 7)
        @pawn_last.reload
        @king_white.update_attributes(position_row: 1, position_column: 4)
        @king_white.reload
        expect(@game.check?).to be true 
      end
      
      it 'bug test white queen causing king to no be in check?' do
        
        Queen.first.update_attributes(position_row: 4, position_column: 1, moves: 7)  
        @pawn_last.update_attributes(position_row: 5, position_column: 1, moves: 7)
        @pawn_last.reload
        @king_white.update_attributes(position_row: 4, position_column: 0)
        @king_white.reload
        expect(@game.check?).to be true 
      end
      
      it 'bug test white queen on the space to left of the white king causing  it to no be in check?' do
        
        Queen.first.update_attributes(position_row: 4, position_column: 0, moves: 7)  
        @pawn_last.update_attributes(position_row: 5, position_column: 0, moves: 7)
        @pawn_last.reload
        @king_white.update_attributes(position_row: 4, position_column: 1)
        @king_white.reload
        
        #byebug
        expect(@game.check?).to be true 
      end
      
      it 'bug test white queen on the space to left of the white king causing  it to no be in check?' do
        
        Queen.last.update_attributes(position_row: 4, position_column: 0, moves: 7)  
        @pawn1.update_attributes(position_row: 3, position_column: 0, moves: 7) #white pawn
        @pawn1.reload
        @king.update_attributes(position_row: 4, position_column: 1) #black king 
        @king.reload
        
        #byebug
        expect(@game.check?).to be true 
      end
      

    end
  end
end