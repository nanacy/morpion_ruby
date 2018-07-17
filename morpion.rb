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
		puts "-"*13
		3.times do |x|
			print "| "
			3.times do |y|
				if @tab_case[x][y].value==nil
					print ". | "
				else
					print "#{@tab_case[x][y].value} | "
				end
			end
			puts
			puts "-"*13
		end
	end

	def verif
		# VERIF LIGNE
		puts "Verif LIGNE: "
		3.times do |ligne|
	        var_verif = 0
	        2.times do |col|
	            if @tab_case[ligne][col].value == nil
	            	print "-> nul |"
	            elsif !(@tab_case[ligne][col].value == @tab_case[ligne][col+1].value)
	                print "->pas egaux |"
	                # break
	            else
	                var_verif += 1
	            end
	            if var_verif == 2
	                puts "succes de votre ligne"
	                return true #SUCCESSS D'UNE LIGNE
	            end
	        	puts " tab[#{ligne}][#{col}] et tab[#{ligne}][#{col+1}]"
	            # puts "VAR VERIF: #{var_verif}"
	        end
	    end

		# VERIF COLONNE
		puts
		puts "verif COLONNE:"
		3.times do |col|
	        var_verif = 0
	        2.times do |ligne|
	            if @tab_case[col][ligne].value == nil
	            	print "-> nul |"
	            elsif !(@tab_case[col][ligne].value == @tab_case[col+1][ligne].value)
	                print "->pas egaux |"
	                # break
	            else
	                var_verif += 1
	            end
	            if var_verif == 2
	                puts "succes de votre colonne"
	                return true #SUCCESSS D'UNE COLONNE
	            end
	        	puts " tab[#{ligne}][#{col}] et tab[#{ligne+1}][#{col}]"
	            # puts "VAR VERIF: #{var_verif}"
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

		while ligne > 3 || ligne < 1
			print "Choisir ligne entre 1 et 3: "
			ligne = gets.chomp.to_i
		end 
		while colonne > 3 || colonne < 1
			print "Choisir colonne entre 1 et 3: "
			colonne = gets.chomp.to_i
		end
		# A SUPPRIMER APRES
		puts ligne -= 1
		puts colonne -= 1

		if @plateau.get_tab[ligne][colonne].value != nil
			return "EMPLACEMENT DEJA PRIS"
		end
		return @plateau.get_tab[ligne][colonne]
	end


	def main
		5.times do |tour|
			# TOUR JOUEUR 1
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
			puts "Fonction verif tab: "	
			if @plateau.verif == true
				puts "\tSUCCES !"
				return true
			end
			puts


			if tour == 5
				break
			end
			# TOUR JOUEUR 2
			print "\t" , "-"*12, "\n"
			puts "\t|  JOUEUR 2 : #{@joueur2.get_pseudo}"
			print "\t" , "-"*12, "\n"
			begin
				a = choix_position
				while a=="EMPLACEMENT DEJA PRIS"
					puts "Emplacement déjà pris ... Recommencez"
					a=choix_position
				end
				# break unless a==nil
			end while (a==nil)
			a.set_case(@joueur2.get_forme)

			# AFFICHAGE MORPION
			@plateau.affichage		
			if @plateau.verif == true
				puts "\tSUCCES !"
				return true
			end
		end
	end
end

#####################################################
jeu = Game.new()
jeu.main