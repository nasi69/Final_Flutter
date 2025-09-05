import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'message.util.dart';
import 'todo_form.dart';
import 'todo_login_screen.dart';
import 'todo_service.dart';
import 'todo_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late Future<Todomodel> _futureTodo;
  final _scroller = ScrollController();
  bool _showUpIcon = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _futureTodo = TodoService.read(_currentPage);

    _scroller.addListener(() {
      if (_scroller.position.pixels == _scroller.position.maxScrollExtent) {
        debugPrint("Reached the bottom");
      }

      if (_scroller.position.pixels <= 300) {
        setState(() {
          _showUpIcon = false;
        });
      } else {
        setState(() {
          _showUpIcon = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Screen"),
        actions: [
          IconButton(
            onPressed: () async {
              bool? edited = await Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => const TodoForm()),
              );

              if (edited == true) {
                setState(() {
                  _futureTodo = TodoService.read(_currentPage);
                });
              }
            },
            icon: const Icon(Icons.add_task),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const TodoLoginScreen()),
              );
            },
            tooltip: "Logout",
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _showUpIcon ? _buildFloating() : null,
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: () {
        _scroller.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: const Icon(Icons.arrow_upward),
    );
  }

  Widget _buildBody() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureTodo = TodoService.read(_currentPage);
          });
        },
        child: FutureBuilder<Todomodel>(
          future: _futureTodo,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _buildError(snapshot.error);
            }

            if (snapshot.connectionState == ConnectionState.done) {
              debugPrint("model: ${snapshot.data}");
              return _buildDataModel(snapshot.data);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildError(Object? error) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 48.0),
          const SizedBox(height: 16.0),
          Text('Error: $error', style: const TextStyle(fontSize: 16.0)),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _futureTodo = TodoService.read(_currentPage);
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          )
        ],
      ),
    );
  }

  Widget _buildDataModel(Todomodel? model) {
    if (model == null) {
      return const SizedBox();
    }
    return _buildListView(model);
  }

  void _deleteItem(Todo item) async {
    bool? deleted = await showDeleteDialog(context);
    if (deleted == true) {
      try {
        bool success = await TodoService.delete(item.id);
        if (success) {
          setState(() {
            _futureTodo = TodoService.read(_currentPage);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Todo deleted successfully")),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${error.toString()}")),
        );
      }
    }
  }

  Widget _buildListView(Todomodel model) {
    return ListView.builder(
      controller: _scroller,
      physics: const BouncingScrollPhysics(),
      itemCount: model.data.length + 1, // +1 for pagination controls
      itemBuilder: (context, index) {
        if (index == model.data.length) {
          // Pagination controls
          return _buildPaginationControls(model);
        }
        
        final item = model.data[index];
        return Dismissible(
          key: Key(item.id.toString()),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              _deleteItem(item);
            }
            return false; // prevent auto remove
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            child: ListTile(
              title: Text(item.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description),
                  Text('Completed: ${item.completed}'),
                  Text('Created: ${_formatDate(item.createdAt)}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      try {
                        bool success = await TodoService.toggleComplete(
                          item.id, 
                          !item.completed
                        );
                        if (success) {
                          setState(() {
                            _futureTodo = TodoService.read(_currentPage);
                          });
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${error.toString()}")),
                        );
                      }
                    },
                    icon: Icon(
                      item.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: item.completed ? Colors.green : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _deleteItem(item),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
              onTap: () async {
                bool? edited = await Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => TodoForm(item: item, editMode: true),
                  ),
                );

                if (edited == true) {
                  setState(() {
                    _futureTodo = TodoService.read(_currentPage);
                  });
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaginationControls(Todomodel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (model.currentPage > 1)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentPage = model.currentPage - 1;
                  _futureTodo = TodoService.read(_currentPage);
                });
              },
              child: const Text('Previous'),
            ),
          const SizedBox(width: 16),
          Text('Page ${model.currentPage} of ${model.lastPage}'),
          const SizedBox(width: 16),
          if (model.currentPage < model.lastPage)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentPage = model.currentPage + 1;
                  _futureTodo = TodoService.read(_currentPage);
                });
              },
              child: const Text('Next'),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}