#Macros

CC = g++
FLAGS = -Wall -std=c++17 
LINKS = -lsfml-graphics -lsfml-window -lsfml-system 
game: main.o game.o welcome.o play.o cherry.o button.o results.o
	$(CC) $(FLAGS) $^ -o $@ $(LINKS)

main.o: main.cpp game.h
	$(CC) $(FLAGS) -c $<

game.o: game.cpp game.h states.h welcome.h play.h results.h
	$(CC) $(FLAGS) -c $<

welcome.o: welcome.cpp welcome.h states.h button.h
	$(CC) $(FLAGS) -c $<

play.o: play.cpp play.h states.h button.h cherry.h
	$(CC) $(FLAGS) -c $<

cherry.o: cherry.cpp cherry.h 
	$(CC) $(FLAGS) -c $<

button.o: button.cpp button.h
	$(CC) $(FLAGS) -c $<

results.o: results.cpp results.h states.h button.h
	$(CC) $(FLAGS) -c $<

clean:
	rm -f game *.o

