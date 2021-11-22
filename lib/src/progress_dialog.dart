import 'dart:developer';

import 'package:flutter/material.dart';

class ProgressDialog {
  late ValueNotifier<String> _title;
  late ValueNotifier<String> _description;
  late ValueNotifier<int?> _percent;
  late ValueNotifier<bool> _showProgress;

  bool _dialogIsOpen = false;
  final BuildContext _context;
  bool _initialized = false;

  ProgressDialog(this._context) {
    _title = ValueNotifier("Progress Dialog");
    _percent = ValueNotifier(null);
    _description = ValueNotifier("This is a simple progress");
    _showProgress = ValueNotifier(true);
  }

  ///Returns [bool] whether the dialog is open
  bool isOpen() => _dialogIsOpen;

  ///Dismiss the dialog if it is open
  void dismiss() {
    if (_dialogIsOpen) {
      Navigator.pop(_context);
      _dialogIsOpen = false;
    }
  }

  ///Updates the dialog
  void update({
    String? title,
    int? percent,
    String? description,
    bool showProgress = true,
  }) {
    assert(_initialized == true,
        "Progress Dialog must be initialized by calling show()");

    if (title != null) {
      _title.value = title;
    }
    _percent.value = percent;

    if (description != null) {
      _description.value = description;
    }

    _dialogIsOpen = true;

    log(showProgress.toString());
    _showProgress.value = showProgress;
  }

  ///Shows the dialog
  void show({
    String? title,
    int? percent,
    String? description,
    Function()? onTap,
    bool barrierDismissible = true,
    bool showProgress = true,
  }) {
    _initialized = true;

    update(
      title: title,
      description: description,
      percent: percent,
      showProgress: showProgress,
    );

    showDialog(
      context: _context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return WillPopScope(
          child: AlertDialog(
              title: ValueListenableBuilder(
                valueListenable: _title,
                builder: (_, String value, __) => Text(value),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _description,
                    builder: (_, String value, __) => Text(value),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _showProgress,
                    builder: (_, bool value, __) => Visibility(
                      visible: value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10.0),
                          ValueListenableBuilder(
                            valueListenable: _percent,
                            builder: (_, int? value2, __) =>
                                LinearProgressIndicator(
                              value: (value2 == null) ? null : value2 / 100.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              actions: [
                MaterialButton(
                  elevation: 0.0,
                  color: const Color(0xFF0085FF),
                  onPressed: onTap,
                  textColor: Colors.white,
                  child: const Text("OK"),
                )
              ]),
          onWillPop: () => Future.value(barrierDismissible),
        );
      },
    );
  }
}