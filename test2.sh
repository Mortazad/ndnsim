#!/bin/bash
. ~/Desktop/ndnSIM/ns-3


echo mortazad | sudo -S echo -n 2>/dev/random 1>/dev/random


# determinig alpha parameter and run the simulation 100 times for each alpha
for a in 1.0 1.2 1.4 1.6 1.8 2.0
do

for r in {1..3}
do

#create separate trace for each content and calculate Mean HopCount, RTO, RTT and total number of sent packets for them
#5 hops
for sq in {1..5000}
do
awk -v awk_s=$sq ' ($4 == awk_s && $3 == "/Prod11") {print $1, $2, $3, $4, $5, $6, $7, $8, $9 "\n" }' arbitrary_topo-1/alpha_$a/run_$r/output.txt > arbitrary_topo-1/out_5_$sq.txt
awk -f awk_late_pre.txt arbitrary_topo-1/out_5_$sq.txt >> arbitrary_topo-1/h_rto_rtt_5.txt
shred --remove arbitrary_topo-1/out_5_$sq.txt
done

#4hops
for sq in {1..5000}
do
awk -v awk_s=$sq ' ($4 == awk_s && $3 == "/BTP32") {print $1, $2, $3, $4, $5, $6, $7, $8, $9 "\n" }' arbitrary_topo-1/alpha_$a/run_$r/output.txt > arbitrary_topo-1/out_4_$sq.txt
awk -f awk_late_pre.txt arbitrary_topo-1/out_4_$sq.txt >> arbitrary_topo-1/h_rto_rtt_4.txt
shred --remove arbitrary_topo-1/out_4_$sq.txt
done

#3hops
for sq in {1..5000}
do
awk -v awk_s=$sq ' ($4 == awk_s && $3 == "/BTP1") {print $1, $2, $3, $4, $5, $6, $7, $8, $9 "\n" }' arbitrary_topo-1/alpha_$a/run_$r/output.txt > arbitrary_topo-1/out_3_$sq.txt
awk -f awk_late_pre.txt arbitrary_topo-1/out_3_$sq.txt >> arbitrary_topo-1/h_rto_rtt_3.txt
shred --remove arbitrary_topo-1/out_3_$sq.txt
done

#calculate total number of sent packets and total number of lost packets and finally "loss_probability"
awk '(($5 == "OutData") || ($5 == "OutInterests") || ($5 == "OutNacks")) {s += $8}; END {print s}' arbitrary_topo-1/alpha_$a/run_$r/rate-trace.txt >> arbitrary_topo-1/p_loss.txt
gawk '{total += $1 }; END {print "total_number_of_sent_packets:", total}' arbitrary_topo-1/p_loss.txt >> arbitrary_topo-1/p_loss.txt
gawk '{loss += $7}; END {print "total_number_of_lost_packets:", loss}' arbitrary_topo-1/alpha_$a/run_$r/drop-trace.txt >> arbitrary_topo-1/p_loss.txt
gawk '($1 == "total_number_of_sent_packets:") { sp = $2} ( $1 == "total_number_of_lost_packets:" ) { lp = $2}; END {print "loss_Probability:", lp/sp }' arbitrary_topo-1/p_loss.txt >> arbitrary_topo-1/p_loss.txt

#calculate probabilty of RTO<RTT and RTO>RTT and h(c)<H and hc>H for five hop connection
gawk '{ t_h += $2; t_rtt += $3; t_w += $6; t_rto += $4; c += 1; t_late += $9; t_pre += $10; t_plate += $11; t_pprem += $12; t_pn += $8} END {print "ave_H:", (t_h/c), "ave_rtt:", (t_rtt/c), "ave_w:", (t_w/c), "no_content:", c, "ave_rto:", (t_rto/c), "p_late4:", t_plate/c, "p_prem4:", t_pprem/c, "p_late5:", t_late/t_pn, "p_prem5:", t_pre/t_pn }' arbitrary_topo-1/h_rto_rtt_5.txt >> arbitrary_topo-1/h_rto_rtt_5_1.txt
awk '{if ($1 != "ave_H:" ){ print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12 }}' arbitrary_topo-1/h_rto_rtt_5.txt >> arbitrary_topo-1/h_rto_rtt_5_1.txt
awk -f awk_p_h_rtt.txt arbitrary_topo-1/h_rto_rtt_5_1.txt >> arbitrary_topo-1/p_late_premature_5.txt
gawk '($1 == "total_number_of_sent_packets:") { sp = $2} ( $1 == "total_number_of_lost_packets:" ) { lp = $2}; END {print "loss_Probability:", lp/sp }' arbitrary_topo-1/p_loss.txt >> arbitrary_topo-1/p_late_premature_5.txt
gawk '($1 == "p_h_lower_H=") { p_h_lowerH = $2} ( $1 == "p_h_higher_H=" ) { p_h_higherH = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late:", p_h_lowerH *p_loss"\n", "p_premature:", p_h_higherH *(1-p_loss) }' arbitrary_topo-1/p_late_premature_5.txt >> arbitrary_topo-1/p_late_premature_5.txt
gawk '($1 == "p_rtt_lower_avgrtt=") { p_rtt_lower_avgrtt = $2} ( $1 == "p_rtt_higher_avgrtt=" ) { p_rtt_higher_avgrtt = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late2:", p_rtt_higher_avgrtt*p_loss"\n", "p_premature2:", p_rtt_lower_avgrtt*(1-p_loss) }' arbitrary_topo-1/p_late_premature_5.txt >> arbitrary_topo-1/p_late_premature_5.txt
gawk '($1 == "p_rto_lower_rtt=") { p_rto_lower_rtt = $2} ( $1 == "p_rto_higher_rtt=" ) { p_rto_higher_rtt = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late3:", p_rto_higher_rtt*p_loss"\n", "p_premature3:", p_rto_lower_rtt*(1-p_loss) }' arbitrary_topo-1/p_late_premature_5.txt >> arbitrary_topo-1/p_late_premature_5.txt

awk -f awk_h_rtt_rto_late_prema_result.txt arbitrary_topo-1/p_late_premature_5.txt >> arbitrary_topo-1/h_rtt_rto_late_prema_result_5.txt

#calculate probabilty of RTO<RTT and RTO>RTT and h(c)<H and hc>H for four hop connection
gawk '{ t_h += $2; t_rtt += $3; t_w += $6; t_rto += $4; c += 1; t_late += $9; t_pre += $10; t_plate += $11; t_pprem += $12; t_pn += $8} END {print "ave_H:", (t_h/c), "ave_rtt:", (t_rtt/c), "ave_w:", (t_w/c), "no_content:", c, "ave_rto:", (t_rto/c), "p_late4:", t_plate/c, "p_prem4:", t_pprem/c, "p_late5:", t_late/t_pn, "p_prem5:", t_pre/t_pn }' arbitrary_topo-1/h_rto_rtt_4.txt >> arbitrary_topo-1/h_rto_rtt_4_1.txt
awk '{if ($1 != "ave_H:" ){ print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12 }}' arbitrary_topo-1/h_rto_rtt_4.txt >> arbitrary_topo-1/h_rto_rtt_4_1.txt
awk -f awk_p_h_rtt.txt arbitrary_topo-1/h_rto_rtt_4_1.txt >> arbitrary_topo-1/p_late_premature_4.txt
gawk '($1 == "total_number_of_sent_packets:") { sp = $2} ( $1 == "total_number_of_lost_packets:" ) { lp = $2}; END {print "loss_Probability:", lp/sp }' arbitrary_topo-1/p_loss.txt >> arbitrary_topo-1/p_late_premature_4.txt
gawk '($1 == "p_h_lower_H=") { p_h_lowerH = $2} ( $1 == "p_h_higher_H=" ) { p_h_higherH = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late:", p_h_lowerH *p_loss"\n", "p_premature:", p_h_higherH *(1-p_loss) }' arbitrary_topo-1/p_late_premature_4.txt >> arbitrary_topo-1/p_late_premature_4.txt
gawk '($1 == "p_rtt_lower_avgrtt=") { p_rtt_lower_avgrtt = $2} ( $1 == "p_rtt_higher_avgrtt=" ) { p_rtt_higher_avgrtt = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late2:", p_rtt_higher_avgrtt*p_loss"\n", "p_premature2:", p_rtt_lower_avgrtt*(1-p_loss) }' arbitrary_topo-1/p_late_premature_4.txt >> arbitrary_topo-1/p_late_premature_4.txt
gawk '($1 == "p_rto_lower_rtt=") { p_rto_lower_rtt = $2} ( $1 == "p_rto_higher_rtt=" ) { p_rto_higher_rtt = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late3:", p_rto_higher_rtt*p_loss"\n", "p_premature3:", p_rto_lower_rtt*(1-p_loss) }' arbitrary_topo-1/p_late_premature_4.txt >> arbitrary_topo-1/p_late_premature_4.txt

