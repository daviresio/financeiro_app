import 'package:financeiro_app/database/dao/categoria_dao.dart';
import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/util/constantes_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'form_item.dart';

class CategoriaSelect extends StatefulWidget {
  @override
  _CategoriaSelectState createState() => _CategoriaSelectState();
}

class _CategoriaSelectState extends State<CategoriaSelect> {

  final CategoriaDao _categoriaDao = Database.instance.categoriaDao;

  @override
  Widget build(BuildContext context) {
    return FormItem(Icons.bookmark_border, Container(), Container(), () {
      showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (BuildContext context) => Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0), )
          ),
          child: StreamBuilder<List<Categoria>>(
              stream: _categoriaDao.listCategorias(),
              builder: (context, AsyncSnapshot snapshot) {
                const qtdOtherData = 4;
                var data = snapshot.data;
                var currentSize = data == null ? qtdOtherData : data.length + qtdOtherData;
                return ListView.separated(
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
                    itemCount: currentSize,
                    separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black26,),
                    itemBuilder: (BuildContext context, int index) {
                      if(index == 0) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(6.0),
                          leading: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Icon(Icons.search, color: Colors.white,)),
                          title: TextField(
                            decoration: InputDecoration(
                              hintText: 'Pesquisar categoria',
                              border: InputBorder.none,
                            ),
                          ),
                        );
                      } else if(index == currentSize - 3) {
                        return ListTile(
                            contentPadding: EdgeInsets.all(6.0),
                            onTap: () {},
                              leading: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Icon(Icons.settings, color: Colors.white,)),
                              title: Text('Gerenciar categorias')
                        );
                      } else if(index == currentSize - 2) {
                        return ListTile(
                            contentPadding: EdgeInsets.all(6.0),
                            onTap: () {},
                            leading: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Icon(Icons.add, color: Colors.white,)),
                            title: Text('Criar nova categoria')
                        );
                      } else if(index == currentSize - 1) {
                        return ListTile(
                            contentPadding: EdgeInsets.all(6.0),
                          onTap: () {
                              print('taped');
                            Navigator.of(context).pop();
                          },
                            leading: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Icon(Icons.add, color: Colors.white,)),
                            title: Text('Criar nova subcategoria')
                        );
                      } else {
                        return ListTile(
                            contentPadding: EdgeInsets.all(6.0),
                            onTap: () {},
                            leading: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: colorMapping[data[index - 1].cor],
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Icon(iconMapping[data[index - 1].icone], color: Colors.white, size: 18.0,)),
                            title: Text(data[index - 1].nome),
                            trailing: Radio(value: false, onChanged: (v){}, groupValue: null,),
                        );
                      }
                    }
                    );
              }
          ),
        ),
      ));
    });
  }
}
