class Metadata {
  final String itemName;
  final String itemId;
  final String itemDescription;
  final String itemSubCategory;
  final int itemTheOrder;

  Metadata({
    required this.itemName,
    required this.itemId,
    required this.itemDescription,
    required this.itemSubCategory,
    required this.itemTheOrder
  });

  factory Metadata.fromJson(json) {
    return Metadata(
      itemName: json['field_name'] ?? '',
      itemId: json['item_id'] ?? '',
      itemTheOrder: json['the_order'] ?? '',
      itemDescription: json['item_description'] ?? '',
      itemSubCategory: json['item_sub_category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field_name': itemName,
      'item_id': itemId,
      'item_description': itemDescription,
      'item_sub_category': itemSubCategory,
      'the_order': itemTheOrder
    };
  }
}
