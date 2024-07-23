import '../models/address.dart';

enum Integrations { NUVEMSHOP }

const integrationsMap = {Integrations.NUVEMSHOP: 'nuvemshop'};

const integration = Integrations.NUVEMSHOP;
const storeId = '3828470';
final storeType = integrationsMap[integration]!;