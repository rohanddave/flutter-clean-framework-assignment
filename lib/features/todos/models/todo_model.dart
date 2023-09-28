class TodoModel {
  final String title;
  final int id;

  TodoModel({
    required this.title,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
