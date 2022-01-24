###############
## VARIABLES ##
###############

COMPILATION_MODE ?= Debug 
ENABLE_WARNINGS ?= 1
WARNINGS_AS_ERRORS ?= 0
EXECUTABLE_PREFIX ?= main
CPP_COMPILER ?= g++ #g++, clang++
CPP_STANDARD ?= c++17 #c++11, c++14, c++17, c++20 


ifeq ($(COMPILATION_MODE), Debug)
	CPP_COMPILER_FLAGS = -g -O0  -std=$(CPP_STANDARD)
	EXECUTABLE_NAME = $(EXECUTABLE_PREFIX)Debug
else
	CPP_COMPILER_FLAGS = -O3 -std=$(CPP_STANDARD)
	EXECUTABLE_NAME = $(EXECUTABLE_PREFIX)Release
endif

ifeq ($(ENABLE_WARNINGS), 1)
	CPP_COMPILER_FLAGS += -Wall -Wextra -Wpedantic -Wconversion
endif

ifeq ($(WARNINGS_AS_ERRORS), 1)
	CPP_COMPILER_FLAGS += -Werror
endif


#compiler 
CPP_COMPILER_CALL = $(CPP_COMPILER) $(CPP_COMPILER_FLAGS) #concats compiler variable with the flags variable

#directories
INCLUDE_DIR = include
SOURCE_DIR = src
BUILD_DIR = build

#files
CPP_SOURCES =  $(wildcard $(SOURCE_DIR)/*.cpp) #check for any cpp files
CPP_OBJECTS = $(patsubst $(SOURCE_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(CPP_SOURCES)) #Changes .cpp for .o for the list CPP_SOURCES 


####################
## PSEUDO-TARGETS ##
####################

build: $(BUILD_DIR)/$(EXECUTABLE_NAME) 


#############
## TARGETS ##
#############

#compiles main file. the first my_lib.o is the dependeancy of the command
$(BUILD_DIR)/$(EXECUTABLE_NAME): $(CPP_OBJECTS) #every file is concerted into an object
# all the objects converted into a single file
	$(CPP_COMPILER_CALL) $^ -o $@ 

execute: #make excute DEBUG=1 / DEBUG=0   (debug/release)
	./$(BUILD_DIR)/$(EXECUTABLE_NAME)

clean: 
	rm $(BUILD_DIR)/*.o

forceBuild: clean build


# #Preporcessed C file
# prep:
# 	$(CPP_COMPILER_CALL) -E $(SOURCE_DIR)/main.cpp > $(BUILD_DIR)/main.i

# #Assembly
# assembly:
# 	$(CPP_COMPILER_CALL) -S $(SOURCE_DIR)/main.cpp 

# #Machine code
# object:
# 	$(CPP_COMPILER_CALL) -c $(SOURCE_DIR)/main.cpp

# #Executable
# detailed:
# 	$(CPP_COMPILER_CALL) -E main.cpp > main.i
# 	$(CPP_COMPILER_CALL) -S main.i
# 	$(CPP_COMPILER_CALL) -c main.s
# 	$(CPP_COMPILER_CALL) main.o -o $(EXECUTABLE_NAME)


# #Compiles library
# my_lib.o:
# 	$(CPP_COMPILER_CALL) my_lib.cpp -c 


##############
## PATTERNS ##
##############

#for each object, it dependes on a cpp file created with the following call
$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp
	$(CPP_COMPILER_CALL) -I $(INCLUDE_DIR) -c $< -o $@
	

###########
## PHONY ##
###########
