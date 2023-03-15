class Piece
    attr_accessor :pos_name, :color, :coord, :x_dict, :y_dict, :piece_type

    def initialize(pos_name, color)
        @pos_name = pos_name
        @color = color == "w" ? "white" : "black"
        @x_dict = {0=>'8', 1=>'7', 2=>'6', 3=>'5', 4=>'4', 5=>'3', 6=>'2', 7=>'1'}
        @y_dict = {0=>'a', 1=>'b', 2=>'c', 3=>'d', 4=>'e', 5=>'f', 6=>'g', 7=>'h'}        
        @coord = get_coord()        
    end  

    def to_str 
        return @sym.encode('utf-8')
    end

    def get_coord
        @coord = [x_dict.key(pos_name[-1]), y_dict.key(pos_name[0])] 
        return @coord
    end 

    def set_pos_name(new_pos)
        @pos_name = new_pos 
        get_coord()
    end 

    def _get_xy_spaces(game_state, min=false)
        x, y = @coord
        up_dist = min ? min : x
        dwn_dist = min ? min : 7 - x
        l_dist = min ? min : y 
        r_dist = min ? min : 7 - y
        pos_movs = []

        dwn_dist.times do |i|
            cur_space = game_state[x+1+i][y]
            if (x+1+i).between?(0,7)
                if cur_space == " "
                    pos_movs.append("#{y_dict[y]}#{x_dict[x+1+i]}")
                elsif cur_space.color != self.color 
                    pos_movs.append("#{y_dict[y]}#{x_dict[x+1+i]}")
                    break
                elsif cur_space != " "
                    break
                end 
            end 
        end 
            
        up_dist.times do |i|
            cur_space = game_state[x-1-i][y]
            if (x-1-i).between?(0,7)
                if cur_space == " "
                    pos_movs.append("#{y_dict[y]}#{x_dict[x-1-i]}")
                elsif cur_space.color != self.color 
                    pos_movs.append("#{y_dict[y]}#{x_dict[x-1-i]}")
                    break
                elsif cur_space != " "
                    break
                end 
            end 
        end  

        r_dist.times do |i|
            cur_space = game_state[x][y+1+i]
            if (y+1+i).between?(0,7)
                if cur_space == " "
                    pos_movs.append("#{y_dict[y+1+i]}#{x_dict[x]}")
                elsif cur_space.color != self.color 
                    pos_movs.append("#{y_dict[y+1+i]}#{x_dict[x]}")
                    break
                elsif cur_space != " "
                    break
                end 
            end 
        end 

        l_dist.times do |i|
            cur_space = game_state[x][y-1-i]
            if (y-1-i).between?(0,7)
                if cur_space == " "
                    pos_movs.append("#{y_dict[y-1-i]}#{x_dict[x]}")
                elsif cur_space.color != self.color 
                    pos_movs.append("#{y_dict[y-1-i]}#{x_dict[x]}")
                    break
                elsif cur_space != " "
                    break
                end 
            end 
        end 

        return pos_movs
    end 

    def _get_diag_spaces(game_state, min=false)
        x, y = @coord
        up_dist = min ? min : x
        dwn_dist = min ? min : 7 - x
        l_dist = y 
        r_dist = 7 - y
        pos_movs = []

        [dwn_dist, r_dist].min.times do |i|
            cur_space = game_state[x+1+i][y+1+i]
            if (x+1+i).between?(0,7) and (y+1+i).between?(0,7)
                if cur_space == " "
                    pos_movs.append("#{y_dict[y+1+i]}#{x_dict[x+1+i]}")
                elsif cur_space.color != self.color 
                    pos_movs.append("#{y_dict[y+1+i]}#{x_dict[x+1+i]}")
                    break
                elsif cur_space != " "
                    break
                end 
            end 
        end 

        [dwn_dist, l_dist].min.times do |i|
            cur_space = game_state[x+1+i][y-1-i]
            if (x+1+i).between?(0,7) and (y-1-i).between?(0,7)
                if cur_space == " "
                    pos_movs.append("#{y_dict[y-1-i]}#{x_dict[x+1+i]}")
                elsif cur_space.color != self.color 
                    pos_movs.append("#{y_dict[y-1-i]}#{x_dict[x+1+i]}")
                    break
                elsif cur_space != " "
                    break
                end 
            end 
        end 

        [up_dist, r_dist].min.times do |i|
            cur_space = game_state[x-1-i][y+1+i]
            if (x-1-i).between?(0,7) and (y+1+i).between?(0,7)
                if cur_space == " "
                    pos_movs.append("#{y_dict[y+1+i]}#{x_dict[x-1-i]}")
                elsif cur_space.color != self.color 
                    pos_movs.append("#{y_dict[y+1+i]}#{x_dict[x-1-i]}")
                    break
                elsif cur_space != " "
                    break
                end 
            end 
        end 

        [up_dist, l_dist].min.times do |i|
            cur_space = game_state[x-1-i][y-1-i]
            if (x-1-i).between?(0,7) and (y-1-i).between?(0,7)
                if cur_space == " "
                    pos_movs.append("#{y_dict[y-1-i]}#{x_dict[x-1-i]}")
                elsif cur_space.color != self.color 
                    pos_movs.append("#{y_dict[y-1-i]}#{x_dict[x-1-i]}")
                    break
                elsif cur_space != " "
                    break
                end 
            end 
        end
        
        return pos_movs
    end 
