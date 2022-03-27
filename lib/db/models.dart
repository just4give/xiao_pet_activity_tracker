class DailyLog {
  late int id;
  late String day;
  late int ts;
  late int ttl;
  late String log;
  late String series;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'day': day,
      'ts': ts,
      'ttl': ttl,
      'log': log,
      'series': series,
      'id': id
    };

    return map;
  }

  DailyLog.fromMap(Map<String, Object?> map) {
    id = map['id'] != null ? int.parse(map['id'].toString()) : 0;
    ts = int.parse(map['ts'].toString());
    ttl = int.parse(map['ttl'].toString());
    log = map['log'].toString();
    series = map['series'].toString();
    day = map['day'].toString();
  }
}

class WeeklyLog {
  late int seq;
  late String day;
  late String log;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{'day': day, 'log': log, 'seq': seq};

    return map;
  }

  WeeklyLog.fromMap(Map<String, Object?> map) {
    seq = map['seq'] != null ? int.parse(map['seq'].toString()) : 0;
    log = map['log'].toString();
    day = map['day'].toString();
  }
}
