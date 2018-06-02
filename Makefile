FILES = src/*
VHDLEX = .vhd

TESTBENCHPATH = tests/${TESTBENCHFILE}$(VHDLEX)
TESTBENCHFILE = ${TEST}_tb

GHDL_CMD = ghdl
GHDL_FLAGS = --ieee=synopsys -fexplicit

SIMDIR = simu
STOP_TIME = 500ns
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)

WAVEFORM_VIEWER = open -a gtkwave

.PHONY: clean

all: clean compile run view

compile:
ifeq ($(strip $(TEST)),)
	@echo "TEST not set. Use TEST=<value> to set it."
	@exit 1
endif
	@mkdir -p simu
	@$(GHDL_CMD) -i $(GHDL_FLAGS) --workdir=simu --work=work $(TESTBENCHPATH) $(FILES)
	@$(GHDL_CMD) -m $(GHDL_FLAGS) --workdir=simu --work=work $(TESTBENCHFILE)

run:
	@$(GHDL_CMD) -r $(GHDL_FLAGS) --workdir=simu --work=work $(TESTBENCHFILE) $(GHDL_SIM_OPT) --vcd=$(SIMDIR)/$(TESTBENCHFILE).vcd --wave=$(SIMDIR)/$(TESTBENCHFILE).ghw

view:
	$(WAVEFORM_VIEWER) $(SIMDIR)/$(TESTBENCHFILE).ghw

clean:
	-@rm -rf $(SIMDIR)
	-@rm *_tb
	-@rm e~*.o
