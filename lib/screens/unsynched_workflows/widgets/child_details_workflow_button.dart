import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChildDetailsWorkflowButton extends StatelessWidget {
  const ChildDetailsWorkflowButton({
    super.key,
    required this.workflowName,
    required this.onClick,
  });

  final String workflowName;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.black26,
        width: 1,
      ))),
      child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            onClick();
          },
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.file,
                size: 12,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(workflowName),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    "-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
