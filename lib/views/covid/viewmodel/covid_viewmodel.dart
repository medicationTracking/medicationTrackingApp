import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/components/models/covid_models/country_model.dart';
import 'package:medication_app_v0/core/components/models/covid_models/country_summary_model.dart';
import 'package:medication_app_v0/core/init/services/covid_services.dart';
import 'package:mobx/mobx.dart';
part 'covid_viewmodel.g.dart';

class CovidViewModel = _CovidViewModelBase with _$CovidViewModel;

abstract class _CovidViewModelBase with Store, BaseViewModel {
  @observable
  bool isLoading = false;

  List<CountrySummaryModel> turkeySummaryList;

  @override
  Future<void> init() async {
    changeLoading();
    turkeySummaryList = await CovidService().getCountrySummary("turkey");
    changeLoading();
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }
}
