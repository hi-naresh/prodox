enum TaskCategory {
  work, // Work-Related: Office Work, Remote Work, Meetings, Business Development, Research, Networking
  education, // Educational: Study, Homework, Online Courses, Lectures, Academic Research, Skill Development
  exercise, // Health and Well-being: Exercise, Yoga
  timePass, // Time Pass: TV, Movies
  meditation, // Meditation
  personalCare, // Personal Care: Grooming, Shopping, Cooking, Eating, Sleep
  leisure, // Leisure, Hobbies, TV/Movies, Reading, Gaming, Travel
  social, // Socializing: Social Calls, Social Visits, Social Events
  chores, // Chores and Maintenance: Cleaning, Laundry, Home Repairs, Gardening, Car Maintenance
  family, // Family and Relationships: Family Time, Child Care, Pet Care, Date Night, Social Visits
  finance, // Financial Management: Budgeting, Bill Payments, Investing, Financial Planning
  volunteer, // Volunteering and Community Service: Charity Work, Community Meetings, Volunteering
  creative, // Creative Work: Writing, Music, Design, Crafting
  spiritual, // Spiritual Activities: Prayer, Religious Services, Spiritual Reading
  professional, // Professional Development: Conferences, Workshops, Networking Events, Professional Reading
  fitness, // Health and Fitness: Gym, Running, Sports, Health Challenges
  mindfulness, // Mindfulness and Relaxation: Meditation, Mindfulness Practices, Breathing Exercises
  outdoor, // Outdoor Activities: Hiking, Biking, Gardening, Walking
  planning,
  other, // Planning and Organization: Daily Planning, Goal Setting, Decluttering
}

class Task {
  String name;
  Duration duration;
  TaskCategory category;

  Task({
    required this.name,
    required this.duration,
    required this.category,
  });

  static TaskCategory? getCategoryForTask(String taskName) {
    // Replace this with your logic to categorize tasks , use tag for categorization , ignoreCase
    if (taskName.toLowerCase().contains('work')) {
      return TaskCategory.work;
    } else if (taskName.toLowerCase().contains('education')) {
      return TaskCategory.education;
    } else if (taskName.toLowerCase().contains('exercise')) {
      return TaskCategory.exercise;
    } else if (taskName.toLowerCase().contains('time pass')) {
      return TaskCategory.timePass;
    } else if (taskName.toLowerCase().contains('meditation')) {
      return TaskCategory.meditation;
    } else if (taskName.toLowerCase().contains('personal care')) {
      return TaskCategory.personalCare;
    } else if (taskName.toLowerCase().contains('leisure')) {
      return TaskCategory.leisure;
    } else if (taskName.toLowerCase().contains('social')) {
      return TaskCategory.social;
    } else if (taskName.toLowerCase().contains('chores')) {
      return TaskCategory.chores;
    } else if (taskName.toLowerCase().contains('family')) {
      return TaskCategory.family;
    } else if (taskName.toLowerCase().contains('finance')) {
      return TaskCategory.finance;
    } else if (taskName.toLowerCase().contains('volunteer')) {
      return TaskCategory.volunteer;
    } else if (taskName.toLowerCase().contains('creative')) {
      return TaskCategory.creative;
    } else if (taskName.toLowerCase().contains('spiritual')) {
      return TaskCategory.spiritual;
    } else if (taskName.toLowerCase().contains('professional')) {
      return TaskCategory.professional;
    } else if (taskName.toLowerCase().contains('fitness')) {
      return TaskCategory.fitness;
    } else if (taskName.toLowerCase().contains('mindfulness')) {
      return TaskCategory.mindfulness;
    } else if (taskName.toLowerCase().contains('outdoor')) {
      return TaskCategory.outdoor;
    } else if (taskName.toLowerCase().contains('planning')) {
      return TaskCategory.planning;
    } else {
      return null;
    }
  }

}

class Routine {
  List<Task> tasks;

  Routine({required this.tasks});
}

