require './lib/game'

describe '#Game' do
    subject(:game) { Game.new } 

    context "move_piece" do 
        it "to empy space" do
            game.move_piece("d7", "d5")

            expect(game.board[1][3]).to eq(" ")
            expect(game.board[3][3].color).to eq("black")
            expect(game.board[3][3].coord).to eq([3, 3])
            expect(game.board[3][3].piece_type).to eq("Pawn")            
        end 

        it "to space occupied by enemy" do
            new_piece = Rook.new("c5", "b") 
            game.board[3][2] = new_piece
            game.move_piece("c5", "c2")

            expect(game.board[3][2]).to eq(" ")
            expect(game.board[6][2]).to eq(new_piece)
        end 

        it "to space occupied by same color" do
            new_piece = Bishop.new("c5", "b") 
            game.board[3][2] = new_piece
            game.move_piece("c5", "a7")

            expect(game.board[3][2]).to eq(new_piece)
        end 
    end 

    context "get_input" do
        it "ensures first space is occupied and selected space can be moved to" do
            inpt = "a2 to a4"

            expect(game.get_input('white', inpt)).to eq(["a2", "a4"])
        end 

        it "requires new input if space isn't occupied or new space is invalid" do 
            
        end 
    end 
end 