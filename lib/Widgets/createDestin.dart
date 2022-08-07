import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../Models/Destinatario.dart';
import '../Utils/Config.dart';

class createDestin extends StatefulWidget {
  final Function callback;
  createDestin({Key? key, required this.callback}) : super(key: key);

  @override
  State<createDestin> createState() => _createDestinState();
}

class _createDestinState extends State<createDestin> {
  final _globalKey = GlobalKey<FormState>();
  Destinatario d = Destinatario();
  var c = Config();
  int paisTemp = 0;
  int munTemp = 0;

  String? validateFields(String? s) {
    if (s!.isEmpty) {
      return "Campo vacio";
    }
    return null;
  }

  String? validateEmail(String? s) {
    if (s!.isEmpty) {
      return "Campo vacio";
    } else if (!s.contains('@')) {
      return "Formato de correo incorrecto";
    }
    return null;
  }

  String? validateCI(String? s) {
    if (s!.isEmpty) {
      return "Campo vacio";
    }
    if (s.length < 11) {
      return "CI incorrecto";
    }
    return null;
  }

  String? validatePais(String? s) {
    var c = Config();
    // print(Config.paises);
    if (s!.isEmpty) {
      return "Campo vacio";
    } else if (!Config.paises.contains(s)) {
      return "Pais no encontrado";
    }
    return null;
  }

  String? validateProvincia(String? s) {
    print(Config.provinciaL);
    if (s!.isEmpty) {
      return "Campo vacio";
    } else if (!Config.provinciaL.contains(s)) {
      return "Provincia no encontrada";
    }

    return null;
  }

  String? validateMunicipio(String? s) {
    if (s!.isEmpty) {
      return "Campo vacio";
    } else if (!Config.munNames.contains(s)) {
      return "Municipio no encontrado";
    }
    return null;
  }

  String? validatephone2(String? s) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            validator: validateFields,
            decoration: InputDecoration(labelText: "Nombre*"),
            onSaved: (value) {
              d.nombre = value;
            },
          ),
          TextFormField(
            validator: validateFields,
            decoration: InputDecoration(labelText: "Apellido 1*"),
            onSaved: (value) {
              d.apellido1 = value;
            },
          ),
          TextFormField(
            validator: validateFields,
            decoration: InputDecoration(labelText: "Apellido 2*"),
            onSaved: (value) {
              d.apellido2 = value;
            },
          ),
          TextFormField(
            validator: validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: "Email*"),
            onSaved: (value) {
              d.email = value;
            },
          ),
          TextFormField(
            validator: validateFields,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "CI*"),
            maxLength: 11,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
              // print(phone.completeNumber);
              d.telefono = phone.completeNumber;
            },
          ),
          TextFormField(
            validator: validatePais,
            decoration: InputDecoration(labelText: "País*"),
            onSaved: (value) {
              d.pais = c.getPaisID(value!);
            },
          ),
          TextFormField(
            validator: validateProvincia,
            decoration: InputDecoration(labelText: "Provincia*"),
            onSaved: (value) {
              d.provincia = c.getProvinciaID(value!);
            },
          ),
          TextFormField(
            validator: validateMunicipio,
            decoration: InputDecoration(labelText: "Municipio*"),
            onSaved: (value) {
              d.municipio = c.getMunicipioID(value!);
            },
          ),
          TextFormField(
            validator: validateFields,
            decoration: InputDecoration(labelText: "Reparto o Ciudad*"),
            onSaved: (value) {
              d.ciudad = value;
            },
          ),
          TextFormField(
            validator: validateFields,
            keyboardType: TextInputType.streetAddress,
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
            validator: null,
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
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();
                  // d.nombreRemitente = Config.activeUser.name;
                  d.nombreRemitente = Config.user.name;
                  d.activo = true;
                  d.usuario = Config.activeUser.id;
                  print("validado");
                  if (!Config.destinatarios.contains(d)) {
                    print("no existe");
                    if (await DestinatarioResponse().createDestinatario(d)) {
                      await DestinatarioResponse().getDestinatarios();

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Destinatario creado correctamente"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Ok'))
                          ],
                        ),
                      );
                      print("called callback");
                      widget.callback;
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error creando destinatario"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Ok'))
                          ],
                        ),
                      );
                    }
                  }
                  ;
                }
              },
              child: Text('Crear Destinatario')),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
