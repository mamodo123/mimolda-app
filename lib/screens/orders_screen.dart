import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../const/translations.dart';
import '../const/values.dart';
import '../functions/hashcode.dart';
import '../models/order.dart';
import '../models/store.dart';
import 'order_dialog.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  static const orderByOptions = ['Atualização', 'Data do pedido'];
  static final filterByOptions = [
    'Todos',
    ...orderStatusTranslator.keys,
    'Expirado',
    // 'Entrega próxima'
  ];
  var orderBy = orderByOptions.first;
  var filterBy = filterByOptions.first;

  @override
  Widget build(BuildContext context) {
    final fullStoreNotifier = context.watch<FullStoreNotifier>();
    final ordersWithoutFilterAndSort =
        List<MimoldaOrder>.from(fullStoreNotifier.user?.orders ?? []);
    final orders = filterAndSortOrder(ordersWithoutFilterAndSort);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isComputer = width > height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        // ),
        title: const MyGoogleText(
          text: 'Pedidos',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: orders.isEmpty
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: filters(),
                ),
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 80,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyGoogleText(
                          text: 'Nenhum pedido',
                          fontSize: 18,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: false,
                  floating: true,
                  expandedHeight: 100,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: filters(),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final order = orders[index];
                    final quantity = order.products
                        .fold<int>(0, (total, e) => total + e.quantity);
                    final late = order.late;

                    return GestureDetector(
                      onTap: () async {
                        final updatedDb = await showOrder(
                            fullStoreNotifier.store,
                            order,
                            getStatusHistory(ordersWithoutFilterAndSort
                                .where((e) => e.clientId == order.clientId)),
                            isComputer);
                        if (updatedDb == true) {
                          await fullStoreNotifier.reloadOrders();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Card(
                          color: order.isExpired
                              ? null
                              : orderStatusColor[order.status],
                          child: Padding(
                            padding:
                                const EdgeInsets.all(16).copyWith(bottom: 8),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pedido #${hashN(order.id ?? '', 6)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          order.address!.id == ''
                                              ? 'Retirar na loja'
                                              : order.address!.fullAddress,
                                          textAlign: TextAlign.center),
                                      Text(
                                          '$quantity ${quantity == 1 ? 'item' : 'itens'} - R\$ ${((order.totalValue + order.discounts) / 100).toStringAsFixed(2).replaceAll('.', ',')}'),
                                      Text(
                                          'Pedido em: ${DateFormat('dd/MM/yyyy kk:mm').format(order.createdAt)}',
                                          textAlign: TextAlign.center),
                                      Text(
                                          'Data de ${order.address!.id.isEmpty ? 'retirada' : 'entrega'}: ${DateFormat('dd/MM/yyyy').format(order.deliveryDate!.toUtc())}, ${order.period}',
                                          textAlign: TextAlign.center),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Última atualização: ${DateFormat('dd/MM/yyyy kk:mm').format(order.updatedAt)}',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(order.isExpired
                                              ? 'Expirado'
                                              : orderStatusTranslator[
                                                      order.status] ??
                                                  ''),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (late != null)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.5),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        late,
                                        textAlign: TextAlign.center,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: orders.length),
                )
              ],
            ),
    );
  }

  List<MimoldaOrder> filterAndSortOrder(List<MimoldaOrder> orders) {
    if (orderBy == 'Última atualização') {
      orders.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    } else if (orderBy == 'Data do pedido') {
      orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    if (filterBy != filterByOptions.first) {
      if (filterBy == 'Expirado') {
        return orders.where((e) => e.isExpired).toList();
      } else if (filterBy == 'Entrega próxima') {
        final now = DateTime.now();
        return orders
            .where((e) =>
                e.status == 'accepted' && e.deliveryDate!.toUtc().isAfter(now))
            .toList();
      } else {
        return orders
            .where((e) => e.status == filterBy && !e.isExpired)
            .toList();
      }
    }
    return orders;
  }

  Map<String, int> getStatusHistory(Iterable<MimoldaOrder> orders) {
    final Map<String, int> statusHistory = {};
    for (final order in orders) {
      final status = order.status == 'ordered' && order.isExpired
          ? 'expired'
          : order.status;
      final item = statusHistory[status] ?? 0;
      statusHistory[status] = item + 1;
    }
    return statusHistory;
  }

  Future<bool?> showOrder(Store store, MimoldaOrder order,
      Map<String, int> statusHistory, bool isComputer) async {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return OrderDialog(
              store: store,
              order: order,
              statusHistory: statusHistory,
              isComputer: isComputer);
        });
  }

  Widget filters() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text('Ordenação:'),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  value: orderBy,
                  items: orderByOptions.map((String e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                      ),
                    );
                  }).toList(),
                  onChanged: (e) {
                    if (e != null) {
                      setState(() {
                        orderBy = e;
                      });
                    }
                  },
                  focusColor: Colors.transparent,
                ),
              ],
            ),
            Row(
              children: [
                const Text('Filtro:'),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  value: filterBy,
                  items: filterByOptions.map((String e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        orderStatusTranslator[e] ?? e,
                      ),
                    );
                  }).toList(),
                  onChanged: (e) {
                    if (e != null) {
                      setState(() {
                        filterBy = e;
                      });
                    }
                  },
                  focusColor: Colors.transparent,
                ),
              ],
            ),
          ],
        ),
      );
}
