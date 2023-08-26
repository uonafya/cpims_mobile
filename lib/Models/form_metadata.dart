class Metadata {
  final String itemName;
  final String itemId;
  final String itemDescription;
  final String itemSubCategory;

  Metadata({
    required this.itemName,
    required this.itemId,
    required this.itemDescription,
    required this.itemSubCategory,
  });

  factory Metadata.fromJson(json) {
    return Metadata(
      itemName: json['field_name'] ?? '',
      itemId: json['item_id'] ?? '',
      itemDescription: json['item_description'] ?? '',
      itemSubCategory: json['item_sub_category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'field_name': itemName,
      'item_id': itemId,
      'item_description': itemDescription,
      'item_sub_category': itemSubCategory,
    };
  }
}
