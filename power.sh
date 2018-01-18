. /home/mortaza/Desktop/error-eval/evalvid

  ns newtest.tcl
  
  test -e $RESDIR || mkdir $RESDIR
  test -e $RESDIR/$1 || mkdir $RESDIR/$1
  test -e $RESDIR/$1/yuv || mkdir $RESDIR/$1/yuv

  etmp4 -p -0 "sd_s("6")" "rd_s("10")" "send_trace("6")" $MP4DIR/foreman_qcif_264.mp4 err_foreman_qcif_610
  etmp4 -p -0 "sd_s("11")" "rd_s("14")" "send_trace("11")" $MP4DIR/foreman_qcif_264.mp4 err_foreman_qcif_1114
  etmp4 -p -0 "sd_s("15")" "rd_s("17")" "send_trace("15")" $MP4DIR/foreman_qcif_264.mp4 err_foreman_qcif_1517

  shred --remove *.264
  
  ffmpeg -i err_foreman_qcif_610.mp4 foreman_keyf_infoQ1.yuv
  awk -f psnr_edit.txt  awk_psnr.txt > foreman_err_psnr_610.txt
  psnr 176 144 420 $YUVDIR/foreman_qcif.yuv foreman_keyf_infoQ1.yuv >> foreman_err_psnr_610.txt
  
  paste $MP4DIR/foreman_orig_PSNRresult.txt foreman_err_psnr_610.txt > tmp
  cut -f 1,3 tmp > foreman_keyf_infoQ1.txt
  discoverdec --PSNRFile="foreman_psnr_610.txt" foreman_decoder.cfg
  shred --remove foreman_keyf_infoQ1.yuv
  shred --remove foreman_keyf_infoQ1.txt
  shred --remove foreman_err_psnr_610.txt
  
  ffmpeg -i err_foreman_qcif_1114.mp4 foreman_keyf_infoQ1.yuv
  awk -f psnr_edit.txt  awk_psnr.txt > foreman_err_psnr_1114.txt
  psnr 176 144 420 $YUVDIR/foreman_qcif.yuv foreman_keyf_infoQ1.yuv >> foreman_err_psnr_1114.txt
  
  paste $MP4DIR/foreman_orig_PSNRresult.txt foreman_err_psnr_1114.txt > tmp
  cut -f 1,3 tmp > foreman_keyf_infoQ1.txt
  discoverdec --PSNRFile="foreman_psnr_1114.txt" foreman_decoder.cfg
  shred --remove foreman_keyf_infoQ1.txt
  shred --remove foreman_keyf_infoQ1.yuv
  shred --remove foreman_err_psnr_1114.txt
   
  ffmpeg -i err_foreman_qcif_1517.mp4 foreman_keyf_infoQ1.yuv
  awk -f psnr_edit.txt  awk_psnr.txt > foreman_err_psnr_1517.txt
  psnr 176 144 420 $YUVDIR/foreman_qcif.yuv foreman_keyf_infoQ1.yuv >> foreman_err_psnr_1517.txt
  
  paste $MP4DIR/foreman_orig_PSNRresult.txt foreman_err_psnr_1517.txt > tmp
  cut -f 1,3 tmp > foreman_keyf_infoQ1.txt
  discoverdec --PSNRFile="foreman_psnr_1517.txt" foreman_decoder.cfg
  shred --remove foreman_keyf_infoQ1.yuv
  shred --remove foreman_keyf_infoQ1.txt
  shred --remove foreman_err_psnr_1517.txt
 
  shred --remove tmp*
  shred --remove *.mp4
  shred --remove *.yuv
 
  shred --remove send_trace"("0")" send_trace"("6")" send_trace"("11")" send_trace"("15")" send_trace"("18")"
  ./maketrace.exe
  for i in 1 2 3 4 5 ; do
  ns newtest.tcl
  awk -f awk_power.txt power.tr >> power_consum_$1.txt
   done
    gawk '{ sum += $2 }; END { print sum/15 }' power_consum_$1.txt >> power_consum_$1.txt
  mv foreman_psnr_1517.txt foreman_psnr_1114.txt foreman_psnr_610.txt $RESDIR/$1/yuv
  mv power_consum_$1.txt $RESDIR/$1
  shred --remove send_trace"("0")" send_trace"("6")" send_trace"("11")" send_trace"("15")" send_trace"("18")" newtest.tcl
  cp traces/send_trace"("0")" /home/mortaza/Desktop/error-eval
  cp traces/send_trace"("6")" /home/mortaza/Desktop/error-eval
  cp traces/send_trace"("11")" /home/mortaza/Desktop/error-eval
  cp traces/send_trace"("15")" /home/mortaza/Desktop/error-eval
  cp traces/send_trace"("18")" /home/mortaza/Desktop/error-eval

