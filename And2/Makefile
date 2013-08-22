DESIGN = and2
SRCS = $(DESIGN).v $(DESIGN)test.v

all: com sim

com:
	iverilog -o $(DESIGN) $(SRCS)

sim:
	vvp $(DESIGN)

clean:
	-rm $(DESIGN) *.vcd
