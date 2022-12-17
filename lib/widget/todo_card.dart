import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final Map item;
  final int index;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;
  const TodoCard(
      {super.key,
      required this.index,
      required this.item,
      required this.navigateEdit,
      required this.deleteById});

  @override
  Widget build(BuildContext context) {
    final id = item['_id'] as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['title']),
        subtitle: Text(item['description']),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              //!open edit page
              navigateEdit(item);
            } else if (value == 'delete') {
              //! delete the todo item and refresh todo list
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('Edit'),
                value: 'edit',
              ),
              PopupMenuItem(
                child: Text('Delete'),
                value: 'delete',
              ),
            ];
          },
        ),
      ),
    );
  }
}
