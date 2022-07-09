import 'package:flutter/material.dart';

import '../Utils/Config.dart';

// const String _heroAddTodo = 'add-todo-hero';

class AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Hero(
          tag: "FavList",
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: Material(
            color: Config.maincolor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "F A V O R I T O S",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: SingleChildScrollView(
                      child: 
                      ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                            title: Text('Nombre prod'),
                            subtitle: Text('descripcion prod'),
                            trailing: Icon(Icons.cancel_outlined),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                    "http://diplomarket-backend.herokuapp.com/media/products/bistec%20de%20cerdo/2022-06-06-333232.jpg")),
                            style: ListTileStyle.drawer,
                          ),
                        )
                      
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
