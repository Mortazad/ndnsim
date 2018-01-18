gnuplot -persist <<-EOFMarker
load 'plot/hit-ratio.p'
load 'plot/hop.p'
load 'plot/w.p'
load 'plot/rtt-rto.p'
load 'plot/rtt-lower-Avgrtt.p'
load 'plot/compare-h.p'
load 'plot/compare-rto.p'
load 'plot/late-pre-rto.p'
load 'plot/late-pre-m.p'
load 'plot/late-pre-h.p'
load 'plot/late-pre-h.p'
load 'plot/late-pre-AvgRTT.p'
EOFMarker

mv Alpa-to-HitRatio.eps arbitrary_topo/FinalResult
mv Alpha-to-P(h< H, h > H).eps arbitrary_topo/FinalResult
mv Alpha-to-P(RTT < RTO, RTT > RTO).eps arbitrary_topo/FinalResult
mv Alpha-to-HopCount.eps arbitrary_topo/FinalResult
mv Alpha-to-P(late-premature(AvgRTT)).eps arbitrary_topo/FinalResult
mv Alpha-to-P(late-premature(f)).eps arbitrary_topo/FinalResult
mv Alpha-to-P_late-premature(H).eps arbitrary_topo/FinalResult
mv Alpha-to-P_late-premature(m).eps arbitrary_topo/FinalResult
mv Alpha-to-P_late-premature(RTO-RTT).eps arbitrary_topo/FinalResult
mv Alpha-to-rtt-rto.eps arbitrary_topo/FinalResult
mv a-to-w.eps arbitrary_topo/FinalResult