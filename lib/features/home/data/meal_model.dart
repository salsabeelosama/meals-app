class MealModel {
  final String name;
  final String imageUrl;
  final String description;
  final double calories;
  final String time;
  final double rate;

  MealModel({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.calories,
    required this.time,
    required this.rate,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'calories' : calories,
      'time': time,
      'rate': rate,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      name: map['name'],
      imageUrl: map['imageUrl'],
      calories: map['calories'],
      description: map['description'],
      time: map['time'],
      rate: map['rate'],
    );
  }
}
