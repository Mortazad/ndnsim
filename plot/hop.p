# Gnuplot script file for plotting data in file "hit-ratio-a.txt"
      # This file is called   plot1.p
      set   autoscale                        # scale axes automatically
      unset log                              # remove any log-scaling
      unset label                            # remove any previous labels
	  set grid
      set xtic auto                          # set xtics automatically
      set ytic auto                          # set ytics automatically
      set title "Alpha-to-HopCount"
      set xlabel "Alpha Parameter"
      set ylabel "Hop Count"
	  set terminal postscript eps enhanced color
       set output 'Alpha-to-HopCount.eps'
	  
      plot    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_3_a.txt" using 1:2 w lp title 'H_s=3', \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_4_a.txt" using 1:2 w lp title 'H_s=4', \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/h_rto_rtt_5_a.txt" using 1:2 w lp title 'H_s=5'
