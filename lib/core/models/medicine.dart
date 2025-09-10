class Medicine {
  final int? id; // nullable for new medicines
  final String brandNameEn;
  final String genericNameEn;
  final String brandNameBn;
  final String genericNameBn;
  final String barcode;
  final String strength;
  final List<String> alternatives;

  Medicine({
    this.id,
    required this.brandNameEn,
    required this.genericNameEn,
    required this.brandNameBn,
    required this.genericNameBn,
    required this.barcode,
    required this.strength,
    required this.alternatives,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] as int?,
      brandNameEn: json['brand_name_en'] ?? '',
      genericNameEn: json['generic_name_en'] ?? '',
      brandNameBn: json['brand_name_bn'] ?? '',
      genericNameBn: json['generic_name_bn'] ?? '',
      barcode: json['barcode'] ?? '',
      strength: json['strength'] ?? '',
      alternatives: (json['alternatives'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'brand_name_en': brandNameEn,
      'generic_name_en': genericNameEn,
      'brand_name_bn': brandNameBn,
      'generic_name_bn': genericNameBn,
      'barcode': barcode,
      'strength': strength,
      'alternatives': alternatives,
    };
  }
}
