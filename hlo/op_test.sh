#!/bin/bash
#########################################################
# FileName   :op_test.sh
# Author     :Quanbo Liu
# Email      :quanbo.liu@enflame-tech.com
# Time       :2020-07-24 14:29:11
# Version    :V1.0
# Description:
#########################################################
src_dir=$1
result_dir=$2
execute_dir=$3
input_dir=${result_dir}/input
output_dir=${result_dir}/output
cache_attempt_file=${execute_dir}/bazel-testlog/tensorflow/compiler/plugin/dtu_backend/tests/transform/operator_validate_test/test_attempts/attempt_1.log
cache_log_file=${execute_dir}/bazel-testlog/tensorflow/compiler/plugin/dtu_backend/tests/transform/operator_validate_test/test.log

make_dir() {
    local LOCAL_DIR=$1
    if [ -d ${LOCAL_DIR} ]; then
        rm -rf ${LOCAL_DIR}
    fi
    mkdir -p ${LOCAL_DIR}
}

make_dir ${result_dir}
make_dir ${input_dir}
make_dir ${output_dir}

source ./set.sh

cd ${src_dir}
#ls ${src_dir}|grep "SetOpMetaData.after_statistics.before_pipeline-end"|xargs cp -t ${input_dir}
for file in `ls ${src_dir}`
do
    reg="SetOpMetaData.after_statistics.before_pipeline-end"
    if [[ ${file} =~ ${reg} ]]
    then
        echo ${file}
        cp ${file} ${input_dir}
    fi
done

cd ${execute_dir}
for file in `ls ${input_dir}`
do
    echo "Begin file:${file}"
    #bazelisk test operator_validate_test \
    #    --experimental_strict_action_env \
    #    --cache_test_results=no --test_timeout=30000 \
    #    --test_env="DISABLE_PIPELINE_EXECUTION=true" \
    #    --test_env CLUSTER_AS_DEVICE=false \
    #    --test_env OP_VALIDATE_FILE="${input_dir}/${file}" \
    #    --test_env OP_VALIDATE_DUMP="${output_dir}" \
    #    --test_env OP_VALIDATE_SKIP="sort.862"
    bazelisk test tensorflow/compiler/plugin/dtu_backend/tests/transform/operator_validate_test \
        --test_env CLUSTER_AS_DEVICE=false \
        --test_env OP_VALIDATE_FILE="${input_dir}/${file}" \
        --test_env OP_VALIDATE_DUMP="${output_dir}" 

    cp ${cache_attempt_file} ${output_dir}/attempt_1_${file}
    cp ${cache_log_file} ${output_dir}/log_${file}
    echo "End file:${file}"
done

cd ${output_dir}
grep -rn "mismatch for" .
