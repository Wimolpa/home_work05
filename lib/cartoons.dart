class cartoon {
  final String name;
  final String image;
  final String? type;
  final String status;
  final String species;
  final String gender;

  cartoon({
  //required this.title,
  required this.name,
    required this.image,
    required this.type,
    required this.status,
    required this.species,
    required this.gender,
  });

  factory cartoon.fromJson(Map<String, dynamic> json) {
      return cartoon(
      name: json['name'],
      image: json['image'],
      type: json['type'],
      status: json['status'],
      species:json['species'],
      gender:json['gender'],
      
    );
    
  }
}
