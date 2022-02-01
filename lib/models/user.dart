import 'dart:convert';
import 'dart:ffi';

class User {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String role;
  final DateTime created_at;
  final bool confirmed;
  User({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.role,
    required this.created_at,
    required this.confirmed,
  });

  User copyWith({
    int? id,
    String? email,
    String? first_name,
    String? last_name,
    String? role,
    DateTime? created_at,
    bool? confirmed,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      role: role ?? this.role,
      created_at: created_at ?? this.created_at,
      confirmed: confirmed ?? this.confirmed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'role': role,
      'created_at': created_at.millisecondsSinceEpoch,
      'confirmed': confirmed,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      first_name: map['first_name'] ?? '',
      last_name: map['last_name'] ?? '',
      role: map['role'] ?? '',
      created_at: DateTime.parse(map['created_at']),
      confirmed: map['confirmed'] == 'true' ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, email: $email, first_name: $first_name, last_name: $last_name, role: $role, created_at: $created_at, confirmed: $confirmed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.email == email &&
      other.first_name == first_name &&
      other.last_name == last_name &&
      other.role == role &&
      other.created_at == created_at &&
      other.confirmed == confirmed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      role.hashCode ^
      created_at.hashCode ^
      confirmed.hashCode;
  }
}
