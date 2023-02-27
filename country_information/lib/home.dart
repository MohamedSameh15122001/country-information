import 'package:country_information/constant.dart';
import 'package:country_information/country_information.dart';
import 'package:country_information/main_cubit.dart';
import 'package:country_information/main_states.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    internetConection(context);
    MainCubit ref = MainCubit.get(context);
    return Scaffold(
      body: BlocConsumer<MainCubit, MainState>(
        bloc: MainCubit.get(context)..getAllData(),
        listener: (context, state) {},
        builder: (context, state) {
          return ref.brefCountries.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Stack(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1535483102974-fa1e64d0ca86?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Colors.grey[100],
                          ),
                          child: DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: ref.brefCountries,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                labelText: "Choose country",
                                hintText: "country in menu mode",
                              ),
                            ),
                            // onChanged: print,
                            selectedItem: ref.brefCountries.first,
                            onChanged: (value) {
                              ref.theFinalData = [];
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CountryInformation(
                                    selectedCoutry: value,
                                  );
                                },
                              ));
                            },
                          )),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
