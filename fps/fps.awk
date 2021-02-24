#!/usr/bin/awk -f
function get_item(array, cpos){
  size = length(array);
  if(cpos >= 0){
    pos = cpos;
  }else{
    pos = size + cpos + 1;
  }
  return array[pos];
}

function average(array) {
  size = length(array);
  sum = 0;
  for(i in array){
    sum += array[i];
  }
  ave = sum / size;
  return ave;
}

function std_dev(array, ave){
  size = length(array);
  sum = 0;
  for(i in array){
    sum += (array[i] - ave)*(array[i] - ave);
  }
  std = sqrt(sum / size);
  return std;
}

function range(minv, maxv){
  v = maxv - minv;
  return v;
}

function gen_column(num){
  result = "";
  for(i = 0; i < num; i++){
    result = result"=";
  }
  return result;
}

function histogram(columns, array, start, delta, seg){
  size = length(array);
  for(i = 1; i <= seg; i++){
    end = start + delta;
    num = 0;
    for(j in array){
      if(array[j] >= start && array[j] < end){
        num += 1;
      }
    }
    columns[i] = (num / size) * 100;
    start = end;
  }
}

function truncate(columns, bound) {
  size = length(columns);
  max_column = 0;
  for(j in columns) {
    if(columns[j] > max_column){
      max_column = columns[j];
    }
  }
  if(max_column > bound) {
    ratio = bound / max_column;
    for(i = 1; i <= size; i++) {
      columns[i] = columns[i] * ratio;
    }
  }
}

function display(start, delta, columns, percent){
  size = length(columns);
  for(k = 1; k <= size; k++){
    per = percent[k];
    column = gen_column(columns[k]);
    printf("%6.2f  %10.6f  - %10.6f: %s\n", per, start, start + delta, column);
    start += delta;
  }
}

BEGIN {
  content[1] = 0;
  linenum = 0 - ignore_frame;
  max_fps = -1;
  if(seg <= 0) {
    seg = 10;
  }
  if(max_dash <= 0) {
    max_dash = 100;
  }
}

$(0) ~ pattern {
  linenum += 1;
  for(i = 1; i <= NF; i++){
    array[i] = $(i);
  }

  item = get_item(array, cindex);
  if(linenum > 0){
    content[linenum] = item;
    if(min_fps > item){
      min_fps = item;
    }
    if(max_fps < item){
      max_fps = item;
    }
  }
}

END {
  len    = asort(content, content);
  median = content[(len + (len % 2)) / 2];
  ave    = average(content);
  std    = std_dev(content, ave);

  start  = min_fps;
  end    = max_fps + 0.1;
  rng    = range(start, end);
  delta  = rng / seg; 

  histogram(columns, content, start, delta, seg);
  for(i in columns) {
    percent[i] = columns[i];
  }
  truncate(columns, max_dash);
  print "";
  print "steps : " len;
  print "min   : " min_fps;
  print "max   : " max_fps;
  print "delta : " max_fps - min_fps;
  print "median: " median;
  print "ave   : " ave;
  print "std   : " std;
  print ""
  print "Percent           Range           Histogram"
  display(start, delta, columns, percent);
  print "";
}
