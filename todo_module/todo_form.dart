import 'package:flutter/material.dart';
import 'todo_model.dart';
import 'todo_service.dart';

class TodoForm extends StatefulWidget {
  final Todo? item;
  final bool editMode;

  const TodoForm({super.key, this.item, this.editMode = false});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;
  bool _completed = false;

  bool _changed = false;
  String _output = "";

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(
      text: widget.editMode ? widget.item?.title ?? "" : "",
    );
    _descriptionCtrl = TextEditingController(
      text: widget.editMode ? widget.item?.description ?? "" : "",
    );
    _completed = widget.editMode ? widget.item?.completed ?? false : false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, res) {
        if (!didPop) {
          Navigator.of(context).pop(_changed);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(_changed);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(widget.editMode ? "Edit Todo" : "Add Todo"),
          actions: [widget.editMode ? _buildDeleteButton() : const SizedBox()],
        ),
        body: _buildBody(),
      ),
    );
  }

  Future<bool?> _showDeleteDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Todo"),
          content: const Text("Are you sure you want to delete this todo?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      onPressed: () async {
        bool? deleted = await _showDeleteDialog() ?? false;
        if (deleted) {
          TodoService.delete(widget.item!.id)
              .then((value) {
                setState(() {
                  _output = value.toString();
                  _changed = value;
                });
                Navigator.of(context).pop(_changed);
              })
              .onError((e, s) {
                setState(() {
                  _output = "Error: ${e.toString()}";
                });
              });
        }
      },
      icon: const Icon(Icons.delete),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildTextField(_titleCtrl, "Title"),
          const SizedBox(height: 12),
          _buildTextField(_descriptionCtrl, "Description", maxLines: 4),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text("Completed"),
            value: _completed,
            onChanged: (val) {
              setState(() {
                _completed = val;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildButton(),
          const SizedBox(height: 12),
          _buildOutput(),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label is required.";
        }
        return null;
      },
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (widget.editMode) {
            _onUpdateTodo();
          } else {
            _onAddTodo();
          }
        }
      },
      child: const Text("Save Todo"),
    );
  }

  Widget _buildOutput() {
    return Text(_output);
  }

  void _onAddTodo() {
    Todo item = Todo(
      id: 0,
      title: _titleCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      completed: _completed,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    TodoService.insert(item)
        .then((value) {
          setState(() {
            _output = value.toString();
            _changed = value;
          });
          if (value == true) {
            Navigator.of(context).pop(true);
          }
        })
        .onError((e, s) {
          setState(() {
            _output = "Error: ${e.toString()}";
          });
        });
  }

  void _onUpdateTodo() {
    Todo item = Todo(
      id: widget.item!.id,
      title: _titleCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      completed: _completed,
      createdAt: widget.item!.createdAt,
      updatedAt: DateTime.now(),
    );

    TodoService.update(item)
        .then((value) {
          setState(() {
            _output = value.toString();
            _changed = value;
          });
          if (value == true) {
            Navigator.of(context).pop(true);
          }
        })
        .onError((e, s) {
          setState(() {
            _output = "Error: ${e.toString()}";
          });
        });
  }
}
