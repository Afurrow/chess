require './lib/game'

describe '#Chess Pieces' do
    subject(:game) { Game.new } 

    context "get_movement" do
        it "returns pawn movements - start" do 
            expct_movs = ["c4", "c3"]
            expect(game.board[6][2].get_movements(game.board)).to eq(expct_movs)
        end 

        it "returns pawn movements - attack" do 
            game.board[2][1] = Pawn.new("b6", "w")
            game.board[5][6] = Pawn.new("g3", "b")

            expct_movs_w = ["a7","c7"]
            expct_movs_b = ["f2","h2"]
            expect(game.board[2][1].get_movements(game.board)).to eq(expct_movs_w)
            expect(game.board[5][6].get_movements(game.board)).to eq(expct_movs_b)
        end 

        it "returns rook movements" do 
            game.board[3][1] = Rook.new("b5", "b")

            expct_movs = ["a5", "b2", "b3", "b4", "b6", "c5", "d5", "e5", "f5", "g5", "h5"]
            expect(game.board[3][1].get_movements(game.board)).to eq(expct_movs)
        end

        it "returns knight movements" do 
            game.board[3][2] = Knight.new("c5", "b")

            expct_movs = ["a4", "a6", "b3", "d3", "e4", "e6"]
            expect(game.board[3][2].get_movements(game.board)).to eq(expct_movs)
        end 

        it "returns bishop movements" do 
            game.board[3][1] = Bishop.new("b5", "b")

            expct_movs = ["a4", "a6", "c4", "c6", "d3", "e2"]
            expect(game.board[3][1].get_movements(game.board)).to eq(expct_movs)
        end 

        it "returns queen movements" do 
            game.board[3][1] = Queen.new("b5", "b")

            expct_movs = ["a4", "a5", "a6", "b2", "b3", "b4", "b6", "c4", "c5", "c6", "d3", "d5", "e2", "e5", "f5", "g5", "h5"]
            expect(game.board[3][1].get_movements(game.board)).to eq(expct_movs)
        end 
        
        it "returns king movements" do 
            game.board[3][1] = King.new("b5", "w")

            expct_movs = ["a4", "a5", "a6", "b4", "b6", "c4", "c5", "c6"]
            expect(game.board[3][1].get_movements(game.board)).to eq(expct_movs)
        end 
    end 
end 