import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/components/cards/pill_card.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';

class CalendarView extends StatefulWidget {
  CalendarView({Key key}) : super(key: key);
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView>
    with TickerProviderStateMixin {
  Map<DateTime, List<ReminderModel>> _events;
  List<ReminderModel> _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        ReminderModel("Teraflu",
            _selectedDay.subtract(Duration(days: 30, hours: 4)), 25, true),
        ReminderModel("Calpol",
            _selectedDay.subtract(Duration(days: 30, hours: 1)), 25, false),
      ],
      _selectedDay.subtract(Duration(days: 27)): [
        ReminderModel("Teraflu",
            _selectedDay.subtract(Duration(days: 27, hours: 2)), 35, true),
      ],
      _selectedDay.subtract(Duration(days: 20)): [
        ReminderModel("Teraflu",
            _selectedDay.subtract(Duration(days: 20, hours: 3)), 40, false),
        ReminderModel("Calpol",
            _selectedDay.subtract(Duration(days: 20, hours: 2)), 25, false),
        ReminderModel("Jolessa",
            _selectedDay.subtract(Duration(days: 20, hours: 1)), 25, true),
        ReminderModel(
            "Paromymcin", _selectedDay.subtract(Duration(days: 20)), 25, true),
      ],
      _selectedDay.subtract(Duration(days: 16)): [
        ReminderModel("Calpol",
            _selectedDay.subtract(Duration(days: 16, hours: 4)), 25, false),
        ReminderModel("Jolessa",
            _selectedDay.subtract(Duration(days: 16, hours: 3)), 25, false),
      ],
      _selectedDay.subtract(Duration(days: 10)): [
        ReminderModel("Calpol",
            _selectedDay.subtract(Duration(days: 10, hours: 2)), 25, true),
        ReminderModel("Jolessa",
            _selectedDay.subtract(Duration(days: 10, hours: 1)), 25, true),
        ReminderModel(
            "Paromymcin", _selectedDay.subtract(Duration(days: 10)), 25, true),
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        ReminderModel("Teraflu",
            _selectedDay.subtract(Duration(days: 4, hours: 4)), 25, true),
        ReminderModel("Calpol",
            _selectedDay.subtract(Duration(days: 4, hours: 3)), 25, false),
        ReminderModel("Jolessa",
            _selectedDay.subtract(Duration(days: 4, hours: 1)), 25, true),
      ],
      _selectedDay.subtract(Duration(days: 2)): [
        ReminderModel("Jolessa",
            _selectedDay.subtract(Duration(days: 2, hours: 2)), 25, false),
        ReminderModel("Paromymcin",
            _selectedDay.subtract(Duration(days: 2, hours: 5)), 25, true),
      ],
      _selectedDay: [
        ReminderModel(
            "Jolessa", _selectedDay.subtract(Duration(hours: 5)), 25, true),
        ReminderModel(
            "Paromymcin", _selectedDay.subtract(Duration(hours: 4)), 25, true),
        ReminderModel(
            "Jolessa", _selectedDay.subtract(Duration(hours: 2)), 25, true),
        ReminderModel("Paromymcin", _selectedDay, 25, true),
      ],
      _selectedDay.add(Duration(days: 7)): [
        ReminderModel(
            "Jolessa", _selectedDay.add(Duration(days: 7, hours: 1)), 25, true),
        ReminderModel("Paromymcin",
            _selectedDay.add(Duration(days: 7, hours: 2)), 25, true),
        ReminderModel(
            "Teraflu", _selectedDay.add(Duration(days: 7, hours: 3)), 25, true),
        ReminderModel(
            "Calpol", _selectedDay.add(Duration(days: 7, hours: 4)), 25, false),
        ReminderModel(
            "Jolessa", _selectedDay.add(Duration(days: 7, hours: 5)), 25, true),
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events.cast<ReminderModel>();
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    _calendarController.setSelectedDay(first);
    setState(() {
      _selectedEvents = _events[first] ?? [];
    });
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(context),
          Divider(
            thickness: 2,
          ),
          Expanded(
              child: Padding(
            padding: context.paddingNormal,
            child: _selectedEvents.isEmpty ? SizedBox() : _buildEventList(),
          )),
        ],
      ),
    );
  }

  // Belki başka bir yerede konulabilir
  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }

  // Başka sayfalarda da kullanılacak mı ?
  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              iconSize: context.height * 0.05,
              icon: Icon(Icons.home_outlined),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.medical_services_outlined),
              onPressed: () {},
              iconSize: context.height * 0.05),
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {},
              iconSize: context.height * 0.05),
          IconButton(
              icon: Icon(Icons.bookmark_outline),
              onPressed: () {},
              iconSize: context.height * 0.05)
        ],
      ),
    );
  }

  Widget _buildTableCalendar(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      rowHeight: context.height * 0.1, //headerin size'ını ayarlamak lazım.
      //locale: context.locale.toString(), tr sürümü yok.
      availableGestures: AvailableGestures.horizontalSwipe,
      startingDayOfWeek: StartingDayOfWeek.monday,
      initialCalendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
        selectedColor: ColorTheme.PRIMARY_BLUE,
        todayColor: Colors.green.shade100,
        markersColor: ColorTheme.GREY_HUNTER,
        weekdayStyle: context.textTheme.headline6,
        weekendStyle:
            context.textTheme.headline6.copyWith(color: Colors.black45),
        //outsideStyle:
        //    context.textTheme.headline6.copyWith(color: Colors.red.shade200),
        outsideDaysVisible: false,
        markersPositionBottom: 0,
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
      headerStyle: HeaderStyle(
        titleTextStyle: context.textTheme.headline6,
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: context.textTheme.headline6,
          weekendStyle:
              context.textTheme.headline6.copyWith(color: Colors.black45)),
    );
  }

  Widget _buildEventList() {
    _selectedEvents.sort((a, b) => a.time.compareTo(b.time));
    return ListView.builder(
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) => PillCard(
              reminder: _selectedEvents[index],
            ));
  }
}
