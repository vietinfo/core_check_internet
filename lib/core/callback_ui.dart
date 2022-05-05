import 'package:flutter/material.dart';

class CallBackUI extends StatefulWidget {
  final Future Function() callback;
  final Widget child;
  const CallBackUI({Key? key, required this.callback, required this.child})
      : super(key: key);

  @override
  State<CallBackUI> createState() => _CallBackUIState();
}

class _CallBackUIState extends State<CallBackUI> {
  @override
  void initState() {
    // TODO: implement initState
    widget.callback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
