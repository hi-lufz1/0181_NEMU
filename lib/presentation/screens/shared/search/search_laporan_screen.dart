import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/utils/token_service.dart';
import 'package:nemu_app/data/model/request/shared/get_filter_req_model.dart';
import 'package:nemu_app/data/model/response/shared/getall_res_model.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanadmin/laporan_admin_bloc.dart';
import 'package:nemu_app/presentation/bloc/laporan/laporanuser/laporan_user_bloc.dart';
import 'package:nemu_app/core/components/feed_post_card.dart';
import 'package:nemu_app/presentation/screens/shared/search/components/laporan_list_view.dart';
import 'package:nemu_app/presentation/screens/shared/search/components/search_filter_bar.dart';
import 'package:nemu_app/presentation/screens/shared/search/components/search_filter_sheet.dart';

class SearchLaporanScreen extends StatefulWidget {
  const SearchLaporanScreen({super.key});

  @override
  State<SearchLaporanScreen> createState() => _SearchLaporanScreenState();
}

class _SearchLaporanScreenState extends State<SearchLaporanScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedTipe;
  String? _selectedKategori;
  String? _selectedLokasi;
  DateTime? _tanggalAwal;
  DateTime? _tanggalAkhir;
  bool isAdmin = false;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _loadFilteredData();
    _initRole();
  }

  Future<void> _initRole() async {
    final role = await TokenService.getCurrentUserRole();
    setState(() {
      isAdmin = role == 'admin';
    });
    _loadFilteredData();
  }

  void _loadFilteredData() {
    final filter = GetFilterReqModel(
      search: _searchController.text,
      tipe: _selectedTipe,
      kategori: _selectedKategori,
      lokasi: _selectedLokasi,
      status: isAdmin ? _selectedStatus : 'aktif',
      tanggalAwal: _tanggalAwal,
      tanggalAkhir: _tanggalAkhir,
    );

    if (isAdmin) {
      context.read<LaporanAdminBloc>().add(
        LaporanAdminFiltered(filter: filter),
      );
    } else {
      context.read<LaporanUserBloc>().add(FilterLaporanAktif(filter: filter));
    }
  }

  void _resetFilter() {
    setState(() {
      _selectedTipe = null;
      _selectedKategori = null;
      _selectedLokasi = null;
      _tanggalAwal = null;
      _tanggalAkhir = null;
      _searchController.clear();
    });
    _loadFilteredData();
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SearchFilterSheet(
          selectedTipe: _selectedTipe,
          selectedKategori: _selectedKategori,
          selectedLokasi: _selectedLokasi,
          tanggalAwal: _tanggalAwal,
          tanggalAkhir: _tanggalAkhir,
          onTipeChanged: (val) => _selectedTipe = val,
          onKategoriChanged: (val) => _selectedKategori = val,
          onLokasiChanged: (val) => _selectedLokasi = val,
          onTanggalAwalChanged: (val) => _tanggalAwal = val,
          onTanggalAkhirChanged: (val) => _tanggalAkhir = val,
          onStatusChanged:
              isAdmin ? (val) => _selectedStatus = val : null, // admin
          onSubmit: _loadFilteredData,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      appBar: AppBar(
        title: const Text(
          "Cari Laporan",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetFilter),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchFilterBar(
                searchController: _searchController,
                onSearchChanged: _loadFilteredData,
                onFilterPressed: () => _showFilterSheet(context),
              ),
              const SizedBox(height: 24),
              const Text(
                "Hasil Pencarian",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
             isAdmin
  ? BlocBuilder<LaporanAdminBloc, LaporanAdminState>(
      builder: (context, state) => LaporanListView(state: state),
    )
  : BlocBuilder<LaporanUserBloc, LaporanUserState>(
      builder: (context, state) => LaporanListView(state: state),
    )

            ],
          ),
        ),
      ),
    );
  }

  
}
