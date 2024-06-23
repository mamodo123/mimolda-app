import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/models/address.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/app_config.dart';
import '../const/constants.dart';
import '../widgets/add_new_address.dart';
import '../widgets/buttons.dart';

class ShippingAddress extends StatefulWidget {
  final bool selectable;
  final Address? selectedAddress;

  const ShippingAddress(
      {super.key, this.selectedAddress, this.selectable = true});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  String? checked;

  @override
  void initState() {
    checked = widget.selectedAddress?.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fullStore = context.watch<FullStoreNotifier>();
    final addresses = fullStore.user!.addresses.reversed.toList();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.of(context).pop<Address?>(checked == ''
            ? storeAddress
            : addresses.firstWhereOrNull((element) => element.id == checked));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop<Address?>(checked == ''
                  ? storeAddress
                  : addresses
                      .firstWhereOrNull((element) => element.id == checked));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const MyGoogleText(
            text: 'Endereços',
            fontColor: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          width: context.width(),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length + (widget.selectable ? 1 : 0),
                  itemBuilder: (context, index) {
                    final address = widget.selectable
                        ? index == 0
                            ? storeAddress
                            : addresses[index - 1]
                        : addresses[index];
                    final selected = checked == address.id;
                    return GestureDetector(
                      onTap: widget.selectable
                          ? () {
                              setState(() {
                                checked = selected ? null : address.id;
                              });
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selected ? primaryColor : Colors.white,
                            border:
                                Border.all(width: 1, color: secondaryColor3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyGoogleText(
                                          text: address.name,
                                          fontSize: 16,
                                          fontColor: selected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        if (address.id != '')
                                          TextButton(
                                            onPressed: () async {
                                              await addNewAddress(address);
                                            },
                                            child: MyGoogleText(
                                              text: 'Editar',
                                              fontSize: 16,
                                              fontColor: selected
                                                  ? watchSecondaryColor
                                                  : secondaryColor1,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                      ],
                                    ),
                                    Flexible(
                                      child: MyGoogleText(
                                        text: address.fullAddress,
                                        fontSize: 16,
                                        fontColor: selected
                                            ? groceryGreyTextColor
                                            : textColors,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (address.id == '')
                                Icon(
                                  Icons.store_mall_directory_outlined,
                                  size: 35,
                                  color: selected
                                      ? watchSecondaryColor
                                      : secondaryColor1,
                                )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

              ///___________Pay_Now_Button___________________________________

              const Spacer(),
              Button1(
                  buttonText: 'Adicionar endereço',
                  buttonColor: primaryColor,
                  onPressFunction: () async {
                    await addNewAddress(null);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNewAddress(Address? address) async {
    final addressToDelete = await showModalBottomSheet<Address>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) => AddNewAddress(
        address: address,
      ),
    );

    if (addressToDelete != null && addressToDelete.id == checked) {
      setState(() {
        checked = null;
      });
    }
  }
}
