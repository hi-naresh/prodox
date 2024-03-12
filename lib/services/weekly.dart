import '../model/routine_model.dart';
import 'category_model.dart';
import 'data_fetch.dart';

List<List<double>> calculateWeeklyProductivity(List<Routine> weeklyRoutines) {
  // Define the maximum value for a full productive day for normalization purposes
  double maxProductiveHoursPerDay = 8.0;
  List<List<double>> weeklyData = [];

  for (Routine dailyRoutine in weeklyRoutines) {
    // Initialize a map to keep the total duration per category for the day
    Map<TaskCategory, double> categoryDurations = {};
    for (Task task in dailyRoutine.tasks) {
      categoryDurations.update(task.category, (existingDuration) => existingDuration + task.duration.inHours,
          ifAbsent: () => task.duration.inHours.toDouble());
    }

    // Normalize the values to match the chart's requirement (assuming a 0-10 range)
    List<double> dailyProductivityData = TaskCategory.values.map((category) {
      return (categoryDurations[category] ?? 0) / maxProductiveHoursPerDay * 10;
    }).toList();

    weeklyData.add(dailyProductivityData);
  }

  return weeklyData;
}

Future<List<Routine>> populateWeeklyRoutines() async {
  List<TaskModel> taskModels =
  await fetchTasks(); // Implement fetchTasks to get the tasks for the week

  List<Routine> weeklyRoutines = [];

  // Your logic here: categorize tasks and add to the respective day's routine
  // For simplicity, assuming all tasks belong to one day
  List<Task> tasks = taskModels.map((taskModel) {
    TaskCategory? category = Task.getCategoryForTask(taskModel.tag);
    return Task(
      name: taskModel.name,
      duration: taskModel.endTime.difference(taskModel.startTime),
      category:
      category ?? TaskCategory.other, // Fallback to 'other' category
    );
  }).toList();

  // For this example, we consider all tasks to be from the same day
  Routine dailyRoutine = Routine(tasks: tasks);
  // Add the same routine for each day of the week for simplicity
  for (int i = 0; i < 7; i++) {
    weeklyRoutines.add(dailyRoutine);
  }

  return weeklyRoutines;
}
