import 'dart:convert';

import 'package:country_information/main_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);

  List allData = [];
  List<String> brefCountries = [];

  List selectedCountryData = [];
  List theFinalData = [];
  //get all data
  getAllData() async {
    emit(LoadingAllDataState());
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all/'));
    if (response.statusCode == 200) {
      allData = await jsonDecode(response.body);

      brefCountries = [];

      // for (var i = 0; i < allData.length; i++) {
      //   brefCountries.add({
      //     'name': allData[i]['name']['common'],
      //     // 'flag': allData[i]['flags']['png'],
      //   });
      // }

      for (var i = 0; i < allData.length; i++) {
        brefCountries.add(
          allData[i]['name']['common'],
        );
      }

      emit(SuccessAllDataState());
    } else {
      emit(ErrorAllDataState());
      throw Exception('Failed to load data');
    }
  }

  //get Selected coutry
  getSelectedCoutry(selectedCoutry) async {
    emit(LoadingSelectedCoutryState());
    final response = await http
        .get(Uri.parse('https://restcountries.com/v3.1/name/$selectedCoutry'));
    if (response.statusCode == 200) {
      selectedCountryData = await jsonDecode(response.body);

      theFinalData.add({
        'latlng': selectedCountryData.first['capitalInfo']['latlng'],
        'common name': selectedCountryData.first['name']['common'] ?? '',
        'official name': selectedCountryData.first['name']['official'] ?? '',
        'cca2': selectedCountryData.first['cca2'] ?? '',
        'cca3': selectedCountryData.first['cca3'] ?? '',
        'independent': selectedCountryData.first['independent'] ?? '',
        'currencies name':
            selectedCountryData.first['currencies'].values.first['name'] ?? '',
        'currencies symbol':
            selectedCountryData.first['currencies'].values.first['symbol'] ??
                '',
        'capital': selectedCountryData.first['capital'].first ?? '',
        'region': selectedCountryData.first['region'] ?? '',
        'subregion': selectedCountryData.first['subregion'] ?? '',
        'languages': selectedCountryData.first['languages'].values.first ?? '',
        'borders': selectedCountryData.first['borders'] ?? '', //this is list
        'area': '${selectedCountryData.first['area']} km²',
        'demonyms': selectedCountryData.first['demonyms']['eng']['f'] ?? '',
        'googleMaps': selectedCountryData.first['maps']['googleMaps'] ?? '',
        'population': selectedCountryData.first['population'].toString(),
        'timezones': selectedCountryData.first['timezones'].first ?? '',
        'continents': selectedCountryData.first['continents'].first ?? '',
        'flags': selectedCountryData.first['flags']['png'] ?? '',
        'description of falgs': selectedCountryData.first['flags']['alt'] ?? '',
        'coatOfArms': selectedCountryData.first['coatOfArms']['png'] ?? '',
        'startOfWeek': selectedCountryData.first['startOfWeek'] ?? '',
      });
      emit(SuccessSelectedCoutryState());
    } else {
      emit(ErrorSelectedCoutryState());
      throw Exception('Failed to load data');
    }
  }
}



// return jsonData.map((e) => Model.fromJson(e)).toList();