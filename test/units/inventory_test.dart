import 'package:flutter_test/flutter_test.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:medication_app_v0/views/Inventory/viewmodel/inventory_viewmodel.dart';

void main() {
  test("inventory sort test", () {
    InventoryModel i1 = InventoryModel(
        activeIngredient: 'ac1',
        name: 'cname1',
        company: "co",
        barcode: "1",
        expiredDate: DateTime(2004));
    InventoryModel i2 = InventoryModel(
        activeIngredient: 'ac2',
        name: 'dname2',
        company: "co",
        barcode: "12",
        expiredDate: DateTime(2001));
    InventoryModel i3 = InventoryModel(
        activeIngredient: 'ac3',
        name: 'bname3',
        company: "co",
        barcode: "13",
        expiredDate: DateTime(2003));
    InventoryModel i4 = InventoryModel(
        activeIngredient: 'ac4',
        name: 'aname4',
        company: "co",
        barcode: "14",
        expiredDate: DateTime(2002));
    List<InventoryModel> temp = [];
    InventoryViewModel ivm = InventoryViewModel();
    temp.add(i1);
    temp.add(i2);
    temp.add(i3);
    temp.add(i4);
    ivm.medicationList = temp;
    ivm.sortMedList();
    var expected = [i2, i4, i3, i1];
    expect(ivm.medicationList, expected);
  });
}
