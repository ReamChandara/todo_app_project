// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/repo/task_repo.dart';

class TaskController extends GetxController {
  late TaskRepo repos;
  RxBool isLoading = true.obs;
  RxList<TaskModel> taskModels = <TaskModel>[].obs;
  TaskController() {
    repos = TaskRepo();
  }
  @override
  void onInit() {
    showTask();
    super.onInit();
  }

  showTask() async {
    try {
      isLoading(true);
      List<Map<String, dynamic>> taskMap = await repos.selectTask();
      taskModels.value = taskMap.map((e) => TaskModel.fromMap(e)).toList();
    } finally {
      isLoading(false);
    }
  }

  addTask(TaskModel taskModel) async {
    return await repos.insertTask(taskModel);
  }

  deleteTask(String taskId) async {
    return await repos.deleteTask(taskId);
  }

  makeTakeComplate(String taskId) async {
    return await repos.updateTask(taskId);
  }
}
