import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/pill_card2.dart';
import 'package:medication_app_v0/core/components/widgets/custom_bottom_appbar.dart';
import 'package:medication_app_v0/core/components/widgets/drawer.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/notification/notification_manager.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';
import 'package:medication_app_v0/views/home/viewmodel/home_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        model: HomeViewmodel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        builder: (context, viewmodel) => buildScaffold(viewmodel, context));
  }

  Scaffold buildScaffold(HomeViewmodel viewmodel, BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.home_HOME.locale.toString()),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  viewmodel.logoutIconButtonOnPress();
                })
          ],
        ),
        drawer: CustomDrawer(),
        floatingActionButton: buildFloatingActionButton(viewmodel),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomAppBar(),
        body: Observer(
            builder: (context) => viewmodel.isLoading
                ? PulseLoadingIndicatorWidget()
                : buildCalendarAndEvent(context, viewmodel)));
  }

  FloatingActionButton buildFloatingActionButton(HomeViewmodel viewmodel) {
    return FloatingActionButton(
      onPressed: () {
        viewmodel.navigateAddMedication();
        //viewmodel.scanQR();
      },
      child: Icon(Icons.add),
    );
  }

  Column buildCalendarAndEvent(BuildContext context, viewmodel) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildTableCalendar(context, viewmodel),
        Divider(
          thickness: 2,
        ),
        ElevatedButton(
            onPressed: () {
              ReminderModel reminder = ReminderModel(
                  "Alperen", DateTime.now().add(Duration(minutes: 5)), 2, true);
              NotificationManager.instance
                  .scheduleReminderNotification(reminder);
            },
            child: Text("Notification")),
        Expanded(
            child: Padding(
          padding: context.paddingNormal,
          child: viewmodel.selectedEvents.isEmpty
              ? SizedBox()
              : _buildEventList(viewmodel),
        )),
      ],
    );
  }

  Widget _buildTableCalendar(BuildContext context, HomeViewmodel viewmodel) {
    return TableCalendar(
      calendarController: viewmodel.calendarController,
      events: viewmodel.events,
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
      onDaySelected: viewmodel.onDaySelected,
      onVisibleDaysChanged: viewmodel.onVisibleDaysChanged,
      onCalendarCreated: viewmodel.onCalendarCreated,
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

  Widget _buildEventList(HomeViewmodel viewmodel) {
    bool isDelete = false;
    viewmodel.selectedEvents.sort((a, b) => a.time.compareTo(b.time));
    return Observer(
      builder: (_) => ListView.builder(
          itemCount: viewmodel.selectedEvents.length,
          itemBuilder: (context, index) => PillCard2(
                onTap: () async {
                  ReminderModel reminder = viewmodel.selectedEvents[index];
                  isDelete = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return reminderDialog(context, reminder);
                      });
                  setState(() {
                    if (isDelete != null) {
                      if (isDelete) {
                        viewmodel.selectedEvents
                            .remove(viewmodel.selectedEvents[index]);
                      }
                      viewmodel.storeReminders();
                    }
                  });
                },
                model: viewmodel.selectedEvents[index],
              )),
    );
  }

  AlertDialog reminderDialog(BuildContext context, ReminderModel reminder) {
    return AlertDialog(
      title: Text("Medication Reminder"),
      content: dialogContent(context, reminder),
      actions: [
        TextButton(
            onPressed: () {
              reminder.isTaken = false;
              Navigator.of(context).pop();
            },
            child: Text(
              "Skip",
              style: context.textTheme.bodyText1.copyWith(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
              reminder.isTaken = true;
              Navigator.of(context).pop();
            },
            child: reminder.isTaken
                ? null
                : Text("Take",
                    style: context.textTheme.bodyText1
                        .copyWith(color: ColorTheme.PETRONAS_GREEN))),
      ],
    );
  }

  Column dialogContent(BuildContext context, ReminderModel reminder) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dialogIconRow(reminder),
        context.emptySizedHeightBoxLow3x,
        Text(
          reminder.pillName,
          style: context.textTheme.headline6,
        ),
        context.emptySizedHeightBoxLow3x,
        Text(
          reminder.isTaken ? "Taken" : "Missed",
          style: context.textTheme.bodyText1.copyWith(
              color: reminder.isTaken ? ColorTheme.PETRONAS_GREEN : Colors.red),
        ),
        context.emptySizedHeightBoxLow3x,
        Row(
          children: [
            Icon(Icons.access_alarms),
            context.emptySizedWidthBoxLow3x,
            Text(
              DateFormat('kk:mm').format(reminder.time),
              style: context.textTheme.headline6,
            ),
          ],
        )
      ],
    );
  }

  Row dialogIconRow(ReminderModel reminder) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            TimeOfDay picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(reminder.time));
            DateTime newTime = DateTime(reminder.time.year, reminder.time.month,
                reminder.time.day, picked.hour, picked.minute);
            reminder.time = newTime;
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            icon: Icon(Icons.delete)),
      ],
    );
  }
}
