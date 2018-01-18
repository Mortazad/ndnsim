# Gnuplot script file for plotting data in file "h_rtt_rto_late_prema_result_3_a.txt"
      # This file is called   plot1.p
      set   autoscale                        # scale axes automatically
      unset log                              # remove any log-scaling
	  set grid
      unset label                            # remove any previous labels
      set xtic auto                          # set xtics automatically
      set ytic auto                          # set ytics automatically
      set title "Alpha-to-P(RTT < RTO, RTT > RTO).eps"
      set xlabel "Alpha Parameter"
      set ylabel "Probability"
	  set terminal postscript eps enhanced color
       set output 'Alpha-to-P(RTT < RTO, RTT > RTO).eps'
	   
       plot "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_3_a.txt" u 1:5 w lp title 'H_s=3-RTT < RTO' , \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_4_a.txt" u 1:5 w lp title 'H_s=4-RTT < RTO' , \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_5_a.txt" u 1:5 w lp title 'H_s=5-RTT < RTO' , \
		"~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_3_a.txt" u 1:4 w lp title 'H_s=3-RTT > RTO' , \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_4_a.txt" u 1:4 w lp title 'H_s=4-RTT > RTO' , \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_5_a.txt" u 1:4 w lp title 'H_s=5-RTT > RTO'