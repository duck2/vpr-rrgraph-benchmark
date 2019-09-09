# Compare rr_graph loading performance of duck2's generated_rr branch against Conda VPR.

# Configuration:

# Location of my VTR fork.
D2=

# Location of symbiflow-arch-defs repository.
# Be sure to run `make buttons_basys3_bin` before running this script!
# The files created by that target are used here.
SYMB=


#


# Hopefully
D2_VPR=${D2}/vpr/vpr
CONDA_VPR=${SYMB}/build/env/conda/bin/vpr

# Too lazy to parameterize those...

VPR_ARGS="${SYMB}/build/xc7/archs/artix7/devices/xc7a50t-basys3-roi-virt/arch.timing.xml ${SYMB}/build/xc7/tests/buttons/buttons_basys3/artix7-xc7a50t-basys3-roi-virt-xc7a50t-basys3-test/top.eblif --device xc7a50t-basys3-test --read_rr_graph ${SYMB}/build/xc7/archs/artix7/devices/rr_graph_xc7a50t-basys3_test.rr_graph.real.xml --min_route_chan_width_hint 100 --max_criticality 0.0 --max_router_iterations 500 --routing_failure_predictor off --router_high_fanout_threshold -1 --constant_net_method route --route_chan_width 500 --clock_modeling route --place_algorithm bounding_box --enable_timing_computations off --allow_unrelated_clustering on --clustering_pin_feasibility_filter off --disable_check_route on --strict_checks off --allow_dangling_combinational_nodes on --disable_errors check_unbuffered_edges:check_route --suppress_warnings ${SYMB}/build/xc7/tests/buttons/buttons_basys3/artix7-xc7a50t-basys3-roi-virt-xc7a50t-basys3-test/noisy_warnings.log,sum_pin_class:check_unbuffered_edges:load_rr_indexed_data_T_values:check_rr_node:trans_per_R --pack"

VPR_ARGS_WRITE="${SYMB}/build/xc7/archs/artix7/devices/xc7a50t-basys3-roi-virt/arch.timing.xml ${SYMB}/build/xc7/tests/buttons/buttons_basys3/artix7-xc7a50t-basys3-roi-virt-xc7a50t-basys3-test/top.eblif --device xc7a50t-basys3-test --read_rr_graph ${SYMB}/build/xc7/archs/artix7/devices/rr_graph_xc7a50t-basys3_test.rr_graph.real.xml --write_rr_graph /dev/null --min_route_chan_width_hint 100 --max_criticality 0.0 --max_router_iterations 500 --routing_failure_predictor off --router_high_fanout_threshold -1 --constant_net_method route --route_chan_width 500 --clock_modeling route --place_algorithm bounding_box --enable_timing_computations off --allow_unrelated_clustering on --clustering_pin_feasibility_filter off --disable_check_route on --strict_checks off --allow_dangling_combinational_nodes on --disable_errors check_unbuffered_edges:check_route --suppress_warnings ${SYMB}/build/xc7/tests/buttons/buttons_basys3/artix7-xc7a50t-basys3-roi-virt-xc7a50t-basys3-test/noisy_warnings.log,sum_pin_class:check_unbuffered_edges:load_rr_indexed_data_T_values:check_rr_node:trans_per_R --pack"

VPR_ARGS_WRITE_CAPN="${SYMB}/build/xc7/archs/artix7/devices/xc7a50t-basys3-roi-virt/arch.timing.xml ${SYMB}/build/xc7/tests/buttons/buttons_basys3/artix7-xc7a50t-basys3-roi-virt-xc7a50t-basys3-test/top.eblif --device xc7a50t-basys3-test --read_rr_graph ${SYMB}/build/xc7/archs/artix7/devices/rr_graph_xc7a50t-basys3_test.rr_graph.real.xml --write_rr_graph xc7a50t.rr_graph --min_route_chan_width_hint 100 --max_criticality 0.0 --max_router_iterations 500 --routing_failure_predictor off --router_high_fanout_threshold -1 --constant_net_method route --route_chan_width 500 --clock_modeling route --place_algorithm bounding_box --enable_timing_computations off --allow_unrelated_clustering on --clustering_pin_feasibility_filter off --disable_check_route on --strict_checks off --allow_dangling_combinational_nodes on --disable_errors check_unbuffered_edges:check_route --suppress_warnings ${SYMB}/build/xc7/tests/buttons/buttons_basys3/artix7-xc7a50t-basys3-roi-virt-xc7a50t-basys3-test/noisy_warnings.log,sum_pin_class:check_unbuffered_edges:load_rr_indexed_data_T_values:check_rr_node:trans_per_R --pack"

