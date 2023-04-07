import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    print('home build-----------------');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('SQFLite Crud')),
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
                          child: ListTile(
                            leading: Text(data.id.toString()),
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
            setState(() {
              loadData();
            });
            dbHelper!
                .insert(
                  NoteModel(
                    title: 'Mizan',
                    age: 28,
                    description: 'This is description',
                    email: 'mizan@g.com',
                  ),
                )
                .then((value) => print('Data added'))
                .onError(
                  (error, stackTrace) => print(error.toString()),
                );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                content: Text('Added'),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
