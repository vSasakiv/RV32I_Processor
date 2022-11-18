
DIR := ${CURDIR}
define \n


endef
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
VERILOG_FILES := $(call rwildcard, src/,*.v)

VERILOG_FILES := $(filter-out src/template.v, $(VERILOG_FILES))

VERILOG_MODULES = $(filter %mod.v, $(VERILOG_FILES))
VERILOG_TESTBENCHES = $(filter %test.v, $(VERILOG_FILES))

clear:
	@del work
	@echo Pasta Work foi Limpa

prepare:
	@make clear
	@vlib work
	@echo Pasta Work foi Renovada

modules:
	$(foreach var, $(VERILOG_MODULES) , @vlog -incr +acc "$(DIR)/$(var)" ${\n})

tests:
	$(foreach var, $(VERILOG_TESTBENCHES) , @vlog -incr +acc "$(DIR)/$(var)" ${\n})

all:
	@make modules
	@make tests

test:
	@echo $(VERILOG_FILES)