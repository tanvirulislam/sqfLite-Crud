// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteModel {
  final int? id;
  final String title;
  final int age;
  final String description;
  final String email;
  NoteModel({
    this.id,
    required this.title,
    required this.age,
    required this.description,
    required this.email,
  });

  NoteModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        age = res['age'],
        description = res['description'],
        email = res['email'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'age': age,
      'description': description,
      'email': email,
    };
  }
}
