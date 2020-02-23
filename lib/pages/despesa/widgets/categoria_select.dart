import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:financeiro_app/blocs/bloc_categoria.dart';
import 'package:financeiro_app/database/dao/categoria_dao.dart';
import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/util/constantes_util.dart';
import 'package:financeiro_app/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

  Future<dynamic> showCategoriaSelect(BuildContext context, int categoriaSelecionadaId, String tipo) {
    final CategoriaDao _categoriaDao = Database.instance.categoriaDao;
    final ListaCategoriaBloc _bloc = BlocProvider.getBloc<ListaCategoriaBloc>();

    _bloc.setPesquisaText('');
    _bloc.retraiModal();

     return showModalBottomSheet(
       context: context,
       isDismissible: true,
       backgroundColor: Colors.transparent,
       isScrollControlled: true,
       builder: (BuildContext context) =>
          StreamBuilder<double>(
            stream: _bloc.modalExpandido,
            initialData: 0.5,
            builder: (context, snapshot) {
              return roundedBottomSheet(
                StreamBuilder(
                  stream: _bloc.pesquisaText,
                  initialData: '',
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                   return StreamBuilder<List<Categoria>>(
                        stream: _categoriaDao.search(snapshot.data, tipo),
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
                                      onChanged: (onValue) {
                                        _bloc.setPesquisaText(onValue);
                                      },
                                      onTap: () {
                                        _bloc.expandeModal();
                                      },
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
                                      onTap: () {
                                        Navigator.of(context).pop((BuildContext context) => showNovaCategoria(context));
                                      },
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
                                      onTap: () {},
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
                                    onTap: () {
                                      Navigator.of(context).pop(data[index - 1].id);
                                    },
                                    leading: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: colorMapping[data[index - 1].cor],
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Icon(iconMapping[data[index - 1].icone], color: Colors.white, size: 18.0,)),
                                    title: Text(data[index - 1].nome),
                                    trailing: Radio(value: data[index - 1].id, onChanged: (v){
                                      Navigator.of(context).pop(data[index - 1].id);
                                    }, groupValue: categoriaSelecionadaId),
                                  );
                                }
                              }
                          );
                        }
                    );
                  },
                ),
                height: snapshot.data,
              );
            }
          ),
      );
  }

Future<dynamic> showNovaCategoria(BuildContext context) {
  final CategoriaDao _categoriaDao = Database.instance.categoriaDao;
  NovaCategoriaBloc _bloc = BlocProvider.getBloc<NovaCategoriaBloc>();


  _renderColor(String color, String selected) {
    return
      GestureDetector(
        onTap: () {
          _bloc.alteraCor(color);
        },
        child: Container(
          width: 30.0,
          height: 30.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: colorMapping[color],
          ),
          child: (color == selected ? Icon(Icons.check, color: Colors.white,) : Container()),
        ),
      );
  }

  _renderIcone(String icone, String selected) {
    return
      GestureDetector(
        onTap: () {
          _bloc.alteraIcone(icone);
        },
        child: Container(
          width: 30.0,
          height: 30.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: icone == selected ? Colors.orange : Colors.grey[400],
          ),
          child: Icon(iconMapping[icone], size: 14.0, color: Colors.white,),
        ),
      );
  }

  TextEditingController _textFieldController = TextEditingController();

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => roundedBottomSheet(
        Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
            child: Wrap(
              children: <Widget>[
                Text('Criar nova categoria', style: TextStyle(fontWeight: FontWeight.bold, ),),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.newspaper, color: Colors.black26,),
                      SizedBox(width: 30.0,),
                      Container(
                          width: MediaQuery.of(context).size.width - 90.0,
                          child: TextField(
                            controller: _textFieldController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Descricao'
                            ),
                          )),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: StreamBuilder<String>(
                      stream: _bloc.cor,
                      initialData: 'azul',
                    builder: (context, snapshot) {
                      return Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.palette, color: Colors.black26,),
                          SizedBox(width: 30.0,),
                          Expanded(child: Text('Cor')),
                          _renderColor('azul', snapshot.data),
                          _renderColor('verde', snapshot.data),
                          _renderColor('vermelho', snapshot.data),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: Text('Outros...'),
                          ),
                        ],
                      );
                    }
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: StreamBuilder<String>(
                    stream: _bloc.icone,
                    initialData: 'alimentacao',
                    builder: (context, snapshot) {
                      return Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.image, color: Colors.black26,),
                          SizedBox(width: 30.0,),
                          Expanded(child: Text('Icone')),
                          _renderIcone('alimentacao', snapshot.data),
                          _renderIcone('educacao', snapshot.data),
                          _renderIcone('lazer', snapshot.data),
                          Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: Text('Outros...'),
                          ),
                        ],
                      );
                    }
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  height: 1.0,
                ),
                SizedBox(height: 40.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OutlineButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: Text('CANCELAR', style: TextStyle(color: Colors.redAccent),), borderSide: BorderSide(color: Colors.redAccent, ), highlightedBorderColor: Colors.redAccent,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),),
                      RaisedButton(onPressed: () async {
                        print('debug ' + _bloc.icone.value);
                        print('debug ' + _bloc.cor.value);
                        var categoriaCriada = await _categoriaDao.insertCategoria(Categoria(nome: _textFieldController.value.text, tipo: 'despesa', icone: _bloc.icone.value, cor: _bloc.cor.value));
                        Navigator.of(context).pop(categoriaCriada);
                      }, child: Text('CONCLUIDO', style: TextStyle(color: Colors.white),),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
  );

}

