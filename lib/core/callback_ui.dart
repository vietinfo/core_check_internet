import 'package:flutter/material.dart';

class CallBackUI extends StatefulWidget {
  final VoidCallback callbackback;
  final Widget child;
  const CallBackUI({Key? key, required this.callbackback, required this.child})
      : super(key: key);

  @override
  State<CallBackUI> createState() => _CallBackUIState();
}

class _CallBackUIState extends State<CallBackUI> {
  @override
  void initState() {
    // TODO: implement initState
    widget.callbackback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
