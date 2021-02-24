#!/bin/bash
#########################################################
# FileName   :set.sh
# Author     :Quanbo Liu
# Email      :quanbo.liu@enflame-tech.com
# Time       :2020-06-05 11:36:06
# Version    :V1.0
# Description:
#########################################################
#export XLA_FLAGS="--xla_dump_hlo_as_text --xla_dump_to=hlo_dump/`date "+%m%d%H%M"`/ --xla_dump_hlo_pass_re='.*'"
#export TF_DUMP_GRAPH_PREFIX="./graph_dump/"
export DTU_UMD_FLAGS='ib_pool_size=134217728'
export EN_BOUND_ALLOC=true
export TF_XLA_FLAGS="--tf_xla_auto_jit=-1 --tf_xla_min_cluster_size=4"
export ENABLE_INIT_ON_CPU=1
export CLUSTER_AS_DEVICE=false
#export ENABLE_SDK_STREAM_CACHE=false
export HBM_RESERVE_FOR_INF_LIFETIME=8388608
#export OP_SELECT="BatchDot=BatchDotOpImplGeneral"

#export LMODULE=CDS
#export REDUCE_HBM_USE_PEAK=true
#export LMODULE=ECP,MM
#export LMLEVEL=0,3
#export DISABLE_PIPELINE_EXECUTION=true
#export XLA_FLAGS="--dtu_enable=memory_pressure_analysis" 

#export SDK_LOG_LEVEL=-1
#export SDK_VLOG_LEVEL=1
#export TF_CPP_MIN_LOG_LEVEL=-1
#export TF_CPP_MIN_VLOG_LEVEL=1

#export XLA_FLAGS="--xla_backend_extra_options='xla_dtu_check_nan=true,xla_op_cfg_dir=./op_cfg/'"
#export XLA_FLAGS="--xla_backend_extra_options='xla_dtu_check_nan=true'"
#export XLA_FLAGS="--xla_backend_extra_options='xla_dtu_mixed_precision=true'"
#export XLA_FLAGS="--xla_backend_extra_options='xla_op_cfg_dir=./op_cfg/'"
#export BYPASS_ODMA_WORKAROUND=true
#export DTU_UMD_FLAGS='ib_wb_in_host=true odma_force=2 max_pending=40960'
#export DTU_OPT_MODE=true
