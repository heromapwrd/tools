#!/bin/bash
#########################################################
# FileName   :run_test.sh
# Author     :Quanbo Liu
# Email      :quanbo.liu@enflame-tech.com
# Time       :2020-07-24 14:54:02
# Version    :V1.0
# Description:
#########################################################
#nohup ./op_test.sh \
#    /home/quanboliu/workspace/software/hlo_dump/input/1v1 \
#    /home/quanboliu/workspace/software/hlo_dump/output/1v1 \
#    /home/quanboliu/workspace/software/tops/frameworks/tensorflow115 > 1v1.log 2>&1 &
nohup ./op_test.sh \
    /home/quanboliu/workspace/software/hlo_dump/input/5v5 \
    /home/quanboliu/workspace/software/hlo_dump/output/5v5 \
    /home/quanboliu/workspace/software/tops/frameworks/tensorflow115 > 5v5.log 2>&1 &
