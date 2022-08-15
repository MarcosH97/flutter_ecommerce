import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

  String _selcont = Config.paises.first,
      _selprov = Config.provinciaL.first,
      _selmun = Config.munNames.first;

  Destinatario d = Destinatario();
  var c = Config();
  int paisTemp = 0;
  int munTemp = 0;

  String? validateFields(String? s) {
    if (s!.isEmpty) {
      return 'validate_empty'.tr;
    }
    return null;
  }

  String? validateEmail(String? s) {
    if (s!.isEmpty) {
      return null;
    } else if (!s.contains('@')) {
      return 'validate_email'.tr;
    }
    return null;
  }

  String? validateCI(String? s) {
    if (s!.isEmpty) {
      return "Campo vacio";
    }
    if (s.length < 11) {
      return 'validate_id'.tr;
    }
    return null;
  }

  String? validatePais(String? s) {
    var c = Config();
    // print(Config.paises);
    if (s!.isEmpty) {
      return 'validate_empty'.tr;
    } else if (!Config.paises.contains(s)) {
      return "Pais no encontrado";
    }
    return null;
  }

  String? validateProvincia(String? s) {
    print(Config.provinciaL);
    if (s!.isEmpty) {
      return 'validate_empty'.tr;
    } else if (!Config.provinciaL.contains(s)) {
      return "Provincia no encontrada";
    }

    return null;
  }

  String? validateMunicipio(String? s) {
    if (s!.isEmpty) {
      return 'validate_empty'.tr;
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
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 10,
        children: [
          TextFormField(
            validator: validateFields,
            decoration: InputDecoration(
                labelText: "${'name'.tr}*", border: OutlineInputBorder()),
            onSaved: (value) {
              d.nombre = value;
            },
          ),
          TextFormField(
            validator: validateFields,
            decoration: InputDecoration(
                labelText: "${'surname'.tr}*", border: OutlineInputBorder()),
            onSaved: (value) {
              d.apellido1 = value;
            },
          ),
          TextFormField(
            validator: validateFields,
            decoration: InputDecoration(
                labelText: "${'lastname'.tr}", border: OutlineInputBorder()),
            onSaved: (value) {
              d.apellido2 = value;
            },
          ),
          TextFormField(
            validator: validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'email'.tr, border: OutlineInputBorder()),
            onSaved: (value) {
              d.email = value;
            },
          ),
          TextFormField(
            validator: validateFields,
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(labelText: "CI*", border: OutlineInputBorder()),
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
            invalidNumberMessage: "validate_phone".tr,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: 'phone'.tr,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            initialCountryCode: 'CU',
            onChanged: (phone) {
              // print(phone.completeNumber);
              d.telefono = phone.completeNumber;
            },
          ),
          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    errorStyle: TextStyle(),
                    hintText: 'country'.tr,
                    border: OutlineInputBorder()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selcont,
                    isDense: true,
                    onChanged: (value) {
                      setState(() {
                        _selcont = value!;
                        d.pais = Config().getPaisID(value);
                      });
                    },
                    items: Config.paises
                        .map((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                  ),
                ),
              );
              // labelText: "${'country'.tr}*"),
            },
          ),

          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    errorStyle: TextStyle(),
                    hintText: 'states'.tr,
                    border: OutlineInputBorder()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selprov,
                    isDense: true,
                    onChanged: (value) {
                      setState(() {
                        _selprov = value!;
                        d.provincia = Config().getProvinciaID(value);
                      });
                    },
                    items: Config.provinciaL
                        .map((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                  ),
                ),
              );
              // labelText: "${'country'.tr}*"),
            },
          ),

          FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    errorStyle: TextStyle(),
                    hintText: 'district'.tr,
                    border: OutlineInputBorder()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selmun,
                    isDense: true,
                    onChanged: (value) {
                      setState(() {
                        _selmun = value!;
                        d.municipio = Config().getMunicipioID(value);
                      });
                    },
                    items: Config.munNames
                        .map((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                  ),
                ),
              );
              // labelText: "${'country'.tr}*"),
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'citydist'.tr, border: OutlineInputBorder()),
            onSaved: (value) {
              d.ciudad = value;
            },
          ),
          TextFormField(
            validator: validateFields,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
                labelText: "${'address'.tr}*", border: OutlineInputBorder()),
            onSaved: (value) {
              d.direccion = value;
            },
          ),
          Divider(),
          Text('alterna'.tr),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'othername'.tr, border: OutlineInputBorder()),
            onSaved: (value) {
              d.nombreAlternativo = value;
            },
          ),
          IntlPhoneField(
            // autovalidateMode: AutovalidateMode.always,
            autovalidateMode: AutovalidateMode.disabled,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "${'otherphone'.tr}*",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            initialCountryCode: 'CU',
            onChanged: (phone) {
              d.telefonoAlternativo = phone.completeNumber.toString();
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Nota", border: OutlineInputBorder()),
            onSaved: (value) {
              d.notaEntrega = value;
            },
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                primary: Config.maincolor
              ),
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
                        builder: (context) => popUp('createmsg_s'.tr)
                      );
                      // print("called callback");
                      widget.callback;
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => popUp('createmsg_e'.tr)
                      );
                    }
                  }
                  ;
                }
              },
              child: Text('createmsg'.tr, style: TextStyle(color: Colors.white),)),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  AlertDialog popUp(String message) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Ok'))
        ],
      );
}
