import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Student{
  String id;
  String name;
  String startDate;
  String courseName;

  Student({this.name,this.startDate,this.courseName,this.id});

  Map<String,String> toMap(){
    return {
      "name":name,
      "startDate":startDate,
      "courseName":courseName
    };
  }

  String toString(){
    return "$name $startDate $courseName";
  }
}

class EventData{
  DateTime date;
  String timing;

  EventData({this.date,this.timing});

  Map<String,String> toMap(){
    return {
      "date":date.toString(),
      "timing":timing
    };
  }

  String toString(){
    return "$date $timing";
  }
}

class Attendance{
  String id;
  String studentId;
  String date;
  String timing;

  Attendance({this.id,this.studentId,this.date,this.timing});

  Map<String,String> toMap(){
    return {
      "id":id,
      "studentId":studentId,
      "date":date,
      "timing":timing
    };
  }

  String toString(){
    return "$id $studentId $date $timing";
  }
}

class Fees{
  String studentId;
  String amount;
  String forMonths;
  String timestamp;

  Fees({this.studentId,this.amount,this.forMonths,this.timestamp});

  Map<String,String> toMap(){
    return {
      "studentId":studentId,
      "amount":amount,
      "forMonths":forMonths,
      "timestamp":timestamp
    };
  }

  String toString(){
    return "$studentId $amount $forMonths $timestamp";
  }
}



class DatabaseHelper{

  Future<Database> openDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(),'fitattend.db'),
      onCreate: (db,version){
        db.execute("CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT, courseName TEXT, startDate NUMERIC);");
        db.execute("CREATE TABLE attendance(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "studentId INTEGER, date NUMERIC , timing TEXT);");
        db.execute("CREATE TABLE fees(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "studentId INTEGER, amount INTEGER , forMonths INTEGER, timestamp TEXT);");
        db.execute("CREATE VIEW feesrecieved  AS SELECT f.studentId , f.amount , f.timestamp , f.forMonths , "
            "s.name FROM students AS s , fees AS f WHERE f.studentId = s.id");
        db.execute("CREATE VIEW attendancedetailed  AS SELECT a.studentId , a.date , a.timing, "
            "s.name FROM students AS s , attendance AS a WHERE a.studentId = s.id");
      },
      version: 1,
    );

    return database;
  }

  addStudent(Student student)async{
    final Database db = await openDB();
    
    return await db.insert('students', student.toMap());
  }

  getStudents() async {
    final Database db = await openDB();

    var results = await db.query('students');

    return results;
  }

  addFees(Fees fees) async {
    final Database db = await openDB();

    return await db.insert('fees', fees.toMap());
  }

  getFees()async{
    final Database db = await openDB();

    var results = await db.query('fees');

    return results;
  }

  getFeesRecieved()async{
    final Database db = await openDB();

    var results = await db.query('feesrecieved');

    return results;
  }

  Future<List<Student>> getStudentsStructured() async {
    List<Student> students = new List<Student>();
    var result = await getStudents();
    for(var item in result){
      Student student = Student(
        id: item["id"].toString(),
        name: item["name"],
        startDate: item["startDate"],
        courseName: item["courseName"]);
      students.add(student);
    }
    return students;
  }

  addAttendance(Attendance attendance)async {
    var db = await openDB();
    return db.insert('attendance', attendance.toMap());
  }

  getAttendance(studentId)async{
    var db = await openDB();
    var results = db.query('attendance',where: "studentId = $studentId");
    return results;
  }

  getAttendanceDetailed([studentId])async{
    var db = await openDB();
    var results = (studentId!=null)?db.query('attendancedetailed',having: "studentID = $studentId"):db.query('attendancedetailed');
    return results;
  }
}