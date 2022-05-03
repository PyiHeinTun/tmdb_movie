import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void errorAlert(BuildContext context, var bloc) {
  bool? errorFlag;
  SchedulerBinding.instance!.addPostFrameCallback((_) {
    errorFlag = bloc.errorFlag;
    if (errorFlag == true) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error Occured'),
            content: Text(
              bloc.errorMessage!,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
      errorFlag = false;
    }
  });
}
