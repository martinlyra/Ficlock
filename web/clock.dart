library date;

import "dart:core";

// Attention!
// 
// This is a slightly redudant implementation of an attempt on making a more functional version of DateTime
// with capacity to compute dates starting from year 0 (B.C/A.C). But due to failures, this has ironically become dependent on
// the native class DateTime.
//
// PS: Watch out for the dragons, they be sneakin' around.

enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  Setpember,
  October,
  November,
  December
}

enum Day {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

class Date extends Object {
  
  static var millisecondspersecond = 1000;
  static var secondsperminute = 60;
  static var minutesperhour = 60;
  static var hoursperday = 24;
  static var monthsperyear = 12;
  static var dayspermonth = 30.4368499;
  
  static var daysperyear = 365;
  static var daysperleapyear = 366;
  
  static var daysperaverageyear = dayspermonth * monthsperyear;
  
  num millisecond, second, minute, hour, day, month, year;
  bool leapyear;
  
  Date ({var year, var month, var day, var hour, var minute, var second, var millisecond}) {
    this.year = year;
    this.month = month;
    this.day = day;
    this.hour = hour;
    this.minute = minute;
    this.second = second;
    this.millisecond = millisecond;
    if (isLeapYear(this.year))
      leapyear = true;
  }
  
  Date.now () {
    DateTime now = new DateTime.now();
    this.year = now.year;
    this.month = now.month;
    this.day = now.day;
    this.hour = now.hour;
    this.minute = now.minute;
    this.second = now.second;
    this.millisecond = now.millisecond;
    if (isLeapYear(this.year))
      leapyear = true;
  }
  
  Date.fromDateTime(DateTime time) : this(
      year: time.year,
      month: time.month,
      day: time.day,
      hour: time.hour,
      minute: time.minute,
      second: time.second,
      millisecond: time.millisecond);
  
  static Date fromYearZero (num millisecondssinceyearzero) {    
    return new Date.now().add(new Duration(milliseconds: millisecondssinceyearzero));
  }
  
  int millisecondsSinceYearZero() {
    var msiy = (this.year * daysperyear * hoursperday * minutesperhour * secondsperminute * millisecondspersecond);
    var msim = (this.month * dayspermonth * hoursperday * minutesperhour * secondsperminute * millisecondspersecond);
    var msid = (this.day * hoursperday * minutesperhour * secondsperminute * millisecondspersecond);
    var msih = (this.hour * minutesperhour * secondsperminute * millisecondspersecond);
    var msimin = (this.minute * secondsperminute * millisecondspersecond);
    var msis = (this.second * millisecondspersecond);
    
    return msiy + msim + msid + msih + msimin + msis + this.second;
  }
  
  Date add(Duration duration) {
    var newdate = new Date.now();
    var morems = duration.inMilliseconds;
    
    newdate.millisecond = morems;
    newdate._calculateDate(duration);
    
    return newdate;
  }
  
  Month getMonth() {
    for (Month themonth in Month.values) {
      if (themonth.index == this.month - 1)
        return themonth;
    }
    return null;
  }
  
  String toString() {
    return "${this.year}-${this.month}-${this.day}";
  }
  
  static bool isLeapYear(int year) {
    if (_hasDecimal(year/4))
      return false;
    else if (_hasDecimal(year/100))
      return true;
    else if (_hasDecimal(year/400))
      return false;
    else return true;
  }
  
  static Month getMonthFromIndex(int number) {
    for (Month themonth in Month.values) {
      if (themonth.index == number - 1)
        return themonth;
    }
    return null;
  }
  
  static int getDaysInMonth(Month month, {int year}) {
    switch (month) {
      case Month.January:
        return 31;
      case Month.February:
        if (isLeapYear(year))
          return 29;
        return 28;
      case Month.March:
        return 31;
      case Month.April:
        return 30;
      case Month.May:
        return 31;
      case Month.June:
        return 30;
      case Month.July:
        return 31;
      case Month.August:
        return 31;
      case Month.Setpember:
        return 30;
      case Month.October:
        return 31;
      case Month.November:
        return 30;
      case Month.December:
        return 31;
    }
  }
  
  void _calculateDate(Duration dura) {
    
  }
  
  /*void _calculateDate() {
    if (this.millisecond >= millisecondspersecond) {
      do {
        this.second += 1;
        this.millisecond -= millisecondspersecond;
        if (this.second >= secondsperminute) {
          do {
            this.minute += 1;
            this.second -= secondsperminute;
          } while (this.second >= secondsperminute);
        }
      } while (this.millisecond >= millisecondspersecond);
    }
    print("MS complete");
    print("SC complete");
    if (this.minute >= minutesperhour) {
      do {
        this.hour += 1;
        this.minute -= minutesperhour;
      } while (this.minute >= minutesperhour);
    }
    print("MIN complete");
    if (this.hour >= hoursperday) {
      do {
        this.day += 1;
        this.hour -= hoursperday;
      } while (this.hour >= hoursperday);
    }
    print("HR complete");
    var daysinmonth = getDaysInMonth(getMonth(), year: this.year);
    if (this.day >= daysinmonth) {
      do {
        this.month += 1;
        this.day -= daysinmonth;
        if (this.month >= monthsperyear) {
          this.year += 1;
          this.month -= monthsperyear;
        }
        daysinmonth = getDaysInMonth(getMonth(), year: this.year);
      } while (this.day >= daysinmonth);
    }
    print("Calc complete");
  }*/
  
  static bool _hasDecimal(var number) {
    return ((number is int) && ((number % 1) == 0)) ? false : true;
  }
}