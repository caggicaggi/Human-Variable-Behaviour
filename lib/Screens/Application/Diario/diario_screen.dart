import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:human_variable_behaviour/Screens/Application/Diario/components/MyEvents.dart';
import 'package:mysql1/src/single_connection.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:human_variable_behaviour/mysql/mysql.dart';
import '../../../mysql/mysql.dart';

class Calendario {}

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({Key? key}) : super(key: key);

  @override
  _CustomTableCalendarState createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  final titleController = TextEditingController();
  final descpController = TextEditingController();

  late Map<DateTime, List<MyEvents>> mySelectedEvents;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Qui puoi raccontare la tua giornata'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // titolo della giornata
                  buildTextFieldTitolo(
                      controller: titleController,
                      hint: 'Che titolo daresti alla giornata?'),
                  const SizedBox(
                    height: 30.0,
                  ),
                  buildTextFieldGiornata(
                      controller: descpController,
                      hint: 'Cosa è successo oggi?'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Torna indietro'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isEmpty &&
                        descpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Non hai inserito nulla, riprova'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      Navigator.pop(context);
                      return;
                    } else {
                      setState(() {
                        if (mySelectedEvents[selectedCalendarDate] != null) {
                          mySelectedEvents[selectedCalendarDate]?.add(MyEvents(
                              eventTitle: titleController.text,
                              eventDescp: descpController.text));
                        } else {
                          mySelectedEvents[selectedCalendarDate!] = [
                            MyEvents(
                                eventTitle: titleController.text,
                                eventDescp: descpController.text)
                          ];
                        }
                      });
                      MyEvents(
                          eventTitle: titleController.text,
                          eventDescp: descpController.text);
                      signDataAndGiornata(idUtente, selectedCalendarDate,
                          titleController.text, descpController.text);
                      titleController.clear();
                      descpController.clear();
                      Navigator.pop(context);
                      return;
                    }
                  },
                  child: const Text('Aggiungi'),
                ),
              ],
            ));
  }

  Widget buildTextFieldTitolo(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      maxLength: 30,
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        //contentPadding: EdgeInsets.symmetric(vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldGiornata(
      {String? hint, required TextEditingController controller}) {
    return Container(
        //margin: EdgeInsets.only(top: 0),
        child: TextField(
      maxLength: 550,
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        //contentPadding: EdgeInsets.symmetric(vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var AppColors;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Il tuo calendario'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Inserisci la tua giornata'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide(color: Colors.blue, width: 2.0),
              ),
              child: TableCalendar(
                focusedDay: _focusedCalendarDate,
                // today's date
                firstDay: _initialCalendarDate,
                // earliest possible date
                lastDay: _lastCalendarDate,
                // latest allowed date
                calendarFormat: CalendarFormat.month,
                // default view when displayed
                // default is Saturday & Sunday but can be set to any day.
                // instead of day number can be mentioned as well.
                weekendDays: const [DateTime.sunday, 6],
                // default is Sunday but can be changed according to locale
                startingDayOfWeek: StartingDayOfWeek.monday,
                // height between the day row and 1st date row, default is 16.0
                daysOfWeekHeight: 40.0,
                // height between the date rows, default is 52.0
                rowHeight: 60.0,
                // this property needs to be added if we want to show events
                eventLoader: _listOfDayEvents,
                // Calendar Header Styling
                headerStyle: HeaderStyle(
                  titleTextStyle:
                      TextStyle(color: Colors.black, fontSize: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  formatButtonTextStyle:
                      TextStyle(color: Colors.black, fontSize: 16.0),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
                // Calendar Days Styling
                daysOfWeekStyle: DaysOfWeekStyle(
                  // Weekend days color (Sat,Sun)
                  weekendStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                // Calendar Dates styling
                calendarStyle: CalendarStyle(
                  // Weekend dates color (Sat & Sun Column)
                  weekendTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                  // highlighted color for today
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  // highlighted color for selected day
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
                selectedDayPredicate: (currentSelectedDate) {
                  listaGiornateInserite(_focusedCalendarDate, idUtente);
                  print("Lista:");
                  print(list);
                  /*********************************** */
                  // QUI BISOGNEREBBE STAMPARE LA LISTA
                  /*********************************** */
                  // as per the documentation 'selectedDayPredicate' needs to determine
                  // current selected day
                  return (isSameDay(
                      selectedCalendarDate!, currentSelectedDate));
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // as per the documentation
                  if (!isSameDay(selectedCalendarDate, selectedDay)) {
                    setState(() {
                      selectedCalendarDate = selectedDay;
                      _focusedCalendarDate = focusedDay;
                    });
                  }
                  //necessario per non inserire ripetizioni nella lista
                  list.clear();
                },
              ),
            ),
            ..._listOfDayEvents(selectedCalendarDate!).map(
              (list) => ListTile(
                leading: Icon(
                  Icons.done,
                  color: Colors.blue,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                      'Questo è il titolo della giornata:${list.eventTitle}'),
                ),
                subtitle: Text('Descrizione Giornata:${list.eventDescp}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
