library Ficalendar;

import "dart:math";

import "clock.dart";

abstract class Calendar {
  
  var year;
  
  Calendar() {

  }
  
  void update(DateTime time) {
    
  }
  
  String toString() {
    
  }
}

/*
 * Redudant
class Ficverse implements Calendar {
  
}
 */

class Bunsen implements Calendar {
  
  // --- 1st SY
  // Janeau   - 31
  // Februn   - 28
  // Marzo    - 31
  // --- 2nd SY
  // Aprellus - 30
  // Mahya    - 31
  // Junien   - 30
  // --- 3rd SY
  // Juliara  - 31
  // Aegosto  - 31
  // Setperma - 30
  // --- 4th SY
  // Octrobes - 31
  // Nuevena  - 30
  // Dicemzo  - 31
  
  // Tot      - 365 (plus a leap day every 4 earth year)
  
  var year;
  var tyear;
  var day;
  var month;
  String monthname;
  String yearsurfix;
  
  var _factor;
  
  Bunsen() {
    
  }
  
  void update(DateTime time) {
    _calculateFactor(time);
    var year = time.year - time.year%4;
    this.day = time.day;
    this.month = time.month;
    this.tyear = (year-2800)*4+1892 + (_factor*4).floor();
    
    switch (this.month) {
      case 1: case 2: case 3:
        this.yearsurfix = "A"; break;
      case 4: case 5: case 6:
        this.yearsurfix = "B"; this.tyear += 1; break;
      case 7: case 8: case 9:
        this.yearsurfix = "C"; this.tyear += 2; break;
      case 10: case 11: case 12:
        this.yearsurfix = "D"; this.tyear += 3; break;
      default:
        this.yearsurfix = ""; break;
    }
  }
  
  void _calculateFactor(DateTime time) {
    var a = new DateTime(time.year, 1, 1).millisecondsSinceEpoch;
    var b = time.millisecondsSinceEpoch - a;
    var c = (new DateTime(time.year + 4, 1, 1).millisecondsSinceEpoch - a)/4;
    _factor = b/c;
  }
  
  String toString() {
    return "${this.day} ${this.month}, ${this.tyear} T${this.tyear/4}-${this.yearsurfix}";
  }
}

class Cyrannian implements Calendar {
  
  var year;
  var month;
  String monthname;
  String period;
  
  Cyrannian() {
    
  }
  
  void update(DateTime time) {
    this.month = (time.month/2).ceilToDouble().floor();

    _calculateYear(time.year);
    switch (this.month) {
      case 1: 
        this.monthname = ("Ianuaria");
        break;
      case 2: 
        this.monthname = ("Martex");
        break;
      case 3: 
        this.monthname = ("Iunius");
        break;
      case 4: 
        this.monthname = ("Novemex");
        break;
      case 5: 
        this.monthname = ("Dekemurios");
        break;
      case 6: 
        this.monthname = ("Neochios");
        break;
      }
  }
  
  void _calculateYear(var rawyear) {
    if (rawyear < 2797) {
      this.year = (2797-rawyear);
      this.period = "B";
    }
    else {
      this.year = (rawyear-2797);
      this.period = "";
    }
  }
  
  String toString() {
    return "${this.monthname} ${this.year} ${this.period}NE";
  }
}

class Draconid implements Calendar {
  
  String year;
  var month;
  var day;
  
  final daysperalcantiyear = new Duration(hours:360*28).inMilliseconds;
  final daysperalcantimonth = new Duration(hours:30*28).inMilliseconds;
  final hoursperalcantiday = new Duration(hours:28).inMilliseconds;
  
  Draconid() {
    
  }
  
  void update(DateTime time) {
    var v1 = time.millisecondsSinceEpoch - 25510953600000;
   
    var v2 = (v1/daysperalcantiyear) + 219490;
    var y1 = (v2 % 1000).floor();
    var y2 = (v2 / 1000).floor();
    this.year = "${y1}.${y2}";
   
    v1 = v1 % daysperalcantiyear;
   
    if (v1 < 0) {
      v1 = daysperalcantiyear + v1;
    }
    
    this.month = (v1/daysperalcantimonth).floor() + 1;
    v1 = v1 % daysperalcantimonth;
    this.day = (v1/hoursperalcantiday).floor() + 1;
  }
  
  String toString() {
    return "ID.${this.year}.${this.month}.${this.day}";
  }
}

class Farengeto implements Calendar {
  
