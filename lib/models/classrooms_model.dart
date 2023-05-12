class ClassroomLangModel{
  String id;
  List<ClassroomModel> classrooms;
  String name;

  ClassroomLangModel({required this.id,required this.name,required this.classrooms});


  

}


class ClassroomModel {
  int id;
  String name;

  ClassroomModel({
    required this.id,
    required this.name,
  });


  static List<ClassroomLangModel> allClassrooms = [
    ClassroomLangModel(id: "ar", name: "احياء", classrooms: classroomsAR),
    ClassroomLangModel(id: "en", name: "Biology", classrooms: classroomsEN),
  ];

  static List<ClassroomModel> classroomsAR = [
    ClassroomModel(
      id: 1,
      name: "الصف الاول الثانوي",
      
    ),
    ClassroomModel(
      id: 2,
      name: "الصف الثاني الثانوي",
      
    ),
    ClassroomModel(
      id: 3,
      name: "الصف الثالث الثانوي",
      
    ),
  ];

  static List<ClassroomModel> classroomsEN = [
    ClassroomModel(
      id: 1,
      name: "الصف الاول الثانوي",
      
    ),
    ClassroomModel(
      id: 2,
      name: "الصف الثاني الثانوي",
     
    ),
    ClassroomModel(
      id: 3,
      name: "الصف الثالث الثانوي",
      
    ),
  ];

}
