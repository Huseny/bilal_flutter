import 'package:flutter/material.dart';

class TableDataSource extends DataTableSource {
  List<dynamic> data;
  TableDataSource({required this.data});

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= data.length) return null;
    final singleData = data[index];
    return DataRow.byIndex(
        index: index,
        selected: singleData.selected,
        onSelectChanged: (value) {
          if (singleData.selected != value) {
            _selectedCount += value! ? 1 : -1;
            assert(_selectedCount >= 0);
            singleData.selected = value;
            notifyListeners();
          }
        },
        cells: singleData.getCells());
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => _selectedCount;

  void updateSelectedData(RestorableTableSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < data.length; i += 1) {
      var singleData = data[i];
      if (selectedRows.isSelected(i)) {
        singleData.selected = true;
        _selectedCount += 1;
      } else {
        singleData.selected = false;
      }
    }
    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(dynamic d) getField, bool ascending) {
    data.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  void updateData(List<dynamic> newData) {
    data = newData;
    notifyListeners();
  }

  void selectAll(bool? checked) {
    for (final singleData in data) {
      if (checked == null || checked == false) {
        singleData.selected = false;
      } else {
        singleData.selected = true;
      }
    }
    if (checked == null || checked == false) {
      _selectedCount = 0;
    } else {
      _selectedCount = data.length;
    }
    notifyListeners();
  }
}

class RestorableTableSelections extends RestorableProperty<Set<int>> {
  Set<int> _tableSelection = {};

  bool isSelected(int index) => _tableSelection.contains(index);

  void setSingleDataSelections(List<dynamic> data) {
    final updatedSet = <int>{};
    for (var i = 0; i < data.length; i += 1) {
      var singleData = data[i];
      if (singleData.selected) {
        updatedSet.add(i);
      }
    }
    _tableSelection = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _tableSelection;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _tableSelection = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _tableSelection;
  }

  @override
  void initWithValue(Set<int> value) {
    _tableSelection = value;
  }

  @override
  List toPrimitives() => _tableSelection.toList();
}
