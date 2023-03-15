require './lib/game'

game = Game.new()
turn = 1 
puts("Use the letter/number coordinates of the piece you want to move followed by the coordinates of the new location.  ex. \"a2 to a4\"")
while game.piece_count["white"] != 0 and game.piece_count["black"] != 0 do 
    cur_player = turn % 2 == 1 ? "white" : "black"

    game.display_board    
    puts("#{cur_player.capitalize}'s Turn")
    mvmnt = game.get_input(cur_player, gets().chomp())    
    game.move_piece(mvmnt[0], mvmnt[1])
    turn += 1
end 
puts("Thank you for playing!")