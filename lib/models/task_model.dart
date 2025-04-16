class TaskModel {
  int? id;
  String title;
  String? description;
  bool done;
  DateTime createdAt;

  TaskModel({this.id, required this.title, this.description, this.done = false, DateTime? createdAt}) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description, 'done': done ? 1 : 0, 'created_at': createdAt.toIso8601String()};
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      done: map['done'] == 1,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : DateTime.now(),
    );
  }
}

extension TaskModelCopyWith on TaskModel {
  TaskModel copyWith({int? id, String? title, String? description, bool? done, DateTime? createdAt}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      done: done ?? this.done,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
