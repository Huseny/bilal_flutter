import 'package:bilal/bloc/admin_parent/admin_parent_bloc.dart';
import 'package:bilal/presentation/components/admin/see_profile.dart';
import 'package:bilal/presentation/components/admin/table_data_source.dart';
import 'package:bilal/presentation/components/custom_sex_chips.dart';
import 'package:bilal/presentation/components/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ManageParents extends StatefulWidget {
  const ManageParents({super.key});

  @override
  State<ManageParents> createState() => _ManageParentsState();
}

class _ManageParentsState extends State<ManageParents> with RestorationMixin {
  late final TableDataSource _parentDataSource = TableDataSource(data: []);
  final RestorableInt _rowsPerPage =
      RestorableInt(PaginatedDataTable.defaultRowsPerPage);
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableIntN _sortColumnIndex = RestorableIntN(null);
  final RestorableBool _sortAscending = RestorableBool(true);
  final RestorableTableSelections _parentSelections =
      RestorableTableSelections();
  List selectedIndex = [];

  final _formKey = GlobalKey<FormState>();

  void _sort<T>(
    Comparable<T> Function(dynamic d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _parentDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex.value = columnIndex;
      _sortAscending.value = ascending;
    });
  }

  List<DataColumn> getColumns() {
    return [
      DataColumn(
        label: const Text(
          "الاسم الكامل",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onSort: (columnIndex, ascending) =>
            _sort<String>((d) => d.name, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text(
          "اسم المستخدم",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onSort: (columnIndex, ascending) =>
            _sort<String>((d) => d.username, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text(
          "جنس",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onSort: (columnIndex, ascending) =>
            _sort<String>((d) => d.sex, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text(
          "رقم التليفون",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onSort: (columnIndex, ascending) =>
            _sort<String>((d) => d.phone, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text(
          "البريد الإلكتروني",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onSort: (columnIndex, ascending) =>
            _sort<String>((d) => d.email, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text(
          "عنوان",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onSort: (columnIndex, ascending) =>
            _sort<String>((d) => d.address, columnIndex, ascending),
      ),
    ];
  }

  @override
  String? get restorationId => "parents_table";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_parentSelections, 'parents_selected_row_indices');
    registerForRestoration(_rowIndex, 'parents_current_row_index');
    registerForRestoration(_rowsPerPage, 'parents_rows_per_page');
    registerForRestoration(_sortAscending, 'parents_sort_ascending');
    registerForRestoration(_sortColumnIndex, 'parents_sort_column_index');

    switch (_sortColumnIndex.value) {
      case 0:
        _parentDataSource.sort<num>((d) => d.number, _sortAscending.value);
        break;
      case 1:
        _parentDataSource.sort<String>((d) => d.name, _sortAscending.value);
        break;
      case 2:
        _parentDataSource.sort<String>((d) => d.username, _sortAscending.value);
        break;
      case 3:
        _parentDataSource.sort<String>((d) => d.sex, _sortAscending.value);
        break;
      case 4:
        _parentDataSource.sort<String>((d) => d.phone, _sortAscending.value);
        break;
      case 5:
        _parentDataSource.sort<String>((d) => d.email, _sortAscending.value);
        break;
      case 6:
        _parentDataSource.sort<String>((d) => d.address, _sortAscending.value);
        break;
    }
    _parentDataSource.updateSelectedData(_parentSelections);
    _parentDataSource.addListener(_updateSelectedParentRowListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _parentDataSource.addListener(_updateSelectedParentRowListener);
  }

  void _updateSelectedParentRowListener() {
    _parentSelections.setSingleDataSelections(_parentDataSource.data);
    setState(() {
      selectedIndex = _parentSelections.toPrimitives();
    });
  }

  @override
  void dispose() {
    _rowsPerPage.dispose();
    _sortColumnIndex.dispose();
    _sortAscending.dispose();
    _parentDataSource.removeListener(_updateSelectedParentRowListener);
    _parentDataSource.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<AdminParentBloc>(context).add(const GetParents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminParentBloc, AdminParentState>(
      listener: (context, state) {
        if (state is AdminParentsLoaded) {
          _parentDataSource.updateData(state.parents);
        } else if (state is AdminParentsCreated) {
          List<dynamic> data = _parentDataSource.data;
          data.add(state.parent.userInfo);
          _parentDataSource.updateData(data);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AdminParentInitial:
          case AdminParentsLoading:
            return Scaffold(
              appBar: AppBar(
                title: const Text("قائمة أولياء الأمور"),
              ),
              body: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: LinearProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ),
            );

          case AdminParentLoadingFailed:
            return Scaffold(
              appBar: AppBar(
                title: const Text("قائمة أولياء الأمور"),
              ),
              body: const Center(
                  child: Text(
                "حدث خطأ ما، يرجى المحاولة مرة أخرى",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              )),
            );

          case AdminParentsLoaded:
          default:
            return Scaffold(
                appBar: AppBar(
                  title: const Text("قائمة أولياء الأمور"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          showModal(context, state);
                        },
                        icon: const Icon(Icons.add)),
                    if (selectedIndex.length > 1)
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(LineAwesomeIcons.trash))
                    else if (selectedIndex.length == 1)
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: ((BuildContext context, animation,
                                        secondaryAnimation) =>
                                    SeeProfile(fields: {
                                      "اسم": _parentDataSource
                                          .data[selectedIndex[0]].name,
                                      'اسم المستخدم': _parentDataSource
                                          .data[selectedIndex[0]].username,
                                      "الجنس": _parentDataSource
                                          .data[selectedIndex[0]].sex,
                                      "رقم التليفون": _parentDataSource
                                          .data[selectedIndex[0]].phone,
                                      "بريد إلكتروني": _parentDataSource
                                          .data[selectedIndex[0]].email,
                                      "عنوان": _parentDataSource
                                          .data[selectedIndex[0]].address,
                                    }))));
                          },
                          icon: const Icon(LineAwesomeIcons.expand))
                  ],
                ),
                body: Scrollbar(
                    child: ListView(
                        restorationId: 'parents_data_table_list_view',
                        padding: const EdgeInsets.all(16),
                        children: [
                      PaginatedDataTable(
                          rowsPerPage: _rowsPerPage.value,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              _rowsPerPage.value = value!;
                            });
                          },
                          showFirstLastButtons: true,
                          initialFirstRowIndex: _rowIndex.value,
                          onPageChanged: (rowIndex) {
                            setState(() {
                              _rowIndex.value = rowIndex;
                            });
                          },
                          sortColumnIndex: _sortColumnIndex.value,
                          sortAscending: _sortAscending.value,
                          onSelectAll: _parentDataSource.selectAll,
                          columns: getColumns(),
                          source: _parentDataSource)
                    ])));
        }
      },
    );
  }

  Future<dynamic> showModal(BuildContext context, AdminParentState state) {
    String? name;
    String sex = "M";
    String? phone;
    String? email;
    String? address;

    return showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return BlocConsumer<AdminParentBloc, AdminParentState>(
              listener: (context, state) {
            if (state is AdminParentsCreated) {
              showDialog(
                  context: context,
                  builder: ((BuildContext context) => AlertDialog(
                        title: const Text("تم إنشاء ملف تعريف الوالد بنجاح"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              children: [
                                Text("اسم المستخدم: "),
                              ],
                            ),
                            Text(
                              state.parent.user!.email!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Row(
                              children: [
                                Text("كلمة المرور: "),
                              ],
                            ),
                            Text(
                              state.parent.password,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                                GoRouter.of(context).pop();
                              },
                              child: const Text("أغلق"))
                        ],
                      )));
            } else if (state is AdminParentCreationFailed) {
              showDialog(
                  context: context,
                  builder: ((BuildContext context) => AlertDialog(
                        title: const Text("فشل إنشاء ملف تعريف الوالدين"),
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Wrap(
                            clipBehavior: Clip.antiAlias,
                            children: [
                              const Text("سبب: "),
                              Text(
                                state.props[0].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ]),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                            },
                            child: const Text('أغلق'),
                          ),
                        ],
                      )));
            }
          }, builder: (context, state) {
            switch (state.runtimeType) {
              case AdminParentCreationLoading:
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              default:
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: _createParentForm(
                        name, sex, phone, email, address, context),
                  ),
                );
            }
          });
        });
  }

  Form _createParentForm(String? name, String sex, String? phone, String? email,
      String? address, BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              labelText: "الاسم الكامل",
              errorMsg: "اسم غير صالح",
              onSaved: (value) => setState(() {
                name = value!;
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomSexChips(
                onSelected: (value) => setState(() {
                      sex = value == 0 ? "M" : "F";
                    })),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "رقم الهاتف",
              errorMsg: "رقم الهاتف غير صحيح",
              keyboardType: TextInputType.phone,
              onSaved: (value) => setState(() {
                phone = value!;
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "البريد الإلكتروني",
              errorMsg: "البريد الإلكتروني غير صالح",
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => setState(() {
                email = value!;
              }),
              canEmpty: true,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "عنوان",
              errorMsg: "العنوان غير صالح",
              keyboardType: TextInputType.streetAddress,
              onSaved: (value) => setState(() {
                address = value!;
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber)),
                    child: const Text("إلغاء"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          BlocProvider.of<AdminParentBloc>(context).add(
                              CreateParent(
                                  name: name!,
                                  sex: sex,
                                  phone: phone!,
                                  email: email,
                                  address: address!));
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue)),
                      child: const Text("حفظ")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
