# Gnuplot script file for plotting data in file "h_rtt_rto_late_prema_result_3_a.txt"
      # This file is called   plot1.p
      set   autoscale                        # scale axes automatically
      unset log                              # remove any log-scaling
      unset label                            # remove any previous labels
	  set grid
      set xtic auto                          # set xtics automatically
      set ytic auto                          # set ytics automatically
      set title "Alpha-to-P_late-premature(f)"
      set xlabel "Alpha Parameter"
      set ylabel "Probability"
	  set terminal postscript eps enhanced color
       set output 'Alpha-to-P(late-premature(AvgRTT)).eps'
	  
      plot    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_3_a.txt" using 1:11 w lp title 'H_s=3-Late' , \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_4_a.txt" using 1:11 w lp title 'H_s=4-Late' , \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_5_a.txt" using 1:11 w lp title 'H_s=5-Late' ,\
		"~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_3_a.txt" using 1:12 w lp title 'H_s=3-Premature' , \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_4_a.txt" using 1:12 w lp title 'H_s=4-Premature' , \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rtt_rto_late_prema_result_5_a.txt" using 1:12 w lp title 'H_s=5-Premature'