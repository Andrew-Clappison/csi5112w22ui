class Todo {
  String id;
  String label;
  String description;
  bool complete;

  Todo(this.id, this.label, this.description, this.complete);

// sample data, hardcoded at step 1
  static List<Todo> todos = [
    Todo("1", "Create group", "Create a group today with teammates", false),
    Todo("2", "Start project", "Plan for demo next week", false),
    Todo("3", "Learn Dart and Flutter", "Before the end of next week", false)
  ];

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['id'],
      json['name'],
      json['description'],
      json['isComplete'],
    );
  }

  static List<Todo> fromListJson(List<dynamic> json) {
    List<Todo> result = <Todo>[];
    for (Map<String, dynamic> d in json) {
      result.add(Todo.fromJson(d));
    }
    return result;
  }
}
