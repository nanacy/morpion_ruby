class Board
	attr_accessor :tab_case

	def initialize
		@tab_case = [
			[ BoardCase.new, BoardCase.new, BoardCase.new ], #ligne1 
			[ BoardCase.new, BoardCase.new, BoardCase.new ], #ligne2
			[ BoardCase.new, BoardCase.new, BoardCase.new ]  #ligne3
		]
	end

	def affichage
		print "\t",  "-"*13, "\n"
		3.times do |x|
			print "\t| "
			3.times do |y|
				if @tab_case[x][y].value==nil
					print ". | "
				else
					print "#{@tab_case[x][y].value} | "
				end
			end
			puts
			print "\t",  "-"*13, "\n"
		end
	end

	def verif
		# VERIF LIGNE
		3.times do |ligne|
	        var_verif = 0
	        2.times do |col|
	            if @tab_case[ligne][col].value == nil
	            	# print "-> nul |"
	            elsif !(@tab_case[ligne][col].value == @tab_case[ligne][col+1].value)
	                # print "->pas egaux |"
	                # break
	            else
	                var_verif += 1
	            end
	            if var_verif == 2
	                return true 
	            end
	        end
	    end

		# VERIF COLONNE
		puts
		3.times do |col|
	        var_verif = 0
	        2.times do |ligne|
	            if @tab_case[ligne][col].value == nil
	            	# print "-> nul |"
	            elsif !(@tab_case[ligne][col].value == @tab_case[ligne+1][col].value)
	                # print "->pas egaux |"
	                # break
	            else
	                var_verif += 1
	            end
	            if var_verif == 2
	                # puts "SUCCES DE VOTRE COLONNE"
	                return true
	            end
	        end
	    end

	    #VERIF DIAGONALE

		# pas une diagonale de nil
		if @tab_case[1][1].value !=nil
			#diago1
			if @tab_case[0][0].value == @tab_case[1][1].value && @tab_case[1][1].value == @tab_case[2][2].value
				return true
			#diago2
			elsif @tab_case[0][2].value == @tab_case[1][1].value && @tab_case[1][1].value == @tab_case[2][0].value
				return true
			end
		end
	    
	    return false
	end

	def get_tab
		return @tab_case
	end

end
#----------------------------------
class BoardCase
	attr_accessor :value

	def initialise
		@value = nil
	end

	def set_case(new_value)
		@value = new_value
	end
end
#----------------------------------
class Player
	attr_accessor :pseudo ,:forme

	def initialize(pseudo, forme)
		@pseudo = pseudo
		@forme = forme
	end

	def info
		puts "Joueur : #{@pseudo}"
		puts "Joue avec : #{@forme}"
	end

	def get_forme
		return @forme
	end

	def get_pseudo
		return @pseudo.capitalize
	end

end
#----------------------------------
class Game
	attr_accessor :joueur1, :joueur2, :plateau

	def initialize
		#Crée les joueurs
		print "Entrez le pseudo du joueur 1 -> "
		@joueur1 = Player.new(gets.chomp, "X")
		@joueur1.info
		puts
		print "Entrez le pseudo du joueur 2 -> "
		@joueur2 = Player.new(gets.chomp, "O")
		@joueur2.info

		#Crée le plateau
		@plateau = Board.new()
	end

	def choix_position
		ligne = 0
		colonne = 0
		
		# tant que le user ne rentre pas une position possible
		loop do 
			# tant que le user ne rentre pas une position existante
			while ligne > 3 || ligne < 1
				ligne = 0
				colonne = 0		
				print "Choisir ligne entre 1 et 3 -> "
				ligne = gets.chomp.to_i
			end 
			while colonne > 3 || colonne < 1
				print "Choisir colonne entre 1 et 3 -> "
				colonne = gets.chomp.to_i
			end
			# A SUPPRIMER APRES
			ligne -= 1
			colonne -= 1

			break if @plateau.get_tab[ligne][colonne].value==nil
		end

		return @plateau.get_tab[ligne][colonne]
	end


	def end_game
		fin = false
		3.times do |ligne|
			3.times do |colonne|
				if @plateau.get_tab[ligne][colonne].value == nil
					return fin = false
				end
			end
		end
		return true				
	end

	def main
		5.times do |tour|
			# TOUR JOUEUR 1
			puts
			@plateau.affichage
			puts
			puts
			print "\t" , "-"*12, "\n"
			puts "\t|  JOUEUR 1 : #{@joueur1.get_pseudo}"
			print "\t" , "-"*12, "\n"
			a = nil
			loop do
				a = choix_position
				break unless a==nil
			end
			a.set_case(@joueur1.get_forme)

			# AFFICHAGE MORPION
			@plateau.affichage
			# VERIFIE VICTOIRE
			if @plateau.verif == true
				puts "-"*23
				puts "| VICTOIRE du joueur1 |"
				puts "|\tCONGRATZ      |"
				puts "-"*23
				return true
			end
			puts

			# FIN DE JEU(?) = égalité
			if end_game == true
				puts "-"*19
				puts "| END OF THE GAME |"
				puts "|-- It's a draw --|"
				puts "-"*19
				return false
			end
			# if tour == 4
			# 	puts "CEST FINI TROP DE TOUR\nTROPPPPPP	"
			# 	return true
			# end

			# TOUR JOUEUR 2
			print "\t" , "-"*12, "\n"
			puts "\t|  JOUEUR 2 : #{@joueur2.get_pseudo}"
			print "\t" , "-"*12, "\n"
			a=choix_position
			a.set_case(@joueur2.get_forme)

			# AFFICHAGE MORPION
			@plateau.affichage
			# VERIFIE VICTOIRE	
			if @plateau.verif == true
				puts "-"*23
				puts "| VICTOIRE du joueur2 |"
				puts "|\tCONGRATZ      |"
				puts "-"*23
				return true
			end

		end
	end
end

#return TRUE = VICTOIRE
#return FALSE = EGALITE

#####################################################
jeu = Game.new()
jeu.main
