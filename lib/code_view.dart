import 'package:flutter/material.dart';
import 'dart:core';

class CodeView extends StatefulWidget {
  CodeView({
    this.code,
    this.length = 6,
    this.codeTextStyle,
    this.obscurePin,
    this.width,
    this.showBullets,
  });

  final String code;
  final int length;
  final bool obscurePin;
  final TextStyle codeTextStyle;
  final double width;
  final bool showBullets;

  CodeViewState createState() => CodeViewState();
}

class CodeViewState extends State<CodeView> {
  Widget getCodeAt(index) {
    String code;

    if (widget.code == null || widget.code.length < index)
      code = "  ";
    else if (widget.obscurePin) {
      code = "•";
    } else {
      code = widget.code.substring(index - 1, index);
    }

    return Text(
      code,
      textAlign: TextAlign.center,
      style: widget.codeTextStyle,
    );
  }

  Widget getBulletAt(index) {
    if (widget.code == null || widget.code.length < index)
      return Container();
    else {
      return Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: widget.codeTextStyle.color,
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }
  }

  _getCodeViews() {
    int _codeLength = widget.length;
    double _gapSize = widget.showBullets ? 10 : 3;
    double _inputWidth =
        (widget.width - 1 - (_codeLength - 1) * _gapSize) / _codeLength;
    if (_inputWidth < 30) _inputWidth = 30;
    if (_inputWidth > 50) _inputWidth = 50;
    double _inputHeight = _inputWidth * 1.1;

    if (widget.showBullets) {
      _inputWidth = _inputHeight = 20;
    }

    List<Widget> widgets = [];
    for (var i = 0; i < _codeLength; i++) {
      widgets.add(
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                right: i == _codeLength - 1 ? 0 : _gapSize, bottom: _gapSize),
            decoration: BoxDecoration(
              color: Colors.black12,
              border: widget.showBullets
                  ? Border.all(color: widget.codeTextStyle.color)
                  : Border(bottom: BorderSide(color: Colors.white)),
              borderRadius:
                  widget.showBullets ? BorderRadius.circular(10) : null,
            ),
            height: _inputHeight,
            width: _inputWidth,
            child: widget.showBullets ? getBulletAt(i + 1) : getCodeAt(i + 1)),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: _getCodeViews(),
    );
  }
}
