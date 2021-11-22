import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressDialog {
  late ValueNotifier<String> _title;
  late ValueNotifier<String> _description;
  late ValueNotifier<int?> _percent;
  late ValueNotifier<bool> _showProgress;
  late ValueNotifier<List<Widget>> _actions;

  bool _dialogIsOpen = false;
  final BuildContext _context;
  bool _initialized = false;

  ProgressDialog(this._context) {
    _title = ValueNotifier("Progress Dialog");
    _percent = ValueNotifier(null);
    _description = ValueNotifier("This is a simple progress");
    _showProgress = ValueNotifier(true);
    _actions = ValueNotifier([
      PrimaryButton(
        label: "OK",
        onPressed: () => dismiss(),
      )
    ]);
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
    List<Widget>? actions,
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

    if (actions != null) {
      _actions.value = actions;
    }

    _dialogIsOpen = true;

    _showProgress.value = showProgress;
  }

  ///Shows the dialog
  void show({
    String? title,
    int? percent,
    String? description,
    bool barrierDismissible = true,
    bool showProgress = true,
    List<Widget>? actions,
  }) {
    _initialized = true;

    update(
      title: title,
      description: description,
      percent: percent,
      showProgress: showProgress,
      actions: actions,
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
                ValueListenableBuilder(
                  valueListenable: _actions,
                  builder: (_, List<Widget> value, __) => Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: value,
                  ),
                )
              ]),
          onWillPop: () => Future.value(barrierDismissible),
        );
      },
    );
  }
}
