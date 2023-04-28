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
  DatabaseProvider? dbHelper;

  Future<List<NoteModel>> loadData() async {
    return await dbHelper!.getNoteList();
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseProvider();
    loadData();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void clearText() {
    nameController.clear();
    emailController.clear();
    ageController.clear();
    discriptionController.clear();
    addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    print('build------------------------------------------------------------');
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
                    return GridView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width < 400 ? 2 : 4,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data![index];
                        return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(data.id.toString()),
                                      Text(data.name),
                                      Text(data.email),
                                      Text(data.description, maxLines: 3),
                                      Text(data.address),
                                      Text(data.age.toString()),
                                    ],
                                  ),
                                  Container(
                                    color: themeColor.focusColor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              loadData();
                                            });

                                            showBarModalBottomSheet(
                                              context: context,
                                              builder: (context) => SizedBox(
                                                height: 500,
                                                child: SafeArea(
                                                  child: Scaffold(
                                                    body: SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                                height: 20),
                                                            Text(
                                                              'Update Notes',
                                                              textScaleFactor:
                                                                  2,
                                                              style: TextStyle(
                                                                shadows: [
                                                                  Shadow(
                                                                    blurRadius:
                                                                        3,
                                                                    color: Colors
                                                                        .grey,
                                                                    offset:
                                                                        Offset(
                                                                            2,
                                                                            2),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    nameController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Name',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: themeColor
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                  filled: true,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    emailController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Email',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: themeColor
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                  filled: true,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    discriptionController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Description',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: themeColor
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                  filled: true,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    addressController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Address',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: themeColor
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                  filled: true,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8),
                                                              child:
                                                                  TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                controller:
                                                                    ageController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Age',
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: themeColor
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                  filled: true,
                                                                ),
                                                              ),
                                                            ),
                                                            Center(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    loadData();
                                                                  });
                                                                  dbHelper!
                                                                      .update(
                                                                    NoteModel(
                                                                      id: data
                                                                          .id,
                                                                      name: nameController
                                                                          .text,
                                                                      age: int.parse(
                                                                          ageController
                                                                              .text),
                                                                      description:
                                                                          discriptionController
                                                                              .text,
                                                                      email: emailController
                                                                          .text,
                                                                      address:
                                                                          addressController
                                                                              .text,
                                                                    ),
                                                                  );
                                                                  clearText();
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      backgroundColor:
                                                                          Theme.of(context)
                                                                              .primaryColor,
                                                                      content: Text(
                                                                          'Updated'),
                                                                    ),
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'Update'),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              dbHelper!
                                                  .delete(data.id!.toInt());
                                              loadData();
                                              snapshot.data!.remove(data);
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                content: Text('Deleted'),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Add Notes',
                              textScaleFactor: 2,
                              style: TextStyle(
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
                                  labelText: 'name',
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
                                controller: addressController,
                                decoration: InputDecoration(
                                  labelText: 'Address',
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
                                          name: nameController.text,
                                          age: int.parse(ageController.text),
                                          description:
                                              discriptionController.text,
                                          email: emailController.text.trim(),
                                          address: addressController.text,
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
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
