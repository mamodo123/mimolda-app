class Address {
  final String id,
      name,
      zipcode,
      street,
      number,
      complement,
      neighborhood,
      city,
      state;
  final bool noNumber;
  final double latitude, longitude;

  String get fullAddress {
    String formattedComplement = complement.isNotEmpty ? ', $complement' : '';
    String formattedZipcode =
        '${zipcode.substring(0, 5)}-${zipcode.substring(5)}';
    return '$street $number$formattedComplement, $neighborhood, $city - $state, $formattedZipcode';
  }

  const Address(
      {required this.id,
      required this.name,
      required this.zipcode,
      required this.street,
      required this.number,
      required this.complement,
      required this.neighborhood,
      required this.city,
      required this.state,
      required this.noNumber,
      required this.latitude,
      required this.longitude});

  Address.fromJson(this.id, Map<String, dynamic> data)
      : name = data['name'],
        zipcode = data['zipcode'],
        street = data['street'],
        number = data['number'],
        complement = data['complement'],
        neighborhood = data['neighborhood'],
        city = data['city'],
        state = data['state'],
        noNumber = data['noNumber'],
        latitude = data['latitude'],
        longitude = data['longitude'];
}
