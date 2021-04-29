import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/cards/covid_card.dart';
import 'package:medication_app_v0/core/components/cards/date_card.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/covid/viewmodel/covid_viewmodel.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';

class CovidView extends StatelessWidget {
  const CovidView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
        model: CovidViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        builder: (BuildContext context, CovidViewModel viewmodel) => Scaffold(
              appBar: AppBar(
                title: Text("Covid Turkey"),
              ),
              body: Observer(
                  builder: (context) => viewmodel.isLoading
                      ? Center(child: PulseLoadingIndicatorWidget())
                      : buildScaffold(context, viewmodel)),
            ));
  }

  Widget buildScaffold(BuildContext context, CovidViewModel viewmodel) {
    return (viewmodel.turkeySummaryList != null)
        ? buildCovidCards(context, viewmodel)
        : Column(
            children: [
              Text("Data empty!"),
            ],
          );
  }

  Padding buildCovidCards(BuildContext context, CovidViewModel viewmodel) {
    return Padding(
      padding: context.paddingLow,
      child: Column(
        children: [
          Expanded(
              child: DateCard(date: viewmodel.turkeySummaryList.last.date)),
          Expanded(
            flex: 3,
            child: CovidCard(
                leftTitle: "Toplam Vaka Sayısı",
                leftValue: viewmodel.turkeySummaryList.last.confirmed,
                leftColor: Colors.amber,
                rightTitle: "Toplam Aktif hasta",
                rightValue: viewmodel.turkeySummaryList.last.active,
                rightColor: Colors.blue),
          ),
          Expanded(
            flex: 3,
            child: CovidCard(
                leftTitle: "Toplam iyileşen",
                leftValue: viewmodel.turkeySummaryList.last.recovered,
                leftColor: Colors.green,
                rightTitle: "Toplam ölüm",
                rightValue: viewmodel.turkeySummaryList.last.death,
                rightColor: Colors.red),
          ),
          Divider(
            thickness: 3.0,
            color: ColorTheme.PRIMARY_BLUE,
          ),
          Expanded(
            flex: 3,
            child: CovidCard(
                leftTitle: "Bugun Vaka Sayısı",
                leftValue: viewmodel.turkeySummaryList.last.confirmed -
                    viewmodel
                        .turkeySummaryList[
                            viewmodel.turkeySummaryList.length - 2]
                        .confirmed,
                leftColor: Colors.amber,
                rightTitle: "Günlük Hasta sayısı değişimi",
                rightValue: viewmodel.turkeySummaryList.last.active -
                    viewmodel
                        .turkeySummaryList[
                            viewmodel.turkeySummaryList.length - 2]
                        .active,
                rightColor: Colors.blue),
          ),
          Expanded(
            flex: 3,
            child: CovidCard(
                leftTitle: "Bugun İyileşen",
                leftValue: viewmodel.turkeySummaryList.last.recovered -
                    viewmodel
                        .turkeySummaryList[
                            viewmodel.turkeySummaryList.length - 2]
                        .recovered,
                leftColor: Colors.green,
                rightTitle: "Bugun ölüm",
                rightValue: viewmodel.turkeySummaryList.last.death -
                    viewmodel
                        .turkeySummaryList[
                            viewmodel.turkeySummaryList.length - 2]
                        .death,
                rightColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
