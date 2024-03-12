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
  planning, // Planning and Organization: Daily Planning, Goal Setting, Decluttering
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
}

class Routine {
  List<Task> tasks;

  Routine({required this.tasks});
}