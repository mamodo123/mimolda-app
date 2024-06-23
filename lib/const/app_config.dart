import '../models/address.dart';

enum Integrations { NUVEMSHOP }

const integrationsMap = {Integrations.NUVEMSHOP: 'nuvemshop'};

const integration = Integrations.NUVEMSHOP;
const storeId = '3828470';
const storeName = 'La Muse';
const tryItAtHome = true;

const storeAddress = Address(
    id: '',
    name: 'Retirar na loja',
    zipcode: '88063080',
    street: 'Rua do Gramal',
    number: '405',
    complement: '',
    neighborhood: 'Campeche',
    city: 'Florianópolis',
    state: 'SC',
    noNumber: false,
    latitude: -27.684469620993234,
    longitude: -48.49482448249663);
