import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/pill_card2.dart';
import 'package:medication_app_v0/core/components/widgets/custom_bottom_appbar.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/services/google_sign_helper.dart';
import 'package:medication_app_v0/core/init/text/locale_text.dart';
import 'package:medication_app_v0/views/authenticate/login/viewmodel/login_viewmodel.dart';
import 'package:medication_app_v0/views/home/viewmodel/home_viewmodel.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
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
    viewmodel.selectedEvents.sort((a, b) => a.time.compareTo(b.time));
    return Observer(
      builder: (_) => ListView.builder(
          itemCount: viewmodel.selectedEvents.length,
          itemBuilder: (context, index) => PillCard2(
                model: viewmodel.selectedEvents[index],
              )),
    );
  }
}
