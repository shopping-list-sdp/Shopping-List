import 'package:flutter/material.dart';

class BodyLayout extends StatelessWidget {
  const BodyLayout(BuildContext context, List<String> elements, {super.key});

  List<String>? get elements => null;

  @override
  Widget build(BuildContext context) {
    return _myListView(context, elements!);
  }
}

Widget _myListView(BuildContext context, List<String> elements) {
  return ListView.builder(
      itemCount: elements.length,
      itemBuilder: ((context, index) {
        return ListTile(
            leading: const Icon(Icons.list_alt),
            title: Text(elements[index]),
            subtitle: const Text("Number of Items in List"));
      }));
}