end 

class Pawn < Piece
    def initialize(pos_name, color)
        super(pos_name, color)
        @piece_type = "Pawn"
        @sym = @color == 'white' ? "\u265F" : "\u2659"
    end 

    def get_movements(game_state)
        x, y = @coord
        start_row = @color == 'white' ? 6 : 1
        mov_base = @color == 'white' ? -1 : 1
        pos_movs = []

        if x == start_row and game_state[x+(mov_base+mov_base)][y] == " "      
            pos_movs.append("#{y_dict[y]}#{x_dict[x+(mov_base+mov_base)]}")
        end  
        if (x+mov_base).between?(0,7)
            if game_state[x+mov_base][y] == " "
                pos_movs.append("#{y_dict[y]}#{x_dict[x+mov_base]}") 
            end 
            if (y-1).between?(0,7) and game_state[x+mov_base][y-1] != " " 
                if game_state[x+mov_base][y-1].color != self.color
                    pos_movs.append("#{y_dict[y-1]}#{x_dict[x+mov_base]}")
                end                 
            end  
            if (y+1).between?(0,7) and game_state[x+mov_base][y+1] != " " 
                if game_state[x+mov_base][y+1].color != self.color
                    pos_movs.append("#{y_dict[y+1]}#{x_dict[x+mov_base]}")
                end 
            end 
        end
        return pos_movs 
    end
end 

class Rook < Piece
    def initialize(pos_name, color)
        super(pos_name, color)
        @piece_type = "Rook"
        @sym = @color == 'white'  ? "\u265C" : "\u2656"
    end 

    def get_movements(game_state)
        xy_spaces = _get_xy_spaces(game_state)

        return xy_spaces.sort()
    end
end 

class Knight < Piece
    def initialize(pos_name, color)
        super(pos_name, color)
        @piece_type = "Knight"
        @sym = @color == 'white'  ? "\u265E" : "\u2658"
    end 

    def get_movements(game_state)
        x, y = @coord
        pos_movs = []

        if (x+2).between?(0,7)
            if(y+1).between?(0,7) and (game_state[x+2][y+1] == " " or game_state[x+2][y+1].color != self.color)
                pos_movs.append("#{y_dict[y+1]}#{x_dict[x+2]}")
            end 
            if(y-1).between?(0,7) and (game_state[x+2][y-1] == " " or game_state[x+2][y-1].color != self.color)
                pos_movs.append("#{y_dict[y-1]}#{x_dict[x+2]}")
            end 
        end 

        if (x-2).between?(0,7)
            if(y+1).between?(0,7) and (game_state[x-2][y+1] == " " or game_state[x-2][y+1].color != self.color)
                pos_movs.append("#{y_dict[y+1]}#{x_dict[x-2]}")
            end 
            if(y-1).between?(0,7) and (game_state[x-2][y-1] == " " or game_state[x-2][y-1].color != self.color)
                pos_movs.append("#{y_dict[y-1]}#{x_dict[x-2]}")
            end 
        end 

        if (y+2).between?(0,7)
            if(x+1).between?(0,7) and (game_state[x+1][y+2] == " " or game_state[x+1][y+2].color != self.color)
                pos_movs.append("#{y_dict[y+2]}#{x_dict[x+1]}")
            end 
            if(x-1).between?(0,7) and (game_state[x-1][y+2] == " " or game_state[x-1][y+2].color != self.color)
                pos_movs.append("#{y_dict[y+2]}#{x_dict[x-1]}")
            end 
        end 

        if (y-2).between?(0,7)
            if(x+1).between?(0,7) and (game_state[x+1][y-2] == " " or game_state[x+1][y-2].color != self.color)
                pos_movs.append("#{y_dict[y-2]}#{x_dict[x+1]}")
            end 
            if(x-1).between?(0,7) and (game_state[x-1][y-2] == " " or game_state[x-1][y-2].color != self.color)
                pos_movs.append("#{y_dict[y-2]}#{x_dict[x-1]}")
            end 
        end         

        return pos_movs.sort
    end
end 

class Bishop < Piece
    def initialize(pos_name, color)
        super(pos_name, color)
        @piece_type = "Bishop"
        @sym = @color == 'white'  ? "\u265D" : "\u2657"
    end 

    def get_movements(game_state)
        diag_spaces = _get_diag_spaces(game_state)
    

        return diag_spaces.sort()
    end
end 

class Queen < Piece
    def initialize(pos_name, color)
        super(pos_name, color)
        @piece_type = "Queen"
        @sym = @color == 'white'  ? "\u265B" : "\u2655"
    end 

    def get_movements(game_state)
        xy_spaces = _get_xy_spaces(game_state)
        diag_spaces = _get_diag_spaces(game_state)

        return (xy_spaces + diag_spaces).uniq.sort
    end
end 

class King < Piece
    def initialize(pos_name, color)
        super(pos_name, color)
        @piece_type = "King"
        @sym = @color == 'white'  ? "\u265A" : "\u2654"
    end 

    def get_movements(game_state)
        x, y = @coord
        pos_movs = []

        xy_spaces = _get_xy_spaces(game_state, 1)
        diag_spaces = _get_diag_spaces(game_state, 1)

        return (xy_spaces + diag_spaces).uniq.sort        
    end
end 