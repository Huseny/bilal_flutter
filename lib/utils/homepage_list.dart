import 'package:bilal/routes/route_constants.dart';
import 'package:flutter/material.dart';

class HomepagesList {
  static List<List> getList(String role) {
    return [
      ["إدارة الوالدين", const Icon(Icons.person), RoutesConst.manageParents],
      [
        "إدارة الطلاب",
        const Icon(Icons.cast_for_education),
        RoutesConst.manageStudents
      ],
      [
        "إدارة المعلمين",
        const Icon(Icons.person_2),
        RoutesConst.manageTeachers
      ],
      [
        "إدارة الفصول الدراسية",
        const Icon(Icons.class_),
        RoutesConst.manageSections
      ],
      [
        "إدارة الجدول الأكاديمي",
        const Icon(Icons.schedule),
        RoutesConst.manageSemesters
      ],
      [
        "إدارة التقييمات",
        const Icon(Icons.grade),
        RoutesConst.manageEvaluations
      ],
      ["التقارير", const Icon(Icons.report), RoutesConst.seeReport]
    ];
  }
}
