###############
## VARIABLES ##
###############

DEBUG ?= 1 #CHECKS DEBUG IF NOT ASIGNED EQAULS TO 1

ifeq ($(DEBUG), 1) #if (DEBUG == 1)
	CPP_COMPILER_FLAGS = -g -O0 -Wall -Wextra -Wpedantic -Wconversion -std=c++17
	EXECUTABLE_NAME = mainDebug
else
	CPP_COMPILER_FLAGS = -O3 -Wall -Wextra -Wpedantic -Wconversion -std=c++17
	EXECUTABLE_NAME = mainRelease
endif

CPP_COMPILER = g++
CPP_COMPILER_CALL = $(CPP_COMPILER) $(CPP_COMPILER_FLAGS) #concats compiler variable with the flags variable

CPP_SOURCES = $(wildcard *.cpp) #check for any cpp files
CPP_OBJECTS = $(patsubst %.cpp, %.o, $(CPP_SOURCES)) #Changes .cpp for .o for the list CPP_SOURCES 

####################
## PSEUDO-TARGETS ##
####################
build: $(EXECUTABLE_NAME) 


#############
## TARGETS ##
#############

#compiles main file. the first my_lib.o is the dependeancy of the command
$(EXECUTABLE_NAME): $(CPP_OBJECTS) #every file is concerted into an object
# all the objects converted into a single file
	$(CPP_COMPILER_CALL) $^ -o $@ 

#Preporcessed C file
prep:
	$(CPP_COMPILER_CALL) -E main.cpp > main.i

#Assembly
assembly:
	$(CPP_COMPILER_CALL) -S main.cpp 

#Machine code
object:
	$(CPP_COMPILER_CALL) -c main.cpp

#Executable
detailed:
	$(CPP_COMPILER_CALL) -E main.cpp > main.i
	$(CPP_COMPILER_CALL) -S main.i
	$(CPP_COMPILER_CALL) -c main.s
	$(CPP_COMPILER_CALL) main.o -o $(EXECUTABLE_NAME)

execute: #make excute DEBUG=1 / DEBUG=0   (debug/release)
	./$(EXECUTABLE_NAME)

#Compiles library
my_lib.o:
	$(CPP_COMPILER_CALL) my_lib.cpp -c 

##############
## PATTERNS ##
##############

#for each object, it dependes on a cpp file created with the following call
%.o: %.cpp
	$(CPP_COMPILER_CALL) -c $< -o $@
