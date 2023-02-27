import 'package:country_information/constant.dart';
import 'package:country_information/main_cubit.dart';
import 'package:country_information/main_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/link.dart';

class CountryInformation extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final selectedCoutry;
  const CountryInformation({super.key, this.selectedCoutry});

  @override
  Widget build(BuildContext context) {
    internetConection(context);
    MainCubit ref = MainCubit.get(context);
    return BlocConsumer<MainCubit, MainState>(
      bloc: MainCubit.get(context)..getSelectedCoutry(selectedCoutry),
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   title: Text(
          //       '${ref.theFinalData.first['common name']} (${ref.theFinalData.first['official name']})'),
          // ),
          body: ref.theFinalData.isEmpty || state is LoadingSelectedCoutryState
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildImageRow('', ref.theFinalData.first['flags']),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextRow('Common Name',
                                  ref.theFinalData.first['common name']),
                              _buildTextRow('Official Name',
                                  ref.theFinalData.first['official name']),
                              _buildTextRow('Alpha-2 Code',
                                  ref.theFinalData.first['cca2']),
                              _buildTextRow('Alpha-3 Code',
                                  ref.theFinalData.first['cca3']),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Independence: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value:
                                          ref.theFinalData.first['independent'],
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),

                              _buildTextRow('Currency Name',
                                  ref.theFinalData.first['currencies name']),
                              _buildTextRow('Currency Symbol',
                                  ref.theFinalData.first['currencies symbol']),
                              _buildTextRow(
                                  'Capital', ref.theFinalData.first['capital']),
                              _buildTextRow(
                                  'Region', ref.theFinalData.first['region']),
                              _buildTextRow('Subregion',
                                  ref.theFinalData.first['subregion']),
                              _buildTextRow('Language',
                                  ref.theFinalData.first['languages']),
                              // _buildTextRow('Borders',ref.theFinalData.first[''] country.borders.join(', ')),
                              _buildTextRow(
                                  'Area', ref.theFinalData.first['area']),
                              _buildTextRow('Demonym',
                                  ref.theFinalData.first['demonyms']),
                              Link(
                                target: LinkTarget.self,
                                uri: Uri.parse(
                                    ref.theFinalData.first['googleMaps']),
                                builder: (context, followLink) {
                                  return GestureDetector(
                                      onTap: followLink,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Google Maps: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                ref.theFinalData
                                                    .first['googleMaps'],
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                              _buildTextRow(
                                  'Population',
                                  ref.theFinalData.first['population']
                                      .toString()),
                              _buildTextRow('Timezone',
                                  ref.theFinalData.first['timezones']),
                              _buildTextRow('Continent',
                                  ref.theFinalData.first['continents']),
                              _buildTextRow('Start of Week',
                                  ref.theFinalData.first['startOfWeek']),
                              SizedBox(
                                height: 200,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Description of Flag: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Flexible(
                                          child: Text(ref.theFinalData
                                              .first['description of falgs'])),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        _buildImageRow('Coat of Arms',
                            ref.theFinalData.first['coatOfArms']),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildTextRow(String label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildImageRow(String label, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          imageUrl,
          // height: 300.0,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
