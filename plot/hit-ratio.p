# Gnuplot script file for plotting data in file "hit-ratio-a.txt"
      # This file is called   plot1.p
      set   autoscale                        # scale axes automatically
      unset log                              # remove any log-scaling
      unset label                            # remove any previous labels
	  set grid
      set xtic auto                          # set xtics automatically
      set ytic auto                          # set ytics automatically
      set title "Alpha-to-HitRatio"
      set xlabel "Alpha Parameter"
      set ylabel "Hit Ratio"
	   set terminal postscript eps enhanced color
       set output 'Alpha-to-HitRatio.eps'
	  
      plot    "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/hit-ratio-a.txt" using 1:2 w lp title 'Rtr1' , \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/hit-ratio-a.txt" u 1:3 w lp title 'Rtr2' , \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/hit-ratio-a.txt" u 1:4 w lp title 'Rtr3' , \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/hit-ratio-a.txt" u 1:5 w lp title 'Rtr4' , \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/hit-ratio-a.txt" u 1:6 w lp title 'Rtr5' , \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/hit-ratio-a.txt" u 1:7 w lp title 'Rtr6' , \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/hit-ratio-a.txt" u 1:8 w lp title 'Rtr7' , \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo/FinalResult/hit-ratio-a.txt" u 1:9 w lp title 'Rtr8' , \

