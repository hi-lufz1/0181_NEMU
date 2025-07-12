import 'package:flutter/material.dart';
import 'package:nemu_app/core/constants/colors.dart';

class ExpandableFab extends StatefulWidget {
  final VoidCallback onCreateReport;
  final VoidCallback onOpenDraft;
  final Function(bool isOpen)? onToggle;

  const ExpandableFab({
    super.key,
    required this.onCreateReport,
    required this.onOpenDraft,
    this.onToggle,
  });

  @override
  ExpandableFabState createState() => ExpandableFabState();
}

class ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      _isOpen ? _controller.forward() : _controller.reverse();
      widget.onToggle?.call(_isOpen);
    });
  }

  void closeFab() {
    if (_isOpen) _toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (_isOpen) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 140),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text label
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text(
                    'Laporan',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // FAB
                FloatingActionButton(
                  heroTag: 'create_report',
                  backgroundColor: AppColors.primary,
                  shape: const CircleBorder(),
                  tooltip: 'Buat Laporan Baru',
                  onPressed: () {
                    _toggle();
                    widget.onCreateReport();
                  },
                  child: const Icon(
                    Icons.assignment_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text label
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text(
                    'Draf',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // FAB
                FloatingActionButton(
                  heroTag: 'open_draft',
                  backgroundColor: AppColors.primary,
                  shape: const CircleBorder(),
                  tooltip: 'Lanjutkan dari Draf',

                  onPressed: () {
                    _toggle();
                    widget.onOpenDraft();
                  },
                  child: const Icon(Icons.save_rounded, color: Colors.white),
                ),
              ],
            ),
          ),
        ],

        FloatingActionButton(
          heroTag: 'main_fab',
          backgroundColor: _isOpen ? Colors.white : AppColors.primary,
          shape: const CircleBorder(),
          onPressed: _toggle,
          tooltip: _isOpen ? 'Tutup Menu' : 'Menu Tambah',
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(turns: animation, child: child);
            },
            child: Icon(
              _isOpen ? Icons.close : Icons.add,
              key: ValueKey<bool>(_isOpen),
              color: _isOpen ? Colors.grey : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
