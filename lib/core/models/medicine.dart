class Medicine {
  final int id;
  final String brandNameEn;
  final String genericNameEn;
  final String brandNameBn;
  final String genericNameBn;
  final String barcode;
  final String strength;
  final List<String> alternatives;

  Medicine({
    required this.id,
    required this.brandNameEn,
    required this.genericNameEn,
    required this.brandNameBn,
    required this.genericNameBn,
    required this.barcode,
    required this.strength,
    required this.alternatives,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json['id'],
        brandNameEn: json['brandNameEn'],
        genericNameEn: json['genericNameEn'],
        brandNameBn: json['brandNameBn'],
        genericNameBn: json['genericNameBn'],
        barcode: json['barcode'],
        strength: json['strength'],
        alternatives: List<String>.from(json['alternatives'] ?? []),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'brandNameEn': brandNameEn,
        'genericNameEn': genericNameEn,
        'brandNameBn': brandNameBn,
        'genericNameBn': genericNameBn,
        'barcode': barcode,
        'strength': strength,
        'alternatives': alternatives,
      };
}
