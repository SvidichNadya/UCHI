import 'package:flutter/material.dart';
import '../../network/api_client.dart';

class DashboardScreen extends StatefulWidget {
  final int childId;
  const DashboardScreen({super.key, required this.childId});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List sessions = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await ApiClient.getChildSessions(widget.childId);
    setState(() {
      sessions = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Панель развития')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final s = sessions[index];
                return Card(
                  child: ListTile(
                    title: Text('Сессия ${s['session_id']}'),
                    subtitle: Text(
                      'Чтение: ${s['wcpm']} слов/мин\n'
                      'Движение: ${s['movement_minutes']} мин\n'
                      'Поделок: ${s['craft_count']}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}