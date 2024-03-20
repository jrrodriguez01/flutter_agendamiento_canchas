import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../config/providers.dart';
import '../../domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'helpers/messages.dart';
import 'helpers/validate_input.dart';

class AgendaPage extends ConsumerStatefulWidget {
  const AgendaPage({super.key});

  @override
  AgendaPageState createState() => AgendaPageState();
}

class AgendaPageState extends ConsumerState<AgendaPage> {
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _userInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _porcentajeInput = TextEditingController();
  late String _canchaInput = '';
  int _porcentaje = 0;
  late Agenda agenda = Agenda(agendaDetail: <AgendaDetail>[]);

  @override
  void initState() {
    super.initState();
    initAgenda();
  }

  @override
  void dispose() {
    _dateInput.dispose();
    _userInput.dispose();
    _porcentajeInput.dispose();
    super.dispose();
  }

  Future<void> getporcentaje(String fecha) async {
    final agenda = ref.read(allAgendaProvider);
    int porcentaje = await agenda.getPorcentajeLluvia(fecha);
    setState(() {
      _porcentaje = porcentaje;
      _porcentajeInput.text = porcentaje.toString();
    });
  }

  Future<void> initAgenda() async {
    var lAgenda = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString('lAgenda');
    });
    if (lAgenda != null) {
      Map<String, dynamic> listaMap = jsonDecode(lAgenda);
      Agenda datos = Agenda.fromJson(listaMap);
      agenda = datos;
    }else{
      agenda = Agenda(agendaDetail: <AgendaDetail>[]);
    }
  }

  Future<void> saveAgenda(AgendaDetail nuevaAgenda) async {
    final SharedPreferences prefs = await _prefs;
    agenda.agendaDetail.add(nuevaAgenda);
    agenda.agendaDetail.sort((a, b) => a.fecha.compareTo(b.fecha));
    await prefs.setString('lAgenda', jsonEncode(agenda.toJson()));
    ref.read(agendasProvider.notifier).update((state) => []);
    for (var element in agenda.agendaDetail) {
      ref.read(agendasProvider.notifier).update((state) => [
        ...state,
        element
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cancha = ref.watch(canchaProvider);
    List<CanchaDetail> canchas = cancha.getAllCanchas();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Agendar cancha'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: DropdownButtonFormField(
                key: Key('input-cancha'),
                decoration: const InputDecoration(
                    icon: Icon(Icons.sports_soccer),
                    labelText: "Cancha"
                  ),
                  items: canchas.map((e) {
                     return DropdownMenuItem(
                         value: e.codigo,
                         child: Text(e.descripcion)
                     );
                  }).toList(),
                onChanged: (value) {
                  setState(() {
                    _canchaInput = value!;
                  });
                },
                validator: (value) => validateInputCancha(value, agenda.agendaDetail, _dateInput.text, 'C'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                key: Key('input-fecha'),
                controller: _dateInput,
                validator: (value) => validateInputCancha(value, agenda.agendaDetail, _canchaInput, 'F'),
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Fecha"
                ),
                readOnly: true,
                onTap: () async {
                  var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 6))
                  );

                  if(pickedDate != null ){
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    String formatDateWeather = DateFormat('yyyy-MM-dd').format(pickedDate);
                    await getporcentaje(formatDateWeather);
                    setState(() {
                      _dateInput.text = formattedDate;
                    });
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                key: Key('input-porcentaje'),
                controller: _porcentajeInput,
                readOnly: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.cloud_circle),
                  labelText: '% Probabilidad lluvia',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                key: Key('input-usuario'),
                controller: _userInput,
                decoration: const InputDecoration(
                  icon: Icon(Icons.people_outline),
                  labelText: 'Nombre Usuario',
                ),
                validator: (value) => validateInputUsuario(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                key: Key('button-agendar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AgendaDetail nuevaAgenda = AgendaDetail(id: const Uuid().v4(), cancha: _canchaInput, usuario: _userInput.text, fecha: DateFormat('dd-MM-yyyy').parse(_dateInput.text), porcentajeLluvia: _porcentaje);
                    saveAgenda(nuevaAgenda);
                    showMessage(context,'Confirmación','Se realizo el agendamiento exitosamente');
                  }
                },
                child: const Text('Agendar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}