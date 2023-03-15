require './lib/pieces'

class Game
    attr_accessor :board, :x_dict, :y_dict, :piece_count
    def initialize
        @board = Array.new(8) {Array.new(8, " ")}
        @x_dict = {0=>'8', 1=>'7', 2=>'6', 3=>'5', 4=>'4', 5=>'3', 6=>'2', 7=>'1'}
        @y_dict = {0=>'a', 1=>'b', 2=>'c', 3=>'d', 4=>'e', 5=>'f', 6=>'g', 7=>'h'}  
        @piece_count = {'white'=>16, 'black'=>16}

        8.times do |idx|
            if idx == 0 or idx == 7
                @board[0][idx] = Rook.new("#{@y_dict[idx]}#{@x_dict[0]}", 'b' )
                @board[7][idx] = Rook.new("#{@y_dict[idx]}#{@x_dict[7]}", 'w' )
            elsif idx == 1 or idx == 6 
                @board[0][idx] = Knight.new("#{@y_dict[idx]}#{@x_dict[0]}", 'b' )
                @board[7][idx] = Knight.new("#{@y_dict[idx]}#{@x_dict[7]}", 'w' )
            elsif idx == 2 or idx == 5 
                @board[0][idx] = Bishop.new("#{@y_dict[idx]}#{@x_dict[0]}", 'b' )
                @board[7][idx] = Bishop.new("#{@y_dict[idx]}#{@x_dict[7]}", 'w' )
            elsif idx == 3 
                @board[0][idx] = Queen.new("#{@y_dict[idx]}#{@x_dict[0]}", 'b' )
                @board[7][idx] = Queen.new("#{@y_dict[idx]}#{@x_dict[7]}", 'w' )
            elsif idx == 4 
                @board[0][idx] = King.new("#{@y_dict[idx]}#{@x_dict[0]}", 'b' )
                @board[7][idx] = King.new("#{@y_dict[idx]}#{@x_dict[7]}", 'w' )
            end 
            @board[1][idx] = Pawn.new("#{@y_dict[idx]}#{@x_dict[1]}", 'b' )             
            @board[6][idx] = Pawn.new("#{@y_dict[idx]}#{@x_dict[6]}", 'w' ) 
        end 
    end

    def display_board    
        board_str = "      White: #{@piece_count['white']}      Black: #{@piece_count['black']}     "    
        board.each_with_index do |row, idx|
            row_str = row.join(" | ")
            board_str = board_str + "\n  #{'=' * 33}"
            board_str = board_str + "\n#{(8 - idx).to_s} | #{row_str} |"
        end 
        board_str = board_str + "\n  #{"=" * 33}\n"
        board_str = board_str + "    a   b   c   d   e   f   g   h  \n\n"
        puts(board_str)
    end 

    def move_piece(pos, new_pos)
        cur_x, cur_y = [x_dict.key(pos[-1]), y_dict.key(pos[0])]
        new_x, new_y = [x_dict.key(new_pos[-1]), y_dict.key(new_pos[0])]
        cur_piece = board[cur_x][cur_y]
        new_space = board[new_x][new_y]

        if cur_piece.get_movements(board).include? new_pos 
            puts(cur_piece.get_movements(board))
            if new_space != " " 
                piece_count[new_space.color] -= 1
                puts("#{cur_piece.color.capitalize} #{cur_piece.piece_type} takes #{new_space.color.capitalize} #{new_space.piece_type}")
            end 
            board[new_x][new_y] = board[cur_x][cur_y]
            board[new_x][new_y].set_pos_name(new_pos)
            board[cur_x][cur_y] = " "
        end
    end
    
    def get_input(player, inpt)
        cur_space = inpt.slice(0,2)
        new_space = inpt.slice(-2,2)
        cur_space_val = board[x_dict.key(cur_space[-1])][y_dict.key(cur_space[0])]
        new_space_val = board[x_dict.key(new_space[-1])][y_dict.key(new_space[0])]

        if cur_space_val == " " or cur_space_val.color != player or (new_space_val != " " and new_space_val.color == player)
            puts("Invalid space entered for movement. Use the letter/number coordinates of the piece you want to move followed by the coordinates of the new location.  ex. \"a2 to a4\"")
            get_input(player, gets().chomp())
        else 
            return [cur_space, new_space]
        end        
    end 
end 