library Ficalendar;

import "clock.dart";

abstract class Calendar {
  
  static var months = 12;
  
  var dayspermonth;
  var monthsperyear;
  
  Calendar() {
    this.dayspermonth = 30;
    this.monthsperyear = 12;
  }
  
  void update(DateTime time) {
    
  }
}

class Ficverse extends Calendar {
  
}

class Bunsen extends Calendar {
  
}

class Cyrannian implements Calendar {
  
  var dayspermonth;
  var monthsperyear;
  
  var year;
  var month;
  String monthname;
  
  Cyrannian() {
    this.monthsperyear = 6;
  }
  
  void update(DateTime time) {
    var year = time.year;
    this.month = (time.month/2).floor();
    
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
  
  String toString() {
    return "${this.monthname} ${year}";
  }
}

class Draconid extends Calendar {
  
  Draconid() {
    this.dayspermonth = 30;
    this.monthsperyear = 12;
  }
  
  
  
}

class Farengto extends Calendar {
  
}

class Rambian extends Calendar {
  
}