awk -f awk_h_rtt_rto_late_prema_result.txt arbitrary_topo-1/p_late_premature_4.txt >> arbitrary_topo-1/h_rtt_rto_late_prema_result_4.txt

#calculate probabilty of RTO<RTT and RTO>RTT and h(c)<H and hc>H for three hop connection
gawk '{ t_h += $2; t_rtt += $3; t_w += $6; t_rto += $4; c += 1; t_late += $9; t_pre += $10; t_plate += $11; t_pprem += $12; t_pn += $8} END {print "ave_H:", (t_h/c), "ave_rtt:", (t_rtt/c), "ave_w:", (t_w/c), "no_content:", c, "ave_rto:", (t_rto/c), "p_late4:", t_plate/c, "p_prem4:", t_pprem/c, "p_late5:", t_late/t_pn, "p_prem5:", t_pre/t_pn }' arbitrary_topo-1/h_rto_rtt_3.txt >> arbitrary_topo-1/h_rto_rtt_3_1.txt
awk '{if ($1 != "ave_H:" ){ print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12 }}' arbitrary_topo-1/h_rto_rtt_3.txt >> arbitrary_topo-1/h_rto_rtt_3_1.txt
awk -f awk_p_h_rtt.txt arbitrary_topo-1/h_rto_rtt_3_1.txt >> p_late_premature_3.txt
gawk '($1 == "total_number_of_sent_packets:") { sp = $2} ( $1 == "total_number_of_lost_packets:" ) { lp = $2}; END {print "loss_Probability:", lp/sp }' arbitrary_topo-1/p_loss.txt >> arbitrary_topo-1/p_late_premature_3.txt
gawk '($1 == "p_h_lower_H=") { p_h_lowerH = $2} ( $1 == "p_h_higher_H=" ) { p_h_higherH = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late:", p_h_lowerH *p_loss"\n", "p_premature:", p_h_higherH *(1-p_loss) }' arbitrary_topo-1/p_late_premature_3.txt >> arbitrary_topo-1/p_late_premature_3.txt
gawk '($1 == "p_rtt_lower_avgrtt=") { p_rtt_lower_avgrtt = $2} ( $1 == "p_rtt_higher_avgrtt=" ) { p_rtt_higher_avgrtt = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late2:", p_rtt_higher_avgrtt*p_loss"\n", "p_premature2:", p_rtt_lower_avgrtt*(1-p_loss) }' arbitrary_topo-1/p_late_premature_3.txt >> arbitrary_topo-1/p_late_premature_3.txt
gawk '($1 == "p_rto_lower_rtt=") { p_rto_lower_rtt = $2} ( $1 == "p_rto_higher_rtt=" ) { p_rto_higher_rtt = $2} ( $1 == "loss_Probability:" ) { p_loss = $2}; END {print "p_late3:", p_rto_higher_rtt*p_loss"\n", "p_premature3:", p_rto_lower_rtt*(1-p_loss) }' arbitrary_topo-1/p_late_premature_3.txt >> arbitrary_topo-1/p_late_premature_3.txt

awk -f awk_h_rtt_rto_late_prema_result.txt arbitrary_topo-1/p_late_premature_3.txt >> arbitrary_topo-1/h_rtt_rto_late_prema_result_3.txt

#calculate average hit ratio in each router
awk -f awk_hit-ratio.txt arbitrary_topo-1/alpha_$a/run_$r/cs-trace.txt >> arbitrary_topo-1/hit-ratio.txt

#calculate throughput
awk -f awk_throughput.txt arbitrary_topo-1/alpha_$a/run_$r/output.txt >> arbitrary_topo-1/throughput.txt

awk '{ r2 += $2; r3 += $3; r4 += $4; r5 += $5; r6 += $6; n+= 1;} END {print r2/n, r3/n, r4/n, r5/n, r6/n}' arbitrary_topo-1/h_rto_rtt_5.txt >> arbitrary_topo-1/h_rto_rtt_5_avg.txt
awk '{ r2 += $2; r3 += $3; r4 += $4; r5 += $5; r6 += $6; n+= 1;} END {print r2/n, r3/n, r4/n, r5/n, r6/n}' arbitrary_topo-1/h_rto_rtt_4.txt >> arbitrary_topo-1/h_rto_rtt_4_avg.txt
awk '{ r2 += $2; r3 += $3; r4 += $4; r5 += $5; r6 += $6; n+= 1;} END {print r2/n, r3/n, r4/n, r5/n, r6/n}' arbitrary_topo-1/h_rto_rtt_3.txt >> arbitrary_topo-1/h_rto_rtt_3_avg.txt


mv arbitrary_topo-1/p_late_premature_5.txt arbitrary_topo-1/run_$r
mv arbitrary_topo-1/p_late_premature_4.txt arbitrary_topo-1/run_$r
mv arbitrary_topo-1/p_late_premature_3.txt arbitrary_topo-1/run_$r
mv  arbitrary_topo-1/h_rto_rtt_3.txt arbitrary_topo-1/run_$r
mv  arbitrary_topo-1/h_rto_rtt_4.txt arbitrary_topo-1/run_$r
mv  arbitrary_topo-1/h_rto_rtt_5.txt arbitrary_topo-1/run_$r
mv  arbitrary_topo-1/h_rto_rtt_3_1.txt arbitrary_topo-1/run_$r
mv  arbitrary_topo-1/h_rto_rtt_4_1.txt arbitrary_topo-1/run_$r
mv  arbitrary_topo-1/h_rto_rtt_5_1.txt arbitrary_topo-1/run_$r
#a simulation run for an alpha completed
done
 
 #calculate average hit ratio for each q
 awk -v a=$a '{r1 += $1; r2 += $2; r3 += $3; r4 += $4; r5 += $5; r6 += $6; r7 += $7; r8 += $8; r9 += $9; r10 += $10; r11 += $11; n += 1;} END {print a, r1/n, r2/n, r3/n, r4/n, r5/n, r6/n, r7/n, r8/n, r9/n, r10/n, r11/n}' arbitrary_topo-1/hit-ratio.txt >> arbitrary_topo-1/hit-ratio-a.txt 
 
 #calculate average "p_rtt_lower_avgrtt=", "p_rtt_higher_avgrtt=", "p_rto_lower_rtt=", "p_rto_higher_rtt=", "p_h_lower_H=", "p_h_higher_H=", "loss_Probability", "p_late:", "p_premature:"
 awk -v a=$a '{r1 += $1; r2 += $2; r3 += $3; r4 += $4; r5 += $5; r6 += $6; r7 += $7; r8 += $8; r9 += $9; r10 += $10; r11 += $11; r12 += $12; r13 += $13; r14 += $14; r15 += $15; r16 += $16; r17 += $17; n += 1;} END {print a, r1/n, r2/n, r3/n, r4/n, r5/n, r6/n, r7/n, r8/n, r9/n, r10/n, r11/n, r12/n, r13/n, r14/n, r15/n, r16/n, r17/n}'  arbitrary_topo-1/h_rtt_rto_late_prema_result_3.txt >> arbitrary_topo-1/h_rtt_rto_late_prema_result_3_a.txt
 awk -v a=$a '{r1 += $1; r2 += $2; r3 += $3; r4 += $4; r5 += $5; r6 += $6; r7 += $7; r8 += $8; r9 += $9; r10 += $10; r11 += $11; r12 += $12; r13 += $13; r14 += $14; r15 += $15; r16 += $16; r17 += $17; n += 1;} END {print a, r1/n, r2/n, r3/n, r4/n, r5/n, r6/n, r7/n, r8/n, r9/n, r10/n, r11/n, r12/n, r13/n, r14/n, r15/n, r16/n, r17/n}'  arbitrary_topo-1/h_rtt_rto_late_prema_result_4.txt >> arbitrary_topo-1/h_rtt_rto_late_prema_result_4_a.txt
 awk -v a=$a '{r1 += $1; r2 += $2; r3 += $3; r4 += $4; r5 += $5; r6 += $6; r7 += $7; r8 += $8; r9 += $9; r10 += $10; r11 += $11; r12 += $12; r13 += $13; r14 += $14; r15 += $15; r16 += $16; r17 += $17; n += 1;} END {print a, r1/n, r2/n, r3/n, r4/n, r5/n, r6/n, r7/n, r8/n, r9/n, r10/n, r11/n, r12/n, r13/n, r14/n, r15/n, r16/n, r17/n}'  arbitrary_topo-1/h_rtt_rto_late_prema_result_5.txt >> arbitrary_topo-1/h_rtt_rto_late_prema_result_5_a.txt

