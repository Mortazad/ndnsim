. ~/Desktop/ndnSIM/ns-3


echo mortazad | sudo -S echo -n 2>/dev/random 1>/dev/random

#make test directory and permit to change it
mkdir arbitrary_topo
sudo chmod 777 arbitrary_topo

#run the simulation
sudo ./waf --run=ndn-rtt > arbitrary_topo/output.txt

#create separate trace for each content and calculate Mean HopCount, RTO, RTT and total number of sent packets for them
#5 hops
for sq in 1 2
do
awk -v awk_s=$sq ' ($4 == awk_s && ($3 == "/Prod11" || $3 == "/Prod21")) {print $1, $2, $3, $4, $5, $6, $7, $8, $9 }' arbitrary_topo/output.txt > arbitrary_topo/out_5_$sq.txt
awk -f awk_h_rto_rtt.txt arbitrary_topo/out_5_$sq.txt >> h_rto_rtt_5.txt
done
awk '{s += $8}; END {print s}' h_rto_rtt_5.txt >> p_loss.txt

#4hops
for sq in 1 2
do
awk -v awk_s=$sq ' ($4 == awk_s && ($3 == "/BTP32" || $3 == "/BTP42")) {print $1, $2, $3, $4, $5, $6, $7, $8, $9 }' arbitrary_topo/output.txt > arbitrary_topo/out_4_$sq.txt
awk -f awk_h_rto_rtt.txt arbitrary_topo/out_4_$sq.txt >> h_rto_rtt_4.txt
done
awk '{s += $8}; END {print s}' h_rto_rtt_4.txt >> p_loss.txt

#3hops
for sq in 1 2
do
awk -v awk_s=$sq ' ($4 == awk_s && ($3 == "/BTP1" || $3 == "/BTP2")) {print $1, $2, $3, $4, $5, $6, $7, $8, $9 }' arbitrary_topo/output.txt > arbitrary_topo/out_3_$sq.txt
awk -f awk_h_rto_rtt.txt arbitrary_topo/out_3_$sq.txt >> h_rto_rtt_3.txt
done
awk '{s += $8}; END {print s}' h_rto_rtt_3.txt >> p_loss.txt

#calculate total number of sent packets and total number of lost packets
gawk '{total += $1 }; END {print "total_number_of_sent_packets:", total}' p_loss.txt >> p_loss.txt
gawk '{loss += $7}; END {print "total_number_of_lost_packets:", loss}' drop-trace.txt >> p_loss.txt
gawk '($1 == "total_number_of_sent_packets:") { sp = $2} ( $1 == "total_number_of_lost_packets:" ) { lp = $2}; END {print lp/sp }' p_loss.txt >> p_loss.txt

#calculate probabilty of RTO<RTT and RTO>RTT and h(c)<H and hc>H for five hop connection
gawk '{ t_h += $2; t_rtt += $3; t_w += $6; c += 1;} END {print ave_H, ave_rtt, ave_w, t_h/c, t_rtt/c, t_w/c}' h_rto_rtt_5.txt >> h_rto_rtt_5.txt

#calculate probabilty of RTO<RTT and RTO>RTT and h(c)<H and hc>H for four hop connection
gawk '{ t_h += $2; t_rtt += $3; t_w += $6; c += 1;} END {print ave_H, ave_rtt, ave_w, t_h/c, t_rtt/c, t_w/c}' h_rto_rtt_4.txt >> h_rto_rtt_4.txt

#calculate probabilty of RTO<RTT and RTO>RTT and h(c)<H and hc>H for three hop connection
gawk '{ t_h += $2; t_rtt += $3; t_w += $6; c += 1;} END {print ave_H, ave_rtt, ave_w, t_h/c, t_rtt/c, t_w/c}' h_rto_rtt_3.txt >> h_rto_rtt_3.txt

#calculate average hit ratio in each router
awk -f awk_hit-ratio.txt cs-trace.txt >> hit-ratio.txt

#calculate throughput
awk -f awk_throughput.txt arbitrary_topo/output.txt >> throughput.txt

#calculate load of links



mv cs-trace.txt arbitrary_topo
mv drop-trace.txt arbitrary_topo
mv rate-trace.txt arbitrary_topo
mv app-delays-trace.txt arbitrary_topo