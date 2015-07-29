library date;

import "dart:core";

class Date extends Object {
  
  static var millisecondspersecond = 1000;
  static var secondsperminute = 60;
  static var minutesperhour = 60;
  static var hoursperday = 24;
  static var monthsperyear = 12;
  static var dayspermonth = 30.4368499;
  
  static var daysperyear = dayspermonth * monthsperyear;
  
  var millisecond;
  var second;
  var minute;
  var hour;
  var day;
  var month;
  var year;
  
  Date ({var year, var month, var day, var hour, var minute, var second, var millisecond}) {
    this.year = year;
    this.month = month;
    this.day = day;
    this.hour = hour;
    this.minute = minute;
    this.second = second;
    this.millisecond = millisecond;
  }
  
  static Date now () {
    DateTime now = new DateTime.now();
    return new Date(year: now.year,
        month: now.month,
        day: now.day,
        hour: now.hour,
        minute: now.minute,
        second: now.second,
        millisecond: now.millisecond);
  }
  
  static Date fromYearZero (var millisecondssinceyearzero) {
    
  }
  
  dynamic millisecondsSinceYearZero() {
    var msiy = (this.year * daysperyear * 24 * 60 * 60 * 1000);
    var msim = (this.month * dayspermonth * 24 * 60 * 60 * 1000);
    var msid = (this.day * 24 * 60 * 60 * 1000);
    var msih = (this.hour * 60 * 60 * 1000);
    var msimin = (this.minute * 60 * 1000);
    var msis = (this.second * 1000);
    
    return msiy + msim + msid + msih + msimin + msis + this.second;
  }
  
}