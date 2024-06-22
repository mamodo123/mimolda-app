import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mimolda/const/constants.dart';

class CartIcon extends StatefulWidget {
  const CartIcon(
      {super.key,
      required this.backgroundColor,
      required this.iconColor,
      required this.onTap,
      this.size = 35,
      this.iconSize = 20,
      this.quantity});

  final Color backgroundColor, iconColor;
  final void Function() onTap;
  final int? quantity;
  final double size, iconSize;

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(widget.size / 2)),
            ),
            child: IconButton(
              onPressed: widget.onTap,
              icon: Center(
                child: Icon(
                  size: widget.iconSize,
                  IconlyLight.bag,
                  color: widget.iconColor,
                ),
              ),
            ),
          ),
          if (widget.quantity != null)
            Positioned(
              top: 0,
              left: 0,
              child: MyGoogleText(
                text: widget.quantity.toString(),
                fontColor: widget.iconColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )
        ],
      ),
    );
  }
}
