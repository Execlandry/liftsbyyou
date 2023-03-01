import 'package:flutter/material.dart';
import 'package:liftsbyyou/data/workout_data.dart';
import 'package:liftsbyyou/pages/workout_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //create a new workout
  final newWorkoutNameController = TextEditingController();

  void createNewWorkout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Create new workout'),
              content: TextField(controller: newWorkoutNameController),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: Text("Save"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: Text("Cancel"),
                ),
              ],
            ));
  }

  //go to workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutPage(workoutName: workoutName),
        ));
  }

  //save workout
  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    //add workout to workoutdata list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: const Text("Lift Tracker"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: createNewWorkout,
              child: Icon(Icons.add),
            ),
            body: ListView.builder(
                itemCount: value.getWorkoutList().length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(value.getWorkoutList()[index].name),
                      trailing: IconButton(
                          onPressed: () => goToWorkoutPage(
                              value.getWorkoutList()[index].name),
                          icon: Icon(Icons.arrow_forward_ios)),
                    ))));
  }
}
