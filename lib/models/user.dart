class User {
  final String id;
  final String name;
  final int age;
  final String bio;
  final String location;
  final String gender;
  final List<String> photos;
  final double? distance;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.bio,
    required this.location,
    required this.gender,
    required this.photos,
    this.distance,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      bio: json['bio'],
      location: json['location'],
      gender: json['gender'],
      photos: List<String>.from(json['photos']),
      distance: json['distance']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'bio': bio,
      'location': location,
      'gender': gender,
      'photos': photos,
      'distance': distance,
    };
  }
}
