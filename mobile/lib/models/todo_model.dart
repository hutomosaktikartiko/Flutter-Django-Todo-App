class TodoModel {
  int id;
  final String title;
  final String description;

  TodoModel({this.id, this.title, this.description});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        id: json['id'], title: json['title'], description: json['description']);
  }
  dynamic toJson() => {'id': id, 'title': title, 'description': description};
}
