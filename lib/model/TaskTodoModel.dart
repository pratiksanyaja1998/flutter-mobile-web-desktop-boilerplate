class TaskTodoModel {

  String taskTitle;
  String taskDesc;
  DateTime dateTime;

  TaskTodoModel({
    this.taskTitle,
    this.taskDesc,
    this.dateTime,
  });

  TaskTodoModel.fromJson(Map json)
      : taskTitle = json['taskTitle'],
        taskDesc = json['taskDesc'],
        dateTime = json['created_at'];

  Map toJson() {
    Map map = new Map();
    map["taskTitle"] = taskTitle;
    map["taskDesc"] = taskDesc;
    map["created_at"] = dateTime;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'taskTitle': taskTitle,
      'taskDesc': taskDesc,
      'created_at': dateTime,
    };
  }
}