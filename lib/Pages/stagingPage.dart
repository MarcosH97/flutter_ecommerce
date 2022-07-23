import 'dart:convert';

import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Models/Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uuid/uuid.dart';

import '../Models/Componente.dart';
import '../Models/Producto.dart';
import '../Utils/Config.dart';

class stagePage extends StatefulWidget {
  const stagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => stagePageState();
}

class stagePageState extends State<stagePage> {
  var destin = Config.destinos.length > 0 ? Config.destinos[0] : "empty";

  static final List<String> backup = ["empty", "empty2", "empty3"];

  late bool _activo;

  bool _switch = false;

  bool selPayMet = true;

  List<ProductoAct> productos = Config().getProductosCarrito();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  var carrito = Config.carrito;
  var config = Config();
  int currentStep = 0;
  Destinatario d = Destinatario();
  @override
  Widget build(BuildContext context) {
    _activo = (destin != null);
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
              Navigator.pushReplacementNamed(context, "/paypal");
              // OrdenRequest().createOrderPayPal();
            } else if (currentStep == 0) {
              // if (_switch) {
              _globalKey.currentState!.save();
              // d.nombreRemitente = Config.activeUser.name;
              d.nombreRemitente = "Vacio";
              d.activo = false;
              d.usuario = Config.activeUser.id;
              if (!Config.destinatarios.contains(d)) {
                DestinatarioResponse().createDestinatario(d);
                Config.destinatarios.add(d);
                Config.destiny = 0;
                // }
              }
              setState(() {
                currentStep++;
              });
            } else {
              setState(() {
                currentStep++;
              });
            }
          },
          onStepCancel: () {
            // print(jsonEncode(Config.carrito).replaceAll(r'\"', "'"));
            if (currentStep == 0) {
              null;
            } else
              setState(() => currentStep--);
          },
          controlsBuilder: (context, details) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: currentStep == 2
                                ? Size(120, 30)
                                : Size(120, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text("ATRÁS"),
                        onPressed: details.onStepCancel,
                      ),
                    ),
                    if (currentStep != 2)
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Config.maincolor,
                              fixedSize: Size(120, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            "SIGUIENTE",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: details.onStepContinue,
                        ),
                      )
                  ]),
            );
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _destinos =
      (Config.destinos.isNotEmpty ? Config.destinos : backup)
          .map((String value) => DropdownMenuItem<String>(
                child: Center(child: Text(value, textAlign: TextAlign.center)),
                value: value,
              ))
          .toList();

  List<Step> getSteps() => [
        Step(
            title: currentStep == 0 ? Text('destins'.tr) : Text(""),
            isActive: currentStep >= 0,
            content: Form(
              key: _globalKey,
              child: Column(
                children: [
                  Text(
                    "Seleccione un destinatario",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border.all(width: 1, color: Colors.grey),
                  //       color: Config.maincolor,
                  //       borderRadius: BorderRadius.circular(5)),
                  //   child: Config.destinos.length > 0
                  //       ? DropdownButtonHideUnderline(
                  //           child: DropdownButton(
                  //           dropdownColor: Config.maincolor,
                  //           style: const TextStyle(
                  //             fontSize: 16,
                  //             color: Colors.white,
                  //             overflow: TextOverflow.visible,
                  //           ),
                  //           isExpanded: true,
                  //           itemHeight: null,
                  //           value: Config.destinos.length > 0 ? destin : "",
                  //           alignment: Alignment.center,
                  //           items: _destinos,
                  //           icon: Icon(
                  //             Icons.arrow_drop_down,
                  //             color: Colors.white,
                  //           ),
                  //           onChanged: (String? value) {
                  //             if (value != null) {
                  //               int id = 0;
                  //               Config.destinatarios.forEach(
                  //                 (element) {
                  //                   if (element.nombre == value) {
                  //                     id = element.id!;
                  //                   }
                  //                 },
                  //               );
                  //               setState(() {
                  //                 Config.destiny = id;
                  //                 destin = value;
                  //                 print(Config.destiny);
                  //               });
                  //             }
                  //           },
                  //         ))
                  //       : SizedBox(),
                  // ),
                  // Row(
                  //   children: [
                  //     Text("Crear un destinatario nuevo"),
                  //     Switch(
                  //         value: _switch,
                  //         onChanged: (bool b) {
                  //           setState(() => _switch = b);
                  //         },
                  //         activeColor: Config.maincolor),
                  //   ],
                  // ),
                  // _switch
                  // ?
                  Column(
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
                        decoration:
                            InputDecoration(labelText: "Reparto o Ciudad*"),
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
                          d.telefonoAlternativo =
                              phone.completeNumber.toString();
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
                  // SizedBox(height: 10,),
                  // ElevatedButton(onPressed: (){

                  // }, child: Text('Crear Destinatario')),
                  // SizedBox(height: 10,),
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 1,
            title: currentStep == 1 ? Text('paymet'.tr) : Text(''),
            content: Container(
              height: MediaQuery.of(context).size.height / 4,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        selPayMet = true;
                      }),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color:
                                    selPayMet ? Config.maincolor : Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset('assets/paypallarge.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        selPayMet = false;
                      }),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color:
                                    selPayMet ? Colors.grey : Config.maincolor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset('assets/tropipaylarge.png',
                            fit: BoxFit.contain),
                      ),
                    ),
                  )
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 2,
            title: currentStep == 2 ? Text('pay'.tr) : Text(""),
            content: Container(
                height: MediaQuery.of(context).size.height / 2 + 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListView.builder(
                        itemCount: carrito.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle:
                                                StrutStyle(fontSize: 20),
                                            text: TextSpan(
                                                text: productos[index].nombre!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                              Center(
                                                  child: Text(
                                                "${config.getProductFinalPrice(productos[index])} US\$",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                    color: Config.maincolor),
                                                textAlign: TextAlign.center,
                                              )
                                                  // Text(Config.carrito[index].producto!.nombre!, textAlign: TextAlign.center,)
                                                  ),
                                              Text(
                                                "${carrito[index].respaldo!.toStringAsFixed(2)} US\$",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.grey[700]),
                                                textAlign: TextAlign.center,
                                              )
                                            ])),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                color: Config.maincolor,
                                                borderRadius:
                                                    BorderRadius.circular(60)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: carrito[index]
                                                                .cantidad !=
                                                            1
                                                        ? () {
                                                            if (carrito[index]
                                                                    .cantidad! >
                                                                1) {
                                                              setState(() {
                                                                carrito[index]
                                                                    .decrementCantidad();
                                                                ComponenteCreate()
                                                                    .updateRespaldo(
                                                                        index);
                                                              });
                                                            }
                                                          }
                                                        : null,
                                                    style: ElevatedButton.styleFrom(
                                                        primary:
                                                            Config.maincolor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            width: 2,
                                                            color: Config
                                                                .maincolor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 50,
                                                      width: 40,
                                                      child: Text(
                                                        carrito[index]
                                                            .cantidad
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Config
                                                                .maincolor),
                                                      )),
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        if (carrito[index]
                                                                .cantidad! <=
                                                            int.parse(productos[
                                                                    index]
                                                                .cantInventario!)) {
                                                          setState(() {
                                                            carrito[index]
                                                                .incrementCantidad();
                                                            ComponenteCreate()
                                                                .updateRespaldo(
                                                                    index);
                                                          });
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          primary:
                                                              Config.maincolor),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          Config.carrito.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                      ),
                                      iconSize: 30,
                                      padding: EdgeInsets.all(0))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${'deliver'.tr} ${Config.selectedMun} (${Config.provincia})",
                                style: TextStyle(fontSize: 14)),
                            Text("\$${Config().getCostActiveMun()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal", style: TextStyle(fontSize: 14)),
                            Text("\$${Config().getTotalPriceKart()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total", style: TextStyle(fontSize: 14)),
                            Text(
                                "\$${(Config().getTotalPriceKart() + Config().getCostActiveMun()).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18))
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Wrap(
                          direction: Axis.vertical,
                          spacing: 5,
                          children: [
                            Text('payDet'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(Config.user.name!),
                            Text(Config.user.email!),
                            Text(""),
                          ],
                        )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 100,
                          width: 1,
                          color: Colors.grey,
                        ),
                        Expanded(
                            child: Wrap(
                          direction: Axis.vertical,
                          spacing: 5,
                          children: [
                            Text('shipping'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(Config().getDestinatario().email!),
                            Text(Config().getDestinatario().direccion!),
                            Text(Config().getDestinatario().nombre!),
                          ],
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (selPayMet)
                      Expanded(
                          child: GestureDetector(
                        onTap: (() {
                          Navigator.popAndPushNamed(context, '/paypal');
                          Config.karrito.clear();
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.amber,
                          child: Image.asset('assets/paypallarge.png'),
                        ),
                      ))
                    else
                      Expanded(
                          child: GestureDetector(
                        onTap: (() {
                          // Navigator.popAndPushNamed(context, '/paypal');
                          // Config.karrito.clear();
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.amber,
                          child: Image.asset(Config.lang
                              ? 'assets/tropi_es.png'
                              : 'assets/tropi_en.png'),
                        ),
                      ))
                  ],
                ))),
      ];
  bool biggerThan(double a, double b) => a != b;
}