VPR_ARGS_READ_CAPN="${SYMB}/build/xc7/archs/artix7/devices/xc7a50t-basys3-roi-virt/arch.timing.xml ${SYMB}/build/xc7/tests/buttons/buttons_basys3/artix7-xc7a50t-basys3-roi-virt-xc7a50t-basys3-test/top.eblif --device xc7a50t-basys3-test --read_rr_graph xc7a50t.rr_graph --min_route_chan_width_hint 100 --max_criticality 0.0 --max_router_iterations 500 --routing_failure_predictor off --router_high_fanout_threshold -1 --constant_net_method route --route_chan_width 500 --clock_modeling route --place_algorithm bounding_box --enable_timing_computations off --allow_unrelated_clustering on --clustering_pin_feasibility_filter off --disable_check_route on --strict_checks off --allow_dangling_combinational_nodes on --disable_errors check_unbuffered_edges:check_route --suppress_warnings ${SYMB}/build/xc7/tests/buttons/buttons_basys3/artix7-xc7a50t-basys3-roi-virt-xc7a50t-basys3-test/noisy_warnings.log,sum_pin_class:check_unbuffered_edges:load_rr_indexed_data_T_values:check_rr_node:trans_per_R --pack"

#

echo "Reading Artix 7 rr_graph with Conda VPR 1+5 times..."
${CONDA_VPR} ${VPR_ARGS} > /dev/null
for i in $(seq 1 5); do
	x=$(${CONDA_VPR} ${VPR_ARGS} | sed -n "s/## Loading routing resource graph took \(.*\) seconds (max_rss \(.*\) MiB,.*)/\1 \2/p")
	times="${times} $(echo $x | awk '{print $1;}')"
	mems="${mems} $(echo $x | awk '{print $2;}')"
done

echo -n "RR graph load times(last 5 runs)(s): "
echo $times
echo -n "Peak memory usage(last 5 runs)(MiB): "
echo $mems

#

unset times
unset mems

echo "Reading Artix 7 rr_graph with duck2 VPR 1+5 times..."
${CONDA_VPR} ${VPR_ARGS} > /dev/null
for i in $(seq 1 5); do
	x=$(${D2_VPR} ${VPR_ARGS} | sed -n "s/## Loading routing resource graph took \(.*\) seconds (max_rss \(.*\) MiB,.*)/\1 \2/p")
	times="${times} $(echo $x | awk '{print $1;}')"
	mems="${mems} $(echo $x | awk '{print $2;}')"
done

echo -n "RR graph load times(last 5 runs)(s): "
echo $times
echo -n "Peak memory usage(last 5 runs)(MiB): "
echo $mems

#

unset times
unset mems

echo "Reading and writing Artix 7 rr_graph(to /dev/null) with Conda VPR 3 times..."
for i in $(seq 1 3); do
	x=$(${CONDA_VPR} ${VPR_ARGS_WRITE} | sed -n "s/# Create Device took \(.*\) seconds (max_rss \(.*\) MiB,.*)/\1 \2/p")
	times="${times} $(echo $x | awk '{print $1;}')"
	mems="${mems} $(echo $x | awk '{print $2;}')"
done

echo -n "Read+write(Create Device) times(s): "
echo $times
echo -n "Peak memory usage(MiB): "
echo $mems

#

unset times
unset mems

echo "Reading and writing Artix 7 rr_graph(to /dev/null) with duck2 VPR 3 times..."
for i in $(seq 1 3); do
	x=$(${D2_VPR} ${VPR_ARGS_WRITE} | sed -n "s/# Create Device took \(.*\) seconds (max_rss \(.*\) MiB,.*)/\1 \2/p")
	times="${times} $(echo $x | awk '{print $1;}')"
	mems="${mems} $(echo $x | awk '{print $2;}')"
done

echo -n "Read+write(Create Device) times(s): "
echo $times
echo -n "Peak memory usage(MiB): "
echo $mems

#

echo "Making a RR graph file in Cap'n Proto format using duck2 VPR..."

${D2_VPR} ${VPR_ARGS_WRITE_CAPN} > /dev/null

unset times
unset mems

echo "Reading Artix 7 rr_graph in Cap'n Proto format with duck2 VPR 1+5 times..."
${D2_VPR} ${VPR_ARGS_READ_CAPN} > /dev/null
for i in $(seq 1 5); do
	x=$(${D2_VPR} ${VPR_ARGS_READ_CAPN} | sed -n "s/## Loading routing resource graph took \(.*\) seconds (max_rss \(.*\) MiB,.*)/\1 \2/p")
	times="${times} $(echo $x | awk '{print $1;}')"
	mems="${mems} $(echo $x | awk '{print $2;}')"
done

echo -n "RR graph load times(last 5 runs)(s): "
echo $times
echo -n "Peak memory usage(last 5 runs)(MiB): "
echo $mems
