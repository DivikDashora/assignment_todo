class TodoModel {
  final int id;
  final String title;
  final String date;
  final int isComplete;

  TodoModel(
      {required this.id,
      required this.date,
      required this.isComplete,
      required this.title});
}
