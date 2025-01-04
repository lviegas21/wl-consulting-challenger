import '../../domain/entities/entities.dart';

class TaskModel {
  final int? id;
  final String? title;
  final String? description;
  final bool? isCompleted;

  TaskModel({this.id, this.title, this.description, this.isCompleted});

  factory TaskModel.fromJson(Map json) {
    return TaskModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      isCompleted: json["isCompleted"] == 0 ? false : true,
    );
  }
  static TaskModel fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted!,
      };

  TaskEntity toEntity() => TaskEntity(
      id: id, title: title, description: description, isCompleted: isCompleted);
}
