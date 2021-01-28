
class Game
    WINNING_COMBOS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],
    ]
    
      def initialize
       @players = Players.new
      end
 # La méthode gère le gameplay réel      
      def move
        @end = false
        @gameboard = Board.new
        @turn = 1
        while @turn<10
          if @turn % 2 != 0
              turn_sequence(@players.player1, "X")
          elsif @turn % 2 == 0
              turn_sequence(@players.player2, "O")
          end
        end
      end
   # La méthode turn_sequence gère le choix de la position et le changement de tour de joueur
      def turn_sequence (player, symbol)
        puts "#{player}(#{symbol}) please choisissez une option"
        @player_move = gets.chomp.to_i
        if (0..8).include?(@player_move) && @gameboard.board[@player_move] == " " && @end == false
          @turn += 1
          @gameboard.board_update(@player_move, symbol)
          win_check
          draw_check
        else
          puts "Please entrer un nombre entre un nombre de 0 à 8\n"
        end
      end
    #method pour vérifier le tableau de bord vs les combinaisons gagnantes pour vérifier s'il y a un gagnant
      def win_check
        WINNING_COMBOS.each do |win_check|
          if (@gameboard.board[win_check[0]] == @gameboard.board[win_check[1]] && 
            @gameboard.board[win_check[1]] == @gameboard.board[win_check[2]]) &&
            @gameboard.board[win_check[0]] != " "
            if @gameboard.board[win_check[0]] == "X"
              puts "#{@players.player1} WINS"
              @turn = 10
              @end = true
              play_again?
            elsif @gameboard.board[win_check[0]] == "O"
              puts "#{@players.player2} WINS"
              @turn = 10
              @end = true
              play_again?
            end
          end
        end
      end
     #method pour déterminer si tous les postes sont pourvus sans victoire   
      def draw_check
        if @turn == 10 && @end == false
          puts "It's a draw"
          play_again?
        end
      end
    #method pour demander au joueur s'il souhaite rejouer      
      def play_again?
        puts "Play again? (Y/N)"
          response = ""
          while response != "Y" || response != "N"
            response = gets.chomp.upcase
              if response == "Y"
                newgame = Game.new
                newgame.move  
              elsif response == "N"
              else 
                puts "Please entrer (Y/N)"
              end
          end
      end
    end
   #class qui gère la demande de nom de joueur et l'initialisation des variables d'instance de joueur
    class Players
      attr_reader :player1, :player2
      
      def initialize
        puts "Player 1, please entrer votre nom "
        @player1 = gets.chomp
        puts "#{@player1} est X"
        puts "Player 2, please entrer votre nom"
        @player2 = gets.chomp
        puts "#{@player2} est O"
      end
    
    end
    #class pour gérer tout ce qui concerne l'affichage du tableau, la mise à jour du tableau et la création du tableau lui-même
    class Board
      attr_reader :board
          
      def initialize
        puts "À votre tour, entrez l'un des nombres suivants pour placer votre pièce à l'emplacement correspondant:"
        puts "0 | 1 | 2"
        puts "---------"
        puts "3 | 4 | 5"
        puts "---------"
        puts "6 | 7 | 8"
        @board = [" "," "," "," "," "," "," "," "," "]
      end
    #method pour mettre à jour le tableau @board avec "X" ou "O"
      def board_update(position, symbol)
        @board[position] = symbol
        game_board_display(@board)
      end
      #method qui affiche le tableau mis à jour après chaque tour
      def game_board_display (board)
        puts "#{board[0]} | #{board[1]} | #{board[2]}"
        puts "---------"
        puts "#{board[3]} | #{board[4]} | #{board[5]}"
        puts "---------"
        puts "#{board[6]} | #{board[7]} | #{board[8]}"
      end
      
    end
    game = Game.new
    game.move  

