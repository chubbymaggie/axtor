PREFIX?=$(INSTALL_DIR)

# product definitions
LIB_AXTOR=$(PREFIX)/lib/libAxtor.so
LIB_AXTOROCL=$(PREFIX)/lib/libAxtor_OpenCL.so

all::


### configuration

# LLVM
LLVM_CXXFLAGS:=`llvm-config --cxxflags`
LLVM_LDFLAGS:=`llvm-config --ldflags`
LLVM_LIBS:=`llvm-config --libs`

# compiler customization
WARNLEVEL=-Wall -Werror
OPTLEVEL=-O0 -g

# compiler
CXX=g++ -std=c++11
CXXFLAGS=-fno-rtti -c -fPIC -Iinclude $(LLVM_CXXFLAGS) $(WARNLEVEL) $(OPTLEVEL)
LDFLAGS=-fPIC -Iinclude $(LLVM_LDFLAGS) $(LLVM_LIBS)


# Feature support

# LIBS += -lAxtor_OCL -lAxtor
CXXFLAGS += -DENABLE_OPENCL


# libraries
include lib/axtor/libAxtor.mk
include lib/axtor_ocl/libAxtor_OCL.mk


# tools
include tools/extractor/extractor.mk
# TODO


## Generic build rules

build/%.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) -o $@ $(CXXFLAGS) $^
	
	
.PHONY: clean
clean:
	rm -rf build/
