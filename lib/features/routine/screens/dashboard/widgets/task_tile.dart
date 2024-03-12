import 'package:flutter/material.dart';
import 'package:prodox/utils/formatters/formatter.dart';

import '../../../../../common/styles/styles.dart';
import '../../../../../utils/constants/colors.dart';
class TaskTile extends StatelessWidget {
  // dynamic -TaskModel
  final dynamic task;
  final Function(String, String) updateTaskStatus;

  TaskTile({Key? key, required this.task, required this.updateTaskStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCompleted = task.status.toLowerCase() == 'completed';
    bool isOverdue = DateTime.now().isAfter(task.endTime) && !isCompleted;

    return Container(
      margin: const EdgeInsets.all(18.0),
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(25),
      //   boxShadow: [
      //     BoxShadow(
      //       color: PColors.accent3Light.withOpacity(0.1),
      //       spreadRadius: 2,
      //       blurRadius: 10,
      //       blurStyle: BlurStyle.outer,
      //       offset: const Offset(10, 10),
      //     ),
      //   ],
      //   border: Border.all(
      //     color: isOverdue ? PColors.accent4: PColors.accent1,
      //     width: 2,
      //   ),
      // ),
      decoration: PStyles.lightToDark(
        isOverdue ? PColors.accent2 : PColors.accent1,
      ),
      child: ListTile(
        title: Text('${task.name} (${task.tag})'),
        subtitle: Text(
          '${PFormatter.formatTime(task.startTime)} - ${PFormatter.formatTime(task.endTime)}',
          style: TextStyle(
            // color: isOverdue ? PColors.accent2 : PColors.accent1,
            decoration:
            isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        leading: CircleAvatar(
          child: isCompleted
              ? Icon(Icons.check, color: Colors.white)
              : isOverdue
              ? Icon(Icons.close, color: Colors.white)
              : Icon(Icons.hourglass_empty, color: Colors.white),
          backgroundColor: isCompleted
              ? PColors.accent1
              : isOverdue
              ? PColors.accent2
              : Colors.grey,
        ),
        trailing: isOverdue
            ? IconButton(
          icon: Icon(Icons.update),
          onPressed: () => updateTaskStatus(task.id, 'overdue'),
        )
            : isCompleted
            ? IconButton(
          icon: Icon(Icons.undo),
          onPressed: () => updateTaskStatus(task.id, 'pending'),
        )
            : IconButton(
          icon: Icon(Icons.check),
          onPressed: () => updateTaskStatus(task.id, 'completed'),
        ),
      ),
    );
  }
}