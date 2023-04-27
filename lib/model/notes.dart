// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteModel {
  final int? id;
  final String name;
  final int age;
  final String description;
  final String email;
  final String address;
  NoteModel({
    this.id,
    required this.name,
    required this.age,
    required this.description,
    required this.email,
    required this.address,
  });

  NoteModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        age = res['age'],
        description = res['description'],
        email = res['email'],
        address = res['address'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'description': description,
      'email': email,
      'address': address
    };
  }
}
