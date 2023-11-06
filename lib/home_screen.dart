import 'package:flutter/material.dart';
import 'package:listview_flutter/db_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _allData = [];

  bool _isLoading = true;
//Get all the data from the database
  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

//Add data
  Future<void> _addData() async {
    await SQLHelper.createData(_nameController.text, _accountController.text);
    _refreshData();
  }

//Update data
  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
        id, _nameController.text, _accountController.text);
    _refreshData();
  }

//Delete data
  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          'Data deleted',
          style: TextStyle(fontSize: 20),
        )));
    _refreshData();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _nameController.text = existingData['name'];
      _accountController.text = existingData['account'];
    }

    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  top: 30,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _accountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Account',
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (id == null) {
                          await _addData();
                        } else {
                          await _updateData(id);
                        }

                        _nameController.text = '';
                        _accountController.text = '';

                        //Hide Form
                        Navigator.of(context).pop();
                        print('Data added successfully');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          id == null ? 'Add data' : 'Update',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEAF4),
      appBar: AppBar(
        title: const Text('List View'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allData.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      _allData[index]['name'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Text(_allData[index]['account']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () {
                          showBottomSheet(_allData[index]['id']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.redAccent,
                        onPressed: () {
                          _deleteData(_allData[index]['id']);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
