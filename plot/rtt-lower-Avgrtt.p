#
      set   autoscale                        # scale axes automatically
      unset log                              # remove any log-scaling
	  set grid
      unset label                            # remove any previous labels
      set xtic auto                          # set xtics automatically
      set ytic auto                          # set ytics automatically
      set title "Alpha-to-P(RTT < AvgRTT, and RTT > AvgRTT)"
      set xlabel "Alpha Parameter"
      set ylabel "Probability"
	  set terminal postscript eps enhanced color
       set output 'Alpha-to-P( RTT < AvgRTT, RTT > AvgRTT).eps'
	  
      plot    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_3_a.txt" using 1:2 w lp title 'H_s=3-RTT < AvgRTT' , \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_4_a.txt" u 1:2 w lp title 'H_s=4-RTT < AvgRTT' , \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_5_a.txt" u 1:2 w lp title 'H_s=5-RTT < AvgRTT' , \
		 "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_4_a.txt" u 1:3 w lp title 'H_s=4-RTT > AvgRTT' , \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_5_a.txt" u 1:3 w lp title 'H_s=5-RTT > AvgRTT' , \
		 "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_3_a.txt" u 1:3 w lp title 'H_s=5-RTT > AvgRTT' 
		
		