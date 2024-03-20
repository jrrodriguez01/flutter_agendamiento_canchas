import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/providers/agenda_provider.dart';
import '../../config/routes/app_routes.dart';
import '../../domain/domain.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late final Agenda agenda;

  @override
  void initState() {
    super.initState();
    initAgenda();
  }

  Future<void> initAgenda() async {
    var lAgenda = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString('lAgenda');
    });
    if (lAgenda != null) {
      Map<String, dynamic> listaMap = jsonDecode(lAgenda);
      Agenda datos = Agenda.fromJson(listaMap);
      agenda = datos;
      agenda.agendaDetail.sort((a, b) => a.fecha.compareTo(b.fecha));
      ref.read(agendasProvider.notifier).update((state) => []);
      for (var element in agenda.agendaDetail) {
        ref.read(agendasProvider.notifier).update((state) =>
        [
          ...state,
          element
        ]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Agendamiento de canchas'),
      ),
      body: const _AgendaView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.add ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.agenda);
        },
      ),
    );
  }
}

class _AgendaView extends ConsumerWidget {
  const _AgendaView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(canchaFilterProvider);
    final agendas = ref.watch(filteredAgendasProvider);
    final registros = ref.watch(agendasProvider);
    DateFormat format = DateFormat("dd-MM-yyyy");
    bool existeReserva = registros.isNotEmpty;

    Future<void> borrarAgenda(String uuid) async {
      final Future<SharedPreferences> vprefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await vprefs;
      Agenda vagenda = Agenda(agendaDetail: <AgendaDetail>[]);
      for (var element in registros) {
        if(uuid != element.id){
          vagenda.agendaDetail.add(element);
        }
      }
      vagenda.agendaDetail.sort((a, b) => a.fecha.compareTo(b.fecha));
      await prefs.setString('lAgenda', jsonEncode(vagenda.toJson()));
      ref.read(agendasProvider.notifier).update((state) => []);
      for (var element in vagenda.agendaDetail) {
        ref.read(agendasProvider.notifier).update((state) => [
          ...state,
          element
        ]);
      }
    }

    void showConfirm(BuildContext context, String title, String message, String id) {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black38,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  borrarAgenda(id);
                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black38,
                  ),
                ),
                child: const Text('Cancelar'),
              ),
            ],
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(message),
            ),
          );
        },
      );
    }

    return Column(
      children: [
        existeReserva ? const ListTile(
          title: Text('Listado de agendamientos', textAlign: TextAlign.center,),
          subtitle: Text('Estos son los agendamientos realizados', textAlign: TextAlign.center,),
        ): const ListTile(
          title: Text('No existen agendamientos de canchas',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red)
          ),
        ),
        existeReserva ? SegmentedButton(
          segments: const[
            ButtonSegment(value: CanchaFilter.all, icon: Text('Todas')),
            ButtonSegment(value: CanchaFilter.canchaA, icon: Text('A')),
            ButtonSegment(value: CanchaFilter.canchaB, icon: Text('B')),
            ButtonSegment(value: CanchaFilter.canchaC, icon: Text('C')),
          ],
          selected: <CanchaFilter>{ currentFilter},
          onSelectionChanged: (value) {
            ref.read(canchaFilterProvider.notifier)
                .state = value.first;
          },
        ): const SizedBox(),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: agendas.length,
            itemBuilder: (context, index) {
              final agenda = agendas[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.lightBlueAccent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 300,
                          child: ListTile(
                            title: Row(
                              children: <Widget>[
                                Text(
                                  agenda.usuario,
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                                const Spacer(),
                                Text(
                                  format.format(agenda.fecha),
                                  style: const TextStyle(fontSize: 18.0),
                                )
                              ],
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Text(
                                    'Cancha ${agenda.cancha}',
                                    style: const TextStyle(fontSize: 16.0)
                                ),
                                const Spacer(),
                                Text(
                                    'Lluvia ${agenda.porcentajeLluvia}%',
                                    style: const TextStyle(fontSize: 16.0)
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          child: IconButton(
                            icon: const Icon(Icons.phonelink_erase),
                            iconSize: 30,
                            onPressed: (){
                              showConfirm(context,'Advertencia','¿Esta seguro que desea eliminar el agendamiento?',agenda.id);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}