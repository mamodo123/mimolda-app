import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/constants.dart';

// ignore: must_be_immutable
class QuantityCounter extends StatefulWidget {
  const QuantityCounter({
    super.key,
    required this.value,
    required this.sizeOfButtons,
    required this.valueUpdate,
    this.hideMinus = false,
    this.hidePlus = false,
  });

  final int value;
  final double sizeOfButtons;
  final void Function(int) valueUpdate;
  final bool hideMinus, hidePlus;

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.sizeOfButtons * 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.hideMinus
              ? SizedBox(
                  width: widget.sizeOfButtons,
                )
              : GestureDetector(
                  onTap: () {
                    widget.valueUpdate(widget.value - 1);
                  },
                  child: Material(
                    elevation: 4,
                    color: secondaryColor3,
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: widget.sizeOfButtons,
                      height: widget.sizeOfButtons,
                      child: Center(
                        child: Icon(FeatherIcons.minus,
                            size: widget.sizeOfButtons - 10, color: textColors),
                      ),
                    ),
                  ),
                ),
          Text(
            widget.value.toString(),
            style: GoogleFonts.dmSans(fontSize: 18),
          ),
          widget.hidePlus
              ? SizedBox(
                  width: widget.sizeOfButtons,
                )
              : GestureDetector(
                  onTap: () {
                    widget.valueUpdate(widget.value + 1);
                  },
                  child: Material(
                    elevation: 4,
                    color: secondaryColor3,
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: widget.sizeOfButtons,
                      height: widget.sizeOfButtons,
                      child: Center(
                        child: Icon(Icons.add,
                            size: widget.sizeOfButtons - 10, color: textColors),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