# calculate average hcount/n, RTT/n, RTO/n, ((RTO/n)-(RTT/n)), ((RTO/n)/(RTT/n)
awk -v a=$a '{r1 += $1; r2 += $2; r3 += $3; r4 += $4; r5 += $5; n+= 1;} END {print a, r1/n, r2/n, r3/n, r4/n, r5/n}' arbitrary_topo-1/h_rto_rtt_5_avg.txt >> arbitrary_topo-1/h_rto_rtt_5_a.txt
awk -v a=$a '{r1 += $1; r2 += $2; r3 += $3; r4 += $4; r5 += $5; n+= 1;} END {print a, r1/n, r2/n, r3/n, r4/n, r5/n}' arbitrary_topo-1/h_rto_rtt_4_avg.txt >> arbitrary_topo-1/h_rto_rtt_4_a.txt
awk -v a=$a '{r1 += $1; r2 += $2; r3 += $3; r4 += $4; r5 += $5; n+= 1;} END {print a, r1/n, r2/n, r3/n, r4/n, r5/n}' arbitrary_topo-1/h_rto_rtt_3_avg.txt >> arbitrary_topo-1/h_rto_rtt_3_a.txt

#calculate average throughput for each stream
awk -v a=$a '{r1 += $1; r2 += $2; r3 += $3; r4 += $4; r5 += $5; r6 += $6; r7 += $7; r8 += $8; n += 1;} END {print a, r1/n, r2/n, r3/n, r4/n, r5/n, r6/n, r7/n, r8/n}'  arbitrary_topo-1/throughput.txt >> arbitrary_topo-1/throughput_a.txt

mv arbitrary_topo-1/throughput.txt arbitrary_topo-1/alpha_$a
mv arbitrary_topo-1/hit-ratio.txt arbitrary_topo-1/alpha_$a
mv arbitrary_topo-1/h_rtt_rto_late_prema_result_3.txt arbitrary_topo-1/alpha_$a
mv arbitrary_topo-1/h_rtt_rto_late_prema_result_4.txt arbitrary_topo-1/alpha_$a
mv arbitrary_topo-1/h_rtt_rto_late_prema_result_5.txt arbitrary_topo-1/alpha_$a
mv arbitrary_topo-1/h_rto_rtt_3_avg.txt arbitrary_topo-1/alpha_$a
mv arbitrary_topo-1/h_rto_rtt_4_avg.txt arbitrary_topo-1/alpha_$a
mv arbitrary_topo-1/h_rto_rtt_5_avg.txt arbitrary_topo-1/alpha_$a

#a simulation for an alpha parameter compeleted
done

#simulation completed

mkdir arbitrary_topo-1/FinalResult2
chmod 777 arbitrary_topo-1/FinalResult2

mv arbitrary_topo-1/hit-ratio-a.txt arbitrary_topo-1/FinalResult2
mv arbitrary_topo-1/h_rtt_rto_late_prema_result_3_a.txt arbitrary_topo-1/FinalResult2
mv arbitrary_topo-1/h_rtt_rto_late_prema_result_4_a.txt arbitrary_topo-1/FinalResult2
mv arbitrary_topo-1/h_rtt_rto_late_prema_result_5_a.txt arbitrary_topo-1/FinalResult2
mv arbitrary_topo-1/h_rto_rtt_3_a.txt arbitrary_topo-1/FinalResult2
mv arbitrary_topo-1/h_rto_rtt_4_a.txt arbitrary_topo-1/FinalResult2
mv arbitrary_topo-1/h_rto_rtt_5_a.txt arbitrary_topo-1/FinalResult2
mv arbitrary_topo-1/throughput_a.txt arbitrary_topo-1/FinalResult2

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

mv Alpa-to-HitRatio.eps arbitrary_topo-1/FinalResult
mv Alpha-to-P(h< H, h > H).eps arbitrary_topo-1/FinalResult
mv Alpha-to-P(RTT < RTO, RTT > RTO).eps arbitrary_topo-1/FinalResult
mv Alpha-to-HopCount.eps arbitrary_topo-1/FinalResult
mv Alpha-to-P(late-premature(AvgRTT)).eps arbitrary_topo-1/FinalResult
mv Alpha-to-P(late-premature(f)).eps arbitrary_topo-1/FinalResult
mv Alpha-to-P_late-premature(H).eps arbitrary_topo-1/FinalResult
mv Alpha-to-P_late-premature(m).eps arbitrary_topo-1/FinalResult
mv Alpha-to-P_late-premature(RTO-RTT).eps arbitrary_topo-1/FinalResult
mv Alpha-to-rtt-rto.eps arbitrary_topo-1/FinalResult
mv a-to-w.eps arbitrary_topo-1/FinalResult



