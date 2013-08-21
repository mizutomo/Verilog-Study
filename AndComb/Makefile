DESIGN=and_comb
SRCS=$(DESIGN).v $(DESIGN)_tb.v
TOP=$(DESIGN)_tb
LOG=$(DESIGN).log
COM=$(DESIGN).do
WAVE=$(DESIGN).wlf
WORK=./work

all: work compile sim

work:
	if [ ! -d $(WORK) ]; then vlib $(WORK); fi

compile: $(SRCS)
	vlog $(SRCS) -work $(WORK)

sim:
	vsim -quiet -c $(TOP) -lib $(WORK) -do $(COM) -l $(LOG) -wlf $(WAVE)

clean:
	-@rm -rf $(WORK)
	-@rm $(WAVE)
