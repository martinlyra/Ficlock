// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:core';
import 'dart:html';

const oneMiliSec = const Duration(milliseconds:1);
const oneSec = const Duration(seconds:1);

var ticker;
var lastDate;

void main() {
  
  init();
  
}

void init() {
  
  ticker = new Timer.periodic(oneSec, (Timer t) => update(t));
  
}

void update(Timer timer) {
  DateTime now = new DateTime.now();
  
  updateRealTime(now);
  if (!isToday(now))
    updateRealDate(now);
}

bool isToday(DateTime now) {
  return (
      (lastDate == null)
      || (lastDate is! DateTime) 
      || (lastDate.year != now.year) 
      || (lastDate.month != now.month)
      || (lastDate.day != now.day)) ? false : true;
}

void updateRealTime (DateTime time) {
  
  var hour;
  var minute;
  var second;
  
  if (time.hour < 10)
    hour = "0" + time.hour.toString();
  else
    hour = time.hour.toString();
  if (time.minute < 10)
    minute = "0" + time.minute.toString();
  else
    minute= time.minute.toString();
  if (time.second < 10)
    second = "0" + time.second.toString();
  else
    second = time.second.toString();
  
  querySelector('#real-time').text = '${hour}:${minute}:${second}';
}

void updateRealDate (DateTime time) {
  var day;
  var month;
  var year;
  
  if (time.day < 10)
    day = "0" + time.day.toString();
  else
    day = time.day;
  if (time.month < 10)
    month = "0" + time.month.toString();
  else
    month = time.month;
  year = time.year;
  
  lastDate = time;
  querySelector('#real-date').text = '${year}-${month}-${day}';
}