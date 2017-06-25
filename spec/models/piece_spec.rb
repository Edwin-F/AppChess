require 'rails_helper'

RSpec.describe Piece, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
  end

  describe "method is_Obstructed?" do
    it 'returns true when move horizontally if obstruction exists' do
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 3 ).first

      check = pawn.is_obstructed?(1,0) #go left
      check2 = pawn.is_obstructed?(1,7) #go right
      expect(check).to be true
      expect(check2).to be true
    end

    it 'returns false when move horizontally if obstruction does not exist' do
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 3 ).first

      check = pawn.is_obstructed?(1,2) #go left
      check2 = pawn.is_obstructed?(1,4) #go right
      expect(check).to be false
      expect(check2).to be false
    end

    it 'returns true when move vertically if obstruction exists' do
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 7, :position_column => 7 ).first

      check = pawn.is_obstructed?(7,7) #go up
      check2 = pawn2.is_obstructed?(0,7) #go down

      expect(check).to be true
      expect(check2).to be true
    end

    it 'returns false when move vertically if obstruction does not exist' do
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 7 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 6, :position_column => 7 ).first

      check = pawn.is_obstructed?(5,7) #go up
      check2 = pawn2.is_obstructed?(2,7) #go down

      expect(check).to be false
      expect(check2).to be false
    end

    it 'returns true when move diagonally if obstruction exists' do
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 7, :position_column => 7 ).first

      check = pawn.is_obstructed?(7,0) #bottom right corner to top left corner
      check2 = pawn2.is_obstructed?(0,0) #top right corner to bottom left corner
      expect(check).to be true
      expect(check2).to be true
    end

    it 'returns false when move diagonally if obstruction does not exist' do
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 6 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 6, :position_column => 6 ).first

      check = pawn.is_obstructed?(5,2) #bottom right corner to top left corner
      check2 = pawn2.is_obstructed?(2,2) #top right corner to bottom left corner
      expect(check).to be false
      expect(check2).to be false
    end

    it 'raises an error if invalid input' do
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first
      expect{ check = pawn.is_obstructed?(1,2) }.to raise_error(RuntimeError)
    end
  end
end