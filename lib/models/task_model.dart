class TaskModel {
  final String id;
  final String title;
  final String note;
  int isComplate;
  final String date;
  final String startTime;
  final String endTime;
  final String remind;
  final String repead;
  final int color;

  TaskModel(
      {required this.id,
      required this.title,
      required this.note,
      required this.isComplate,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.remind,
      required this.repead,
      required this.color});

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        id: map["ID"],
        title: map['title'],
        note: map['note'],
        isComplate: map['isComplate'],
        date: map['date'],
        startTime: map['startTime'],
        endTime: map['endTime'],
        remind: map['remind'],
        repead: map['repead'],
        color: map['color']);
  }

  Map<String, dynamic> toMap() => {
        'ID': id,
        'title': title,
        'note': note,
        'isComplate': isComplate,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'repead': repead,
        'color': color
      };
}
