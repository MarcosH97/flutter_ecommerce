import 'dart:convert';

import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Models/Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uuid/uuid.dart';

import '../Utils/Config.dart';

class stagePage extends StatefulWidget {
  const stagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => stagePageState();
}

class stagePageState extends State<stagePage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  int currentStep = 0;
  Destinatario d = Destinatario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Config.maincolor)),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLast = currentStep == getSteps().length - 1;
            if (isLast) {
              OrdenRequest().createOrderPayPal();
            } else if (currentStep == 0) {
              _globalKey.currentState!.save();
              // d.nombreRemitente = Config.activeUser.name;
              d.nombreRemitente = "Vacio";
              d.activo = false;
              d.usuario = Config.activeUser.id;
              if (!Config.destinatarios.contains(d)) {
                DestinatarioResponse().createDestinatario(d);
                Config.destinatarios.add(d);
                Config.destiny = 5;
              }
              currentStep++;
            } else {
              setState(() {
                currentStep++;
              });
            }
          },
          onStepCancel: () {
            print(jsonEncode(Config.carrito).replaceAll(r'\"', "'"));
            if (currentStep == 0) {
              null;
            } else
              setState(() => currentStep--);
          },
          controlsBuilder: (context, details) {
            return Container(
              margin: EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      child: Text("ATRÁS"),
                      onPressed: details.onStepCancel,
                    )),
                    Expanded(
                        child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Config.maincolor),
                      child: Text(
                        "SIGUIENTE",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: details.onStepContinue,
                    ))
                  ]),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            title: Text("Destinatario"),
            isActive: currentStep >= 0,
            content: Form(
              key: _globalKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Nombre*"),
                    onSaved: (value) {
                      d.nombre = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Apellido 1*"),
                    onSaved: (value) {
                      d.apellido1 = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Apellido 2*"),
                    onSaved: (value) {
                      d.apellido2 = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Email*"),
                    onSaved: (value) {
                      d.email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "CI*"),
                    onSaved: (value) {
                      d.ci = value;
                    },
                  ),
                  IntlPhoneField(
                    // autovalidateMode: AutovalidateMode.always,
                    invalidNumberMessage: "Formato de telefono incorrecto",
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Teléfono',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    initialCountryCode: 'US',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                      d.telefono = phone.completeNumber;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "País*"),
                    onSaved: (value) {
                      d.pais = 1;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Provincia*"),
                    onSaved: (value) {
                      d.provincia = 2;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Municipio*"),
                    onSaved: (value) {
                      d.municipio = 2;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Reparto o Ciudad*"),
                    onSaved: (value) {
                      d.ciudad = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Dirección*"),
                    onSaved: (value) {
                      d.direccion = value;
                    },
                  ),
                  Divider(),
                  Text("Campos alternativos"),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Otro Nombre"),
                    onSaved: (value) {
                      d.nombreAlternativo = value;
                    },
                  ),
                  IntlPhoneField(
                    // autovalidateMode: AutovalidateMode.always,
                    invalidNumberMessage: "Formato de telefono incorrecto",
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Teléfono Alternativo',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    initialCountryCode: 'US',
                    onChanged: (phone) {
                      d.telefonoAlternativo = phone.completeNumber.toString();
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Nota"),
                    onSaved: (value) {
                      d.notaEntrega = value;
                    },
                  ),
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 1,
            title: Text("Forma de Pago"),
            content: Card()),
        Step(isActive: currentStep >= 2, title: Text("Pago"), content: Card()),
      ];
}
