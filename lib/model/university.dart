class University {
  final String college;
  final String district;

  University({required this.college, required this.district});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(       
      college: json['college'],
      district: json['district'],
    );
  }
}
