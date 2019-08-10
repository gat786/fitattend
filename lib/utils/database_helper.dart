import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Student{
  String name;
  String startDate;
  String courseName;

  Student({this.name,this.startDate,this.courseName});

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

class Attendance{
  String id;
  String date;
  String timing;

  Attendance({this.id,this.date,this.timing});

  Map<String,String> toMap(){
    return {
      "id":id,
      "date":date,
      "timing":timing
    };
  }

  String toString(){
    return "$id $date $timing";
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
      },
      version: 1,
    );

    return database;
  }

  addStudent(Student student)async{
    final Database db = await openDB();
    
    await db.insert('students', student.toMap());
  }

  getStudents() async {
    final Database db = await openDB();

    var results = await db.query('students');

    return results;
  }

  addFees(Fees fees) async {
    final Database db = await openDB();

    await db.insert('fees', fees.toMap());
  }

  getFees()async{
    final Database db = await openDB();

    var results = await db.query('fees');

    return results;
  }
}