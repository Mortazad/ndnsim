# Gnuplot script file for plotting data in file "hit-ratio-a.txt"
      # This file is called   plot1.p
      set   autoscale                        # scale axes automatically
      unset log                              # remove any log-scaling
      unset label                            # remove any previous labels
	  set grid
      set xtic auto                          # set xtics automatically
      set ytic auto                          # set ytics automatically
      set title "Alpha-to-rtt-rto"
      set xlabel "Alpha Parameter"
      set ylabel "ms"
	  set terminal postscript eps enhanced color
       set output 'Alpha-to-rtt-rto.eps'
	  
      plot    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_3_a.txt" using 1:3 w lp title 'rtt-H_s=3', \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_4_a.txt" using 1:3 w lp title 'rtt-H_s=4', \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_5_a.txt" using 1:3 w lp title 'rtt-H_s=5', \
		"~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_3_a.txt" using 1:4 w lp title 'rto-H_s=3', \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_4_a.txt" using 1:4 w lp title 'rto-H_s=4', \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_5_a.txt" using 1:4 w lp title 'rto-H_s=5', \
				"~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_3_a.txt" using 1:5 w lp title '(rto-rtt)H_s=3', \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_4_a.txt" using 1:5 w lp title '(rto-rtt)H_s=4', \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_5_a.txt" using 1:5 w lp title '(rto-rtt)H_s=5'