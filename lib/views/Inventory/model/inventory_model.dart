class InventoryModel {
  String activeIngredient;
  String barcode;
  String company;
  String name;

  InventoryModel(
      {this.activeIngredient, this.barcode, this.company, this.name});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    activeIngredient = json['activeIngredient'];
    barcode = json['barcode'];
    company = json['company'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeIngredient'] = this.activeIngredient;
    data['barcode'] = this.barcode;
    data['company'] = this.company;
    data['name'] = this.name;
    return data;
  }
}
