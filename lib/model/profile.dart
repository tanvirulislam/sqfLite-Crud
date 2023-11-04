// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileModel {
  final int? id;
  final String name;
  final int age;
  final String description;
  final String email;
  final String address;
  ProfileModel({
    this.id,
    required this.name,
    required this.age,
    required this.description,
    required this.email,
    required this.address,
  });

  // We need a method to convert this 'model' into a 'Map',
  // so that we can insert it into a database

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'age': age,
        'description': description,
        'email': email,
        'address': address
      };

  // Whrn we retrive the data from database it will be a 'Map',
  // So we need to convert it back

  factory ProfileModel.fromMap(Map<String, dynamic> value) => ProfileModel(
        id: value['id'],
        name: value['name'],
        age: value['age'],
        description: value['description'],
        email: value['email'],
        address: value['address'],
      );

  // ProfileModel.fromMap(Map<String, dynamic> res)
  //     : id = res['id'],
  //       name = res['name'],
  //       age = res['age'],
  //       description = res['description'],
  //       email = res['email'],
  //       address = res['address'];
}
