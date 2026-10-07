-include config.mk

CC = g++
CFLAGS = -Wall -std=c++17 -I$(SFML_DIR)/include #-DSFML_STATIC 
LFLAGS = -L$(SFML_DIR)/lib
# LIBS = -lsfml-graphics-s -lsfml-window-s -lsfml-system-s -lopengl32 -lfreetype -lwinmm -lgdi32 -lsfml-main -mwindows
LIBS = -lsfml-graphics -lsfml-window -lsfml-system 

# Detect operating system
ifeq ($(OS),Windows_NT)
    MKDIR = if not exist obj mkdir obj
    EXE = .exe
    RM = del /Q
    CLEAN_OBJECTS = $(subst /,\,$(OBJECTS))
else
    MKDIR = mkdir -p obj
    EXE =
    RM = rm -f
    CLEAN_OBJECTS = $(OBJECTS)
endif

#Find all files in the src directory whose names end in .cpp.
SOURCES = $(wildcard src/*.cpp)
#for each cpp file in the src directory, creat coresponding file in obj directory
OBJECTS = $(patsubst src/%.cpp,obj/%.o,$(SOURCES))

obj/%.o: src/%.cpp | obj
	$(CC) $(CFLAGS) -c $< -o $@

game: obj/main.o obj/game.o obj/welcome.o obj/play.o obj/cherry.o obj/button.o obj/results.o | obj
	$(CC) $(LFLAGS) $^ -o $@ $(LIBS)

obj/main.o: include/game.h

obj/game.o: include/game.h include/states.h include/welcome.h include/play.h include/results.h

obj/welcome.o: include/welcome.h include/states.h include/button.h

obj/play.o: include/play.h include/states.h include/button.h include/cherry.h

obj/cherry.o: include/cherry.h 

obj/button.o: include/button.h

obj/results.o: include/results.h include/states.h include/button.h

obj:
	$(MKDIR)


run: game$(EXE)
	.\game$(EXE)

clean:
	$(RM) $(CLEAN_OBJECTS) $(TARGET)$(EXE)


