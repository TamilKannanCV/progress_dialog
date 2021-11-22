import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TextButton(
          child: const Text("Show progress"),
          onPressed: () {
            final pd = ProgressDialog(context);
            pd.show(
              title: "Progress Dialog",
              description: "Timer is loading",
            );
            int progress = 0;
            Timer.periodic(const Duration(seconds: 1), (ticker) {
              if (progress >= 100) {
                ticker.cancel();
                pd.update(
                    showProgress: false,
                    description: "Completed",
                    actions: [
                      PrimaryButton(
                        label: "DONE",
                        onPressed: () => pd.dismiss(),
                      )
                    ]);
                return;
              }
              pd.update(percent: progress += 10);
            });
          },
        ),
      ),
    );
  }
}
