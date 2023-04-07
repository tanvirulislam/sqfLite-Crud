import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sqflite_crud/db_helper.dart';
import 'package:sqflite_crud/model/notes.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper? dbHelper;

  Future<List<NoteModel>> loadData() async {
    return await dbHelper!.getNoteList();
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    loadData();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void clearText() {
    nameController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    print('home build-----------------');
    var themeColor = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('sqfite crud operetion')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder(
                future: loadData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NoteModel>> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data![index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading:
                                CircleAvatar(child: Text(data.id.toString())),
                            title: Text(data.title),
                            subtitle: Text(data.email),
                            trailing: SizedBox(
                              child: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          loadData();
                                        });
                                        dbHelper!.update(
                                          NoteModel(
                                            id: data.id,
                                            title: 'new title',
                                            age: 11,
                                            description: 'new description',
                                            email: 'new email',
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            content: Text('Updated'),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          dbHelper!.delete(data.id!.toInt());
                                          loadData();
                                          snapshot.data!.remove(data);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            content: Text('Deleted'),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBarModalBottomSheet(
              context: context,
              builder: (context) => SizedBox(
                height: 500,
                child: SafeArea(
                  child: Scaffold(
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Add Notes',
                                textScaleFactor: 2,
                                style: TextStyle(
                                  color: themeColor.primaryColor,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3,
                                      color: Colors.grey,
                                      offset: Offset(2, 2),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: themeColor.primaryColor,
                                      ),
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: themeColor.primaryColor,
                                      ),
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  controller: discriptionController,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: themeColor.primaryColor,
                                      ),
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: ageController,
                                  decoration: InputDecoration(
                                    labelText: 'Age',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: themeColor.primaryColor,
                                      ),
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      loadData();
                                    });
                                    dbHelper!
                                        .insert(
                                          NoteModel(
                                            title: nameController.text,
                                            age: 0,
                                            description: '',
                                            email: emailController.text.trim(),
                                          ),
                                        )
                                        .then((value) => print('Data added'))
                                        .onError(
                                          (error, stackTrace) =>
                                              print(error.toString()),
                                        );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        content: Text('Added'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    clearText();
                                  },
                                  child: Text('Add'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
