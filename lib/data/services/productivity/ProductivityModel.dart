
import '../../../utils/constants/enums.dart';

class ProductivityModel {
  //dynamic - routine
  dynamic routine;
  Map<TaskCategory, Duration> categoryDurations = {};

  ProductivityModel({required this.routine}) {
    _calculateCategoryDurations();
  }

  final Map<TaskCategory, double> categoryWeights = {
    TaskCategory.work: 1.0,
    TaskCategory.education: 1.0,
    TaskCategory.exercise: 0.8,
    TaskCategory.timePass: 0.2,
    TaskCategory.meditation: 0.7,
    TaskCategory.personalCare: 0.6,
    TaskCategory.leisure: 0.5,
    TaskCategory.social: 0.7,
    TaskCategory.chores: 0.5,
    TaskCategory.family: 0.8,
    TaskCategory.finance: 0.9,
    TaskCategory.volunteer: 0.8,
    TaskCategory.creative: 0.9,
    TaskCategory.spiritual: 0.7,
    TaskCategory.professional: 1.0,
    TaskCategory.fitness: 0.8,
    TaskCategory.mindfulness: 0.7,
    TaskCategory.outdoor: 0.7,
    TaskCategory.planning: 1.0,
  };

  void _calculateCategoryDurations() {
    for (var task in routine.tasks) {
      var duration = task.duration;
      categoryDurations.update(task.category, (existingDuration) => existingDuration + duration, ifAbsent: () => duration);
    }
  }

  static Map<TaskCategory, int> calculateTotalCategoryDuration(
      //dynamic - routine
      List<dynamic> routines) {
    Map<TaskCategory, int> categoryDurations = {};
    for (var routine in routines) {
      for (var task in routine.tasks) {
        if (categoryDurations.containsKey(task.category)) {
          // categoryDurations[task.category] =
          // (categoryDurations[task.category]! + task.duration.inMinutes );
        } else {
          categoryDurations[task.category] = task.duration.inMinutes ;
        }
      }
    }
    //divide by 60 to get hours
    categoryDurations.updateAll((key, value) => value ~/ 60);
    return categoryDurations;
  }

  double calculateDailyProductivity() {
    double dailyScore = 0;
    for (var task in routine.tasks) {
      dailyScore += task.duration.inMinutes * (categoryWeights[task.category] ?? 0);
    }
    return dailyScore / 60; // Convert minutes to hours for the score
  }

  double calculateOverallProductivity() {
    double totalWeightedDuration = 0;
    double totalPossibleDuration = 0;
    categoryDurations.forEach((category, duration) {
      totalWeightedDuration += (duration.inMinutes * categoryWeights[category]!);
      totalPossibleDuration += (duration.inMinutes * 1.0); // Assuming 1.0 as the base weight for maximal productivity
    });
    return totalWeightedDuration / totalPossibleDuration * 100;
  }
}
// void main() {
//   final routine = Routine(
//       tasks: [
//         Task(name: "Office Work", duration: Duration(hours: 7), category: TaskCategory.work),
//         Task(name: "Study", duration: Duration(hours: 2), category: TaskCategory.education),
//         Task(name: "Gym", duration: Duration(hours: 1), category: TaskCategory.exercise),
//         Task(name: "TV", duration: Duration(hours: 2), category: TaskCategory.timePass),
//       ]
//   );
//
//   print(ProductivityModel.calculateTotalCategoryDuration([routine]));
//   final productivityModel = ProductivityModel(routine: routine);
//   print("Daily Productivity: ${productivityModel.calculateDailyProductivity()} hours");
//   print("Overall Productivity: ${productivityModel.calculateOverallProductivity()}%");
//
// }
