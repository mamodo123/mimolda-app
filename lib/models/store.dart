import 'address.dart';

class Store {
  final String integration, storeId, storeName, phoneNumber;
  final bool tryItAtHome;
  final Address storeAddress;

  const Store(
      {required this.integration,
      required this.storeId,
      required this.storeName,
      required this.phoneNumber,
      required this.tryItAtHome,
      required this.storeAddress});

  Store.fromJson(Map<String, dynamic> data)
      : integration = data['integration'],
        storeId = data['storeId'],
        storeName = data['storeName'],
        phoneNumber = data['phoneNumber'],
        tryItAtHome = data['tryItAtHome'],
        storeAddress = Address.fromJson('', data['storeAddress']);
}
