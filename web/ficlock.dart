// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:core';
import 'dart:html';

import 'ficalendars.dart';
import 'clock.dart';

const oneMillisec = const Duration(milliseconds:1);   // Standard
const tenMillisec = const Duration(milliseconds:10);  // Just in-case someone complains about 'flickering' or problems caused by above constant
const oneSec = const Duration(seconds:1);             // For browsers and computers with slow JS-processing speed

final daterelationfactor = calculatefactor();
const spfactor = 7.024038461538462;
const factor = 1.394540942928;
const initaloffsetyear = 1;


var ticker;
var lastDate;

var calendars;

Calendar cyra;

num calculatefactor() {
  var v1 = new Duration(days: (2015 - initaloffsetyear)*365.25);
  var v2 = new Duration(days: (2806 - initaloffsetyear)*365.25 + 31);
  
  return v2.inMilliseconds/v1.inMilliseconds;
}

void main() {
  
  print(calculatefactor());
  
  init();
  
}

void init() {
  
  cyra = new Cyrannian();
  
  ticker = new Timer.periodic(oneMillisec, (Timer t) => update(t));
  
}

// To be removed 
/* dynamic millisecondsSinceEpoch() {
  var msiy = (new DateTime(1970).year * 365.242199 * 24 * 60 * 60 * 1000);
  var msim = (new DateTime(1970).month * (365.242199/12) * 24 * 60 * 60 * 1000);
  var msid = (new DateTime(1970).day * 24 * 60 * 60 * 1000);
  var msih = (new DateTime(1970).hour * 60 * 60 * 1000);
  var msimin = (new DateTime(1970).minute * 60 * 1000);
  var msis = (new DateTime(1970).second * 1000);
  
  return msiy + msim + msid + msih + msimin + msis + new DateTime(1970).millisecond;
}

dynamic millisecondsSinceThisYear() {
  var msiy = (new DateTime(2015).year * 365.242199 * 24 * 60 * 60 * 1000);
  //var msim = (new DateTime(2015).month * (365.242199/12) * 24 * 60 * 60 * 1000);
  //var msid = (new DateTime(2015).day * 24 * 60 * 60 * 1000);
  //var msih = (new DateTime(2015).hour * 60 * 60 * 1000);
  //var msimin = (new DateTime(2015).minute * 60 * 1000);
  //var msis = (new DateTime(2015).second * 1000);
  
  return msiy; //new DateTime(2015).millisecond;
} */

void update(Timer timer) {
  DateTime now = new DateTime.now();
  Date d = new Date.now();
  DateTime ficd = new DateTime.fromMillisecondsSinceEpoch(d.millisecondsSinceYearOne() * calculatefactor());
  ficd = ficd.subtract(new Duration(days:(1970*365.25)));
  
  cyra.update(ficd);
  
  querySelector("#cyrannian").querySelector(".time").text = "${cyra.toString()}";
  querySelector("#fictionverse").querySelector(".time").text = "${ficd.year}-${ficd.month}-${ficd.day}";
  
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