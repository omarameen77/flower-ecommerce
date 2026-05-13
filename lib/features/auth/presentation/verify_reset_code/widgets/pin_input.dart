import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinInput extends StatefulWidget {
  final int length;
  final bool hasError;
  final ValueChanged<String> onCompleted;

  const PinInput({
    super.key,
    this.length = 4,
    this.hasError = false,
    required this.onCompleted,
  });

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void didUpdateWidget(covariant PinInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasError && !widget.hasError) _clear();
  }

  void _clear() {
    for (final c in _controllers) {
      c.clear();
    }
    if (_focusNodes.isNotEmpty) _focusNodes.first.requestFocus();
  }

  void _onChanged(int index, String value) {
    _moveFocus(index, value);
    final pin = _controllers.map((c) => c.text).join();
    if (pin.length == widget.length) widget.onCompleted(pin);
  }

  void _moveFocus(int index, String value) {
    if (value.isNotEmpty && index + 1 < widget.length) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, _buildCell),
    );
  }

  Widget _buildCell(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: _PinCell(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          hasError: widget.hasError,
          onChanged: (v) => _onChanged(index, v),
        ),
      ),
    );
  }
}

class _PinCell extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final ValueChanged<String> onChanged;

  const _PinCell({
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError ? AppColors.error : AppColors.border;
    final fillColor = hasError
        ? AppColors.error.withValues(alpha: 0.05)
        : AppColors.background;
    return TextField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: getBoldStyle(
        context: context,
        fontSize: FontSizeManager.s24,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: _border(borderColor),
        focusedBorder: _border(borderColor),
        border: _border(borderColor),
      ),
      onChanged: onChanged,
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSize.s10),
    borderSide: BorderSide(color: color, width: 2),
  );
}
