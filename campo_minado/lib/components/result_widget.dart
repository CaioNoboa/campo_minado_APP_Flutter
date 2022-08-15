import 'package:flutter/material.dart';

// Para que essa classe possa ser a appBar, precisamos implementar o PreferredSizeWidget
class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? won;
  final Function()? onRestart;

  const ResultWidget({
    Key? key,
    required this.won,
    required this.onRestart,
  }) : super(key: key);

  Color _getColor() {
    if (won == null) {
      return Colors.yellow;
    } else if (won!) {
      return Colors.green.shade300;
    } else {
      return Colors.red.shade300;
    }
  }

  IconData _getIcon() {
    if (won == null) {
      return Icons.sentiment_satisfied;
    } else if (won!) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: onRestart,
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
