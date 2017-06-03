#!/bin/bash
cd /Users/zhuhuifeng/work/asr/kaldi/egs/timit/s5
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  echo -n '# '; cat <<EOF
compute-mfcc-feats --verbose=2 --config=conf/mfcc.conf scp,p:exp/make_mfcc/test/wav_test.${SGE_TASK_ID}.scp ark:- | copy-feats --compress=true ark:- ark,scp:/Users/zhuhuifeng/work/asr/kaldi/egs/timit/s5/mfcc/raw_mfcc_test.${SGE_TASK_ID}.ark,/Users/zhuhuifeng/work/asr/kaldi/egs/timit/s5/mfcc/raw_mfcc_test.${SGE_TASK_ID}.scp 
EOF
) >exp/make_mfcc/test/make_mfcc_test.$SGE_TASK_ID.log
time1=`date +"%s"`
 ( compute-mfcc-feats --verbose=2 --config=conf/mfcc.conf scp,p:exp/make_mfcc/test/wav_test.${SGE_TASK_ID}.scp ark:- | copy-feats --compress=true ark:- ark,scp:/Users/zhuhuifeng/work/asr/kaldi/egs/timit/s5/mfcc/raw_mfcc_test.${SGE_TASK_ID}.ark,/Users/zhuhuifeng/work/asr/kaldi/egs/timit/s5/mfcc/raw_mfcc_test.${SGE_TASK_ID}.scp  ) 2>>exp/make_mfcc/test/make_mfcc_test.$SGE_TASK_ID.log >>exp/make_mfcc/test/make_mfcc_test.$SGE_TASK_ID.log
ret=$?
time2=`date +"%s"`
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>exp/make_mfcc/test/make_mfcc_test.$SGE_TASK_ID.log
echo '#' Finished at `date` with status $ret >>exp/make_mfcc/test/make_mfcc_test.$SGE_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch exp/make_mfcc/test/q/sync/done.29957.$SGE_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# qsub -v PATH -cwd -S /bin/bash -j y -l arch=*64* -o exp/make_mfcc/test/q/make_mfcc_test.log -l mem_free=4G,ram_free=4G   -t 1:10 /Users/zhuhuifeng/work/asr/kaldi/egs/timit/s5/exp/make_mfcc/test/q/make_mfcc_test.sh >>exp/make_mfcc/test/q/make_mfcc_test.log 2>&1
