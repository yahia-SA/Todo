import 'package:flutter/material.dart';
import 'package:iti_task9/main.dart';

import 'model.dart';


class Sql extends StatefulWidget {
  const Sql({ Key? key }) : super(key: key);

  @override
  _SqlState createState() => _SqlState();
}

class _SqlState extends State<Sql> {
  List<Map<String, dynamic>> _Movies = [];

  bool _isLoading = true;
  void _refresh() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _Movies = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh(); 
  }

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final data =
          _Movies.firstWhere((element) => element['id'] == id);
      _titleController.text = data['title'];
      _descriptionController.text = data['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        builder: (_) => Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Title'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType:TextInputType.datetime ,
                    controller: _descriptionController,
                    decoration: InputDecoration(hintText: 'Date'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaubutton(function: () async {
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      _titleController.text = '';
                      _descriptionController.text = '';

                      Navigator.of(context).pop();
                    }, title:(id == null ? 'Create New' : 'Update'),),
                ],
              ),
            ));
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refresh();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refresh();
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Successfully deleted'),
    ));
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sqflite'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _Movies.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text(_Movies[index]['title']),
                    subtitle: Text(_Movies[index]['description']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _showForm(_Movies[index]['id']),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                _deleteItem(_Movies[index]['id']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