  // Alert! Alert!
  // SHOUTING code ahead!
  
  static final MILLISECONDS_PER_SECOND = 497;
  static final SECONDS_PER_MINUTE = 64;
  static final MINUTES_PER_HOUR = 64;
  static final HOURS_PER_DAY = 64;
  static final DAYS_PER_MONTH = 64;
  static final MONTHS_PER_YEAR = 8;
  
  static final MILLISECONDS_PER_MINUTE = MILLISECONDS_PER_SECOND * SECONDS_PER_MINUTE;
  static final MILLISECONDS_PER_HOUR = MILLISECONDS_PER_MINUTE * MINUTES_PER_HOUR;
  static final MILLISECONDS_PER_DAY = MILLISECONDS_PER_HOUR * HOURS_PER_DAY;
  static final MILLISECONDS_PER_MONTH = MILLISECONDS_PER_DAY * DAYS_PER_MONTH;
  static final MILLISECONDS_PER_YEAR = MILLISECONDS_PER_MONTH * MONTHS_PER_YEAR;
  
  static final SECONDS_PER_HOUR = SECONDS_PER_MINUTE * MINUTES_PER_HOUR;
  static final SECONDS_PER_DAY = SECONDS_PER_HOUR * HOURS_PER_DAY;
  static final SECONDS_PER_MONTH = SECONDS_PER_DAY * DAYS_PER_MONTH;
  static final SECONDS_PER_YEAR = SECONDS_PER_MONTH * MONTHS_PER_YEAR;
  
  static final MINUTES_PER_DAY = MINUTES_PER_HOUR * HOURS_PER_DAY;
  static final MINUTES_PER_MONTH = MINUTES_PER_DAY * DAYS_PER_MONTH;
  static final MINUTES_PER_YEAR = MINUTES_PER_MONTH * MONTHS_PER_YEAR;
  
  static final HOURS_PER_MONTH = HOURS_PER_DAY * DAYS_PER_MONTH;
  static final HOURS_PER_YEAR = HOURS_PER_MONTH * MONTHS_PER_YEAR;
  
  static final DAYS_PER_YEAR = DAYS_PER_MONTH * MONTHS_PER_YEAR;
  
  static final START_YEAR = 2783;
  static final START_MONTH = 5;
  static final START_DAY = 16;
  static final DateTime START_DATE = new DateTime(START_YEAR,START_MONTH,START_DAY);
  static final int EPOCH_DIFFERENCE = START_DATE.millisecondsSinceEpoch;
  
  static final BASE = 8;
  
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;
  int millisecond;
  
  Farengeto() {
    
  }
  
  void update(DateTime time) {
    var ms = (time.millisecondsSinceEpoch - EPOCH_DIFFERENCE);
    this.year = (ms/MILLISECONDS_PER_YEAR).abs().truncate();
    ms %= MILLISECONDS_PER_YEAR;
    
    this.second = (ms/MILLISECONDS_PER_SECOND%SECONDS_PER_MINUTE).abs().truncate();
    this.minute = (ms/MILLISECONDS_PER_MINUTE%MINUTES_PER_HOUR).abs().truncate();
    this.hour = (ms/MILLISECONDS_PER_HOUR%HOURS_PER_DAY).abs().truncate();
    this.day = (ms/MILLISECONDS_PER_DAY%DAYS_PER_MONTH).abs().truncate();
    this.month = (ms/MILLISECONDS_PER_MONTH%MONTHS_PER_YEAR).abs().truncate();
  }
  
  int _baseOf(var value, int base) {
    return (log(value)/log(base)).floor();
  }
  
  String toString() {
    return "${this.year.toRadixString(BASE)}.{${this.month.toRadixString(BASE)}.{${this.day.toRadixString(BASE)}";
    // return "${this.year.toRadixString(BASE)}.${this.month.toRadixString(BASE)}.${this.day.toRadixString(BASE)}.${this.hour.toRadixString(BASE)}=${this.minute.toRadixString(BASE)}-${this.second.toRadixString(BASE)}";
  }
}

class Rambian implements Calendar {
  
  var year;
  String period;
  
  final qfyear = 2790;
  
  Rambian() {
    
  }
  
  update(DateTime time) {
    var year = time.year;
    
    if (year < qfyear) {
      this.year = -(qfyear-year);
      this.period = "BQF";
    } else {
      this.year = (year-qfyear);
      this.period = "AQF";
    }
  }
  
  String toString() {
    return "${this.year} ${this.period}";
  }
}