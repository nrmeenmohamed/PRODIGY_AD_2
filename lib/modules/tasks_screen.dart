import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';


class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppDeleteDatabaseState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Task Deleted',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                ),
                backgroundColor: Colors.red.shade300,
                dismissDirection: DismissDirection.up,
                duration: const Duration(milliseconds: 800),
              ),
          );
        }
      },
      builder: (BuildContext context, AppStates state) {

        var newtTasks = AppCubit.get(context).newTask;

        return taskBuilder(tasks: newtTasks);
      },
    );
  }
}
