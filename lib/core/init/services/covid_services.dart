import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medication_app_v0/core/components/models/covid_models/country_model.dart';
import 'package:medication_app_v0/core/components/models/covid_models/country_summary_model.dart';

class CovidService {
  //get summary of given country slug=turkey
  Future<List<CountrySummaryModel>> getCountrySummary(String slug) async {
    try {
      Uri uri =
          Uri.parse("https://api.covid19api.com/total/dayone/country/" + slug);
      final data = await http.Client().get(uri);
      if (data.statusCode != 200) throw Exception();
      List<CountrySummaryModel> summaryList = (json.decode(data.body) as List)
          .map((item) => new CountrySummaryModel.fromJson(item))
          .toList();
      return summaryList;
    } catch (e) {
      return null;
    }
  }

  //get all countries as list
  Future<List<CountryModel>> getCountryList() async {
    Uri uri = Uri.parse("https://api.covid19api.com/countries");
    try {
      final data = await http.Client().get(uri);

      if (data.statusCode != 200) throw Exception();
      List<CountryModel> countries = (json.decode(data.body) as List)
          .map((item) => new CountryModel.fromJson(item))
          .toList();
      return countries;
    } catch (e) {
      return null;
    }
  }
}
