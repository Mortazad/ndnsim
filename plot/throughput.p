# Gnuplot script file for plotting data in file "throughput-a.txt"
      # This file is called   plot1.p
      set   autoscale                        # scale axes automatically
      unset log                              # remove any log-scaling
      unset label                            # remove any previous labels
	  set grid
      set xtic auto                          # set xtics automatically
      set ytic auto                          # set ytics automatically
      set title "Alpha-to-throughput"
      set xlabel "Alpha Parameter"
      set ylabel "Troughput"
	  set terminal postscript eps enhanced color
       set output 'Alpha-to-throughput.eps'
	  
      plot    "~/Desktop/ndnSIM/ns-3/arbitrary_topo-1/FinalResult/throughput_a.txt" using 1:2 w lp title 'H_s=5(Prod11)', \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo-1/FinalResult/throughput_a.txt" using 1:3 w lp title 'H_s=5(Prod21)', \
	  "~/Desktop/ndnSIM/ns-3/arbitrary_topo-1/FinalResult/throughput_a.txt" using 1:4 w lp title 'H_s=3(BTP1)', \
	   "~/Desktop/ndnSIM/ns-3/arbitrary_topo-1/FinalResult/throughput_a.txt" using 1:5 w lp title 'H_s=3(BTP2)', \
	    "~/Desktop/ndnSIM/ns-3/arbitrary_topo-1/FinalResult/throughput_a.txt" using 1:6 w lp title 'H_s=3(BTP3)', \
		 "~/Desktop/ndnSIM/ns-3/arbitrary_topo-1/FinalResult/throughput_a.txt" using 1:7 w lp title 'H_s=4(BTP32)', \
		  "~/Desktop/ndnSIM/ns-3/arbitrary_topo-1/FinalResult/throughput_a.txt" using 1:8 w lp title 'H_s=3(BTP4)', \
		   "~/Desktop/ndnSIM/ns-3/arbitrary_topo-1/FinalResult/throughput_a.txt" using 1:9 w lp title 'H_s=4(BTP42)', 
