class Objeto {
  final String? id;
  final String name;
  final int year;
  final double price;
  final String cpuModel;
  final String hardDiskSize;
  final String? color;

  Objeto({
    this.id,
    required this.name,
    required this.year,
    required this.price,
    required this.cpuModel,
    required this.hardDiskSize,
    this.color,
  });

  factory Objeto.fromJson(Map<String, dynamic> json) {
    return Objeto(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      year:
          json['year'] != null ? int.tryParse(json['year'].toString()) ?? 0 : 0,
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      cpuModel: json['cpuModel'] ?? '',
      hardDiskSize: json['hardDiskSize'] ?? '',
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'data': {
        'year': year,
        'price': price,
        'CPU model': cpuModel,
        'Hard disk size': hardDiskSize,
        if (color != null) 'color': color,
      },
    };
  }
}
