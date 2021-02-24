#!/bin/bash
#########################################################
# FileName   :run.sh
# Author     :Quanbo Liu
# Email      :quanbo.liu@enflame-tech.com
# Time       :2021-01-26 12:56:50
# Version    :V1.0
# Description:
#########################################################
bash statistics.sh --fs "[ :]" --cindex -1 --seg 10 --max_dash 100 --ignore_frame 1 --min_fps 1000000 \
  --pattern "enflame_tops_models.*step_fps" --filename $1
