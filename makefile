
DIR := ${CURDIR}
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
VERILOG_FILES := $(call rwildcard, src/,*.v)

VERILOG_MODULES = $(filter %mod.v, $(VERILOG_FILES))
VERILOG_TESTBENCHES = $(filter %test.v, $(VERILOG_FILES))

clear:
	@del work
	@echo Pasta Work foi Limpa

prepare:
	@del work
	@echo Pasta Work foi Limpa
	@vlib work
	@echo Pasta Work foi Renovada

modules:
	$(foreach var, $(VERILOG_MODULES) , @vlog "$(DIR)/$(var)")

tests:
	$(foreach var, $(VERILOG_TESTBENCHES) , @vlog "$(DIR)/$(var)")

all:
	@make modules
	@make tests

test:
	$(foreach var, $(VERILOG_MODULES) , vlog "$(DIR)/$(var)")