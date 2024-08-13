import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/widgets/buttons.dart';
import 'package:mimolda/widgets/yes_no_dialog.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../const/values.dart';
import '../data_manager/user.dart';
import '../models/address.dart';
import 'message_dialog.dart';

class AddNewAddress extends StatefulWidget {
  final Address? address;
  final bool selectable;

  const AddNewAddress(
      {super.key, required this.address, required this.selectable});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  bool loading = false;
  late final FocusNode focusNode;
  late final MaskTextInputFormatter maskFormatter;
  late final TextEditingController nameController,
      zipcodeController,
      streetController,
      numberController,
      complementController,
      neighborhoodController,
      cityController;
  late final GlobalKey<FormState> formKey;

  late String state;

  var lastZipcode = '';
  var noNumber = false;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    final address = widget.address;
    maskFormatter = MaskTextInputFormatter(
        initialText: address?.zipcode,
        mask: '#####-###',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    nameController = TextEditingController(text: address?.name);
    zipcodeController =
        TextEditingController(text: maskFormatter.getMaskedText());
    streetController = TextEditingController(text: address?.street);
    numberController = TextEditingController(text: address?.number);
    complementController = TextEditingController(text: address?.complement);
    neighborhoodController = TextEditingController(text: address?.neighborhood);
    cityController = TextEditingController(text: address?.city);
    state = address?.state ?? '';

    focusNode = FocusNode()
      ..addListener(() async {
        if (!focusNode.hasFocus) {
          final zipcode = maskFormatter.getUnmaskedText();
          if (RegExp(r'^[0-9]{8}$').hasMatch(zipcode) &&
              zipcode != lastZipcode) {
            setState(() {
              loading = true;
            });

            final response = await http
                .get(Uri.parse('https://viacep.com.br/ws/$zipcode/json'));
            final responseBody = response.body;
            final result = jsonDecode(responseBody) as Map<String, dynamic>;
            if (!(result['erro'] ?? false)) {
              final street = result['logradouro'];
              // final complement = result['complemento'];
              final neighborhood = result['bairro'];
              final city = result['localidade'];
              final state = result['uf'];
              if (street != '') {
                streetController.text = street;
              }
              // if (complement != '') {
              //   complementController.text = complement;
              // }
              if (neighborhood != '') {
                neighborhoodController.text = neighborhood;
              }
              if (city != '') {
                cityController.text = city;
              }
              if (state != '') {
                setState(() {
                  this.state = state;
                });
              }
            } else {
              if (context.mounted) {
                await messageDialog(context, 'CEP', 'Cep não encontrado');
              }
            }

            if (context.mounted) {
              setState(() {
                loading = false;
              });
            }
          }
          lastZipcode = zipcode;
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyGoogleText(
                              text: widget.address == null
                                  ? 'Novo endereço'
                                  : 'Atualizar endereço',
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          if (widget.address != null && !widget.selectable)
                            IconButton(
                              onPressed: () async {
                                final shouldDelete = await yesNoDialog(
                                    context,
                                    'Excluir endereço',
                                    'Deseja excluir o endereço ${widget.address!.name}?');
                                if (shouldDelete == true) {
                                  setState(() {
                                    loading = true;
                                  });

                                  await deleteUserAddress(widget.address!.id);

                                  if (context.mounted) {
                                    final fullStore =
                                        context.read<FullStoreNotifier>();

                                    await fullStore.reloadAddresses();
                                  }

                                  setState(() {
                                    loading = false;
                                  });
                                  if (context.mounted) {
                                    Navigator.of(context).pop(widget.address);
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome do local',
                          hintText: 'Exemplo: Casa',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: zipcodeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CEP',
                          hintText: 'Digite o seu CEP',
                        ),
                        inputFormatters: [maskFormatter],
                        focusNode: focusNode,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (!RegExp(r'^[0-9]{8}$')
                              .hasMatch(maskFormatter.getUnmaskedText())) {
                            return 'CEP inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: streetController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Logradouro',
                          hintText: 'Digite o logradouro',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Logradouro inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: numberController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Número',
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (!noNumber &&
                                    (value == null ||
                                        !RegExp(r'^[0-9]+$').hasMatch(value))) {
                                  return 'Número inválido';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: complementController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Complemento',
                              ),
                            ),
                          ),
                        ],
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Endereço sem número"),
                        value: noNumber,
                        onChanged: (newValue) {
                          setState(() {
                            noNumber = newValue ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: neighborhoodController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Bairro',
                          hintText: 'Digite o bairro',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Bairro inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: cityController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Cidade',
                                hintText: 'Digite a cidade',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Cidade inválida';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownMenu<String>(
                            initialSelection: state,
                            onSelected: (value) {
                              setState(() {
                                if (value != null) {
                                  state = value;
                                }
                              });
                            },
                            dropdownMenuEntries: states
                                .map<DropdownMenuEntry<String>>((String state) {
                              return DropdownMenuEntry<String>(
                                value: state,
                                label: state,
                              );
                            }).toList(),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const MyGoogleText(
                      //       text: 'Use as Billing address',
                      //       fontSize: 18,
                      //       fontColor: textColors,
                      //       fontWeight: FontWeight.normal,
                      //     ),
                      //     Platform.isAndroid
                      //         ? Switch(
                      //             value: addressSwitch,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 addressSwitch = value;
                      //               });
                      //             },
                      //             activeColor: secondaryColor1,
                      //           )
                      //         : CupertinoSwitch(
                      //             activeColor: secondaryColor1,
                      //             value: addressSwitch,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 addressSwitch = value;
                      //               });
                      //             },
                      //           )
                      //   ],
                      // ),
                      // const SizedBox(height: 15),
                      Button1(
                          buttonText: 'Salvar',
                          buttonColor: primaryColor,
                          onPressFunction: () async {
                            setState(() {
                              loading = true;
                            });

                            final name = nameController.text;
                            final zipcode = maskFormatter.getUnmaskedText();
                            final street = streetController.text;
                            final noNumber = this.noNumber;
                            final number =
                                noNumber ? '' : numberController.text;
                            final complement = complementController.text;
                            final neighborhood = neighborhoodController.text;
                            final city = cityController.text;
                            final state = this.state;

                            var address = 'Brazil $zipcode,';
                            if (street != '') {
                              address += ' $street';
                            }
                            if (number != '') {
                              address += ' $number';
                            }
                            if (city != '') {
                              address += ', $city';
                            }
                            if (state != '') {
                              address += ' - $state';
                            }

                            if (formKey.currentState?.validate() ?? false) {
                              List<Location> locations =
                                  await locationFromAddress(address);

                              if (locations.isEmpty) {
                                if (context.mounted) {
                                  await messageDialog(context, 'Logradouro',
                                      'Logradouro não encontrado');
                                }
                              } else {
                                final location = locations.first;
                                final latitude = location.latitude;
                                final longitude = location.longitude;

                                final data = {
                                  'name': name,
                                  'zipcode': zipcode,
                                  'street': street,
                                  'number': number,
                                  'complement': complement,
                                  'neighborhood': neighborhood,
                                  'city': city,
                                  'state': state,
                                  'noNumber': noNumber,
                                  'latitude': latitude,
                                  'longitude': longitude,
                                };

                                await updateUserAddress(
                                    widget.address?.id, data);
                                if (context.mounted) {
                                  final fullStore =
                                      context.read<FullStoreNotifier>();
                                  await fullStore.reloadAddresses();
                                }
                                if (context.mounted) {
                                  finish(context);
                                }
                              }
                            }
                            setState(() {
                              loading = false;
                            });
                          }),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (loading)
          Container(
            color: Colors.white.withOpacity(0.6),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
