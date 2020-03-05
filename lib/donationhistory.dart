import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:moneydonation/sign_in.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'first_screen.dart';

class ListDataPage extends StatefulWidget {
  @override
  _StateListData createState() => _StateListData();
}

class _StateListData extends State<ListDataPage> {
  List<Stud> litems;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    _getDateList();
    //_getDateList();
  }

  @override
  void initState() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    super.initState();
    litems = List();
    FirebaseDatabase.instance
        .reference()
        .child(name)
        .child(formattedDate)
        .once()
        .then((DataSnapshot dataSnapshot) async {
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        values.forEach((key, values) {
          String name = values["Name of Donor"];
          String amount = values["Amount donated"].toString();
          String year = values["Year"];
          String division = values["Division"].toString();
          setState(() {
            litems.add(new Stud(name, amount, year, division));
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(
              icon: new Icon(FontAwesomeIcons.signOutAlt),
              onPressed: () => Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator
                      .defaultRouteName)) //() => Navigator.of(context).pop(null),
              ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        /*
        title: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          icon: Icon(Icons.date_range, color: Colors.blue),        
         label: Text('Select Date', style: TextStyle(color: Colors.blue)),
         onPressed: () => _selectDate(context),
        ),
        */
        
        title: Container(
          alignment: Alignment.topLeft,
          child: OutlineButton(
            onPressed: () => _selectDate(context),
            child: Text('Select Date', style: TextStyle(fontSize: 15),),
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.blue),
            splashColor: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: _getList(context)// _getDateList(context),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.edit), title: new Text("Form")),
          new BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.rupeeSign),
              title: new Text("Donations")),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FirstScreen()));
    }
  }
  void _getDateList() async {
    var formatter = new DateFormat('dd-MM-yyyy');
    String seldate = formatter.format(selectedDate);
    litems.clear();
    litems = List();
    FirebaseDatabase.instance
        .reference()
        .child(name)
        .child(seldate)
        .once()
        .then((DataSnapshot dataSnapshot) async {
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        values.forEach((key, values) {
          String name = values["Name of Donor"];
          String amount = values["Amount donated"].toString();
          String year = values["Year"];
          String division = values["Division"].toString();
          setState(() {
            litems.add(new Stud(name, amount, year, division));
          });
        });
      }
    });
  }
  Widget _getList(context) {
    return ListView.builder(
        itemCount: litems.length,
        itemBuilder: (context, pos) {
          return Dismissible(
            key: Key(litems[pos].amt),
            onDismissed: (direction) {
              litems.removeAt(pos);
            },
            child: Card(
              child: ListTile(
                leading: Text(litems[pos].yr + "-" + litems[pos].div,
                    style: TextStyle(fontSize: 15)),
                trailing: Text(
                  "₹" + litems[pos].amt,
                  style: TextStyle(fontSize: 15),
                ),
                title: Text(litems[pos].name, style: TextStyle(fontSize: 15)),
              ),
            ),
          );
        });
  }
}

class Stud {
  String name;
  String amt;
  String yr;
  String div;
  Stud(String name, String amt, String yr, String div) {
    this.name = name;
    this.amt = amt;
    this.yr = yr;
    this.div = div;
  }
}
