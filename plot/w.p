# Gnuplot script file for plotting data in file "hit-ratio-a.txt"
      # This file is called   plot1.p
      set   autoscale                        # scale axes automatically
	  set grid
      unset log                              # remove any log-scaling
      unset label                            # remove any previous labels
      set xtic auto                          # set xtics automatically
      set ytic auto                          # set ytics automatically
      set title "Alpha-to-W"
      set xlabel "Alpha Parameter"
      set ylabel "W"
	  set terminal postscript eps enhanced color
       set output 'a-to-w.eps' 
	  
	  plot    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_3_a.txt" using 1:6 w lp title 'H_s=3', \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_4_a.txt" using 1:6 w lp title 'H_s=4', \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_5_a.txt" using 1:6 w lp title 'H_s=5'

