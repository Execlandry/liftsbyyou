import 'package:flutter/foundation.dart';
import 'package:liftsbyyou/models/exercise.dart';
import 'package:liftsbyyou/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  /*
  --> this is overall list that contains the different workouts
  --> Each workout has a name, and list of exercise
*/
  List<Workout> workoutList = [
    Workout(
      name: "Upper Body",
      exercises: [Exercise(name: "Bicep", weight: "7.5", reps: "8", sets: "3")],
    ),
  ];

  //-->get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // -->get length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  //-->add a workout
  void addWorkout(String name) {
    // add a new workout with a blank list of exercises
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  // -->add an exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    //find relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));

    notifyListeners();
  }
  // -->check off exercise

  void checkOffExercise(String workoutName, String exerciseName) {
    //find relevant exercise in that workout

    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    //check off boolean to show user completed the exercise
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

//return relevant workout object,given a workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  //return relevant exercise object,given a workout name = exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    //find relevant workout first

    Workout relevantWorkout = getRelevantWorkout(workoutName);

    //then find the relevant exercise in that workout
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}
