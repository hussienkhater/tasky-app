class TaskModel {
  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    this.isDone = false,
  });
    String? id;
  final String title;
  final String? description;
  final DateTime ? date;
  final int? priority;
  bool? isDone;


  TaskModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        priority: json['priority'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "date": date?.millisecondsSinceEpoch,
      "id": id,
      "priority": priority,
      "isDone": isDone,
    };
  }
}