import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final bool? isCompleted;

  const TaskEntity({this.id, this.title, this.description, this.isCompleted});

  TaskEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List get props => [id, title, description, isCompleted];
}
