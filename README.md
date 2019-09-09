Repository to benchmark duck2's generated_rr branch of VPR.

A very simple benchmarking script `run.sh` is provided. Prior to running:

1. Build new branch of VPR:
	- Clone https://github.com/duck2/vtr-verilog-to-routing.
	- Checkout the generated_rr branch.
	- [Build VPR](https://github.com/duck2/vtr-verilog-to-routing/blob/master%2Bwip/BUILDING.md).
2. Run the xc7/buttons test in your symbiflow-arch-defs repository.
	- The instructions for that are provided [here](https://github.com/SymbiFlow/symbiflow-arch-defs/tree/master/xc7/#running-examples).
3. Edit the script and set paths.
	- `D2` is the path to the duck2/vtr-verilog-to-routing repository..
	- `SYMB` is the path to your symbiflow-arch-defs repository.
4. Good to go!

Here is the output I get from `run.sh`:

```
Reading Artix 7 rr_graph with Conda VPR 1+5 times...
RR graph load times(last 5 runs)(s): 25.69 25.32 25.16 25.05 24.95
Peak memory usage(last 5 runs)(MiB): 2495.4 2495.1 2495.1 2493.6 2492.8
Reading Artix 7 rr_graph with duck2 VPR 1+5 times...
RR graph load times(last 5 runs)(s): 18.05 17.96 18.15 18.34 18.36
Peak memory usage(last 5 runs)(MiB): 1879.2 1879.1 1879.8 1879.7 1882.0
Reading and writing Artix 7 rr_graph(to /dev/null) with Conda VPR 3 times...
Read+write(Create Device) times(s): 58.64 59.06 57.72
Peak memory usage(MiB): 2495.3 2494.1 2494.2
Reading and writing Artix 7 rr_graph(to /dev/null) with duck2 VPR 3 times...
Read+write(Create Device) times(s): 31.17 30.86 30.95
Peak memory usage(MiB): 1951.6 1950.0 1955.5
Making a RR graph file in Cap'n Proto format using duck2 VPR...
Reading Artix 7 rr_graph in Cap'n Proto format with duck2 VPR 1+5 times...
RR graph load times(last 5 runs)(s): 12.27 12.26 12.34 12.29 12.43
Peak memory usage(last 5 runs)(MiB): 1996.9 1997.0 1997.0 1996.9 1996.8
```
