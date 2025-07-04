import 'package:flutter/material.dart';

class MultiSelectDialog extends StatefulWidget {
  final String title;
  final Map<String, String> options;
  final List<String> selected;

  const MultiSelectDialog({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
  });

  @override
  State<MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _tempSelected;

  @override
  void initState() {
    super.initState();
    _tempSelected = List.from(widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          children: widget.options.entries.map((entry) {
            final code = entry.key;
            final label = entry.value;
            return CheckboxListTile(
              value: _tempSelected.contains(code),
              title: Text(label),
              onChanged: (selected) {
                setState(() {
                  if (selected == true) {
                    _tempSelected.add(code);
                  } else {
                    _tempSelected.remove(code);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Apply"),
          onPressed: () => Navigator.pop(context, _tempSelected),
        ),
      ],
    );
  }
}
