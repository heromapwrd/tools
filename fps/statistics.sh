#!/bin/bash
#########################################################
# FileName   :statistics.sh
# Author     :Quanbo Liu
# Email      :quanbo.liu@enflame-tech.com
# Time       :2020-12-22 10:43:56
# Version    :V1.0
# Description:
#########################################################
# Table of foregrand colors used in console.
NO_COLOR='\e[39m'
BLACK='\e[30m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
LIGHT_GRAY='\e[37m'
DARK_GRAY='\e[90m'
LIGHT_RED='\e[91m'
LIGHT_GREEN='\e[92m'
LIGHT_YELLOW='\e[93m'
LIGHT_BLUE='\e[94m'
LIGHT_MAGENTA='\e[95m'
LIGHT_CYAN='\e[96m'
WHITE='\e[97m'

function upper() {
  local str="$@"

  local output=$(tr '[a-z]' '[A-Z]'<<<"${str}")
  echo $output
}

function lower() {
  local str=$@

  local output=$(tr '[A-Z]' '[a-z]'<<<"${str}")
  echo $output
}

# Function print log with color.
#
# @param 1  User input color.
# @param 2  The message to log.
function echoc() {
  local color="$1"
  local msg="$2"

  color_upper="$(upper "${color}")"
  eval color_code='$'${color_upper}

  echo -e ${color_code}${msg}${NO_COLOR}
}

function usage() {
  echoc magenta "Script to statistic fps from log file"
  echoc magenta " "
  echoc magenta "Options:"
  echoc magenta "  --help             show brief help"
  echoc magenta "  --fs               delimiter to split line"
  echoc YELLOW  "    Default:[ :]"
  echoc magenta "  --cindex           colum index in line that fps exists, negative number means counting from back to front"
  echoc YELLOW  "    Default:-1"
  echoc magenta "  --seg              colum in histogram"
  echoc YELLOW  "    Default:10"
  echoc magenta "  --max_dash         max height of histogram"
  echoc YELLOW  "    Default:100"
  echoc magenta "  --ignore_frame     the front frame nums to be ignored"
  echoc YELLOW  "    Default:1"
  echoc magenta "  --min_fps          minimus fps value to get the maximum value of fps"
  echoc YELLOW  "    Default:1000000"
  echoc magenta "  --pattern          regular expression that matches inupt line"
  echoc YELLOW  "    Default:".*""
  echoc magenta "  --filename         log filename, must not be empty"
exit 3
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help)
        usage
        ;;
    --fs)
        shift
        fs="$1"
        ;;
    --cindex)
        shift
        cindex="$1"
        ;;
    --seg)
        shift
        seg="$1"
        ;;
    --max_dash)
        shift
        max_dash="$1"
        ;;
    --ignore_frame)
        shift
        ignore_frame="$1"
        ;;
    --min_fps)
        shift
        min_fps="$1"
        ;;
    --pattern)
        shift
        pattern="$1"
        ;;
    --filename)
        shift
        filename="$1"
        ;;
  esac
  # Shift after checking all the cases to get the next option
  shift
done

if [ -z "${fs}" ]; then
  fs="[ :]"
else
  fs="${fs}"
fi
if [ -z ${cindex} ]; then
  cindex=-1
else
  cindex=${cindex}
fi
if [ -z ${seg} ]; then
  seg=10
else
  seg=${seg}
fi
if [ -z ${max_dash} ] ; then
  max_dash=100
else
  max_dash=${max_dash}
fi
if [ -z ${ignore_frame} ] ; then
  ignore_frame=1
else
  ignore_frame=${ignore_frame}
fi
if [ -z ${min_fps} ] ; then
  min_fps=1000000
else
  min_fps=${min_fps}
fi
if [ -z ${pattern} ] ; then
  pattern=".*"
else
  pattern="${pattern}"
fi
if [ -z ${filename} ] ; then
  echo "Error:filename is empty!"
  exit 1
else
  filename=${filename}
fi

awk -F "${fs}" -v cindex=${cindex} -v seg=${seg} -v max_dash=${max_dash} -v min_fps=${min_fps} -v ignore_frame=${ignore_frame} -v pattern="${pattern}" -f fps.awk ${filename}
