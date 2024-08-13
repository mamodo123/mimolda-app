import 'package:flutter/material.dart';

const colors = {
  'Amarelo': Colors.yellow,
  'Azul': Colors.blue,
};

const orderStatusColor = {
  'ordered': Color(0xffffecc0),
  'accepted': Color(0xffa8ffb5),
  'canceledByStore': Color(0xffffa8a8),
  'canceledByClient': Color(0xffffa8a8),
  'onProbation': Color(0xffa8d8ff),
  'waitingReturn': Color(0xfff0a9ff),
  'done': Color(0xffc7a6ff),
  'problem': Color(0xffffc365),
};

const purchaseStatusColor = {
  'ordered': Color(0xffffecc0),
  'accepted': Color(0xfff0a9ff),
  'canceledByStore': Color(0xffffa8a8),
  'canceledByClient': Color(0xffffa8a8),
  'waitingSent': Color(0xffa8d8ff),
  'done': Color(0xffc7a6ff),
  'problem': Color(0xffffc365),
};

const sizes = ['PP', 'P', 'M', 'G', 'GG', 'XG', 'XGG'];

const states = [
  'AC',
  'AL',
  'AM',
  'AP',
  'BA',
  'CE',
  'DF',
  'ES',
  'GO',
  'MA',
  'MG',
  'MS',
  'MT',
  'PA',
  'PB',
  'PE',
  'PI',
  'PR',
  'RJ',
  'RN',
  'RO',
  'RR',
  'RS',
  'SC',
  'SE',
  'SP',
  'TO'
];

const List<String> paymentImageList = [
  'images/credit-card.png',
  'images/dollar-bill.png',
  'images/pix.png'
];
const List<String> paymentNameList = ['Cartão', 'Dinheiro', 'Pix'];