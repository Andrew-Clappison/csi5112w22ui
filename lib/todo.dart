class Todo {
  String label;
  String description;
  Todo(this.label, this.description);

// sample data, hardcoded at step 1
  static List<Todo> todos = [
    Todo("Create group", "Create a group today with teammates"),
    Todo("Start project", "Plan for demo next week"),
    Todo("Learn Dart and Flutter", "Before the end of next week")
  ];
}
