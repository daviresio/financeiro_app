import 'package:financeiro_app/database/dao/conta_dao.dart';
import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/util/constantes_util.dart';
import 'package:financeiro_app/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

  Future<dynamic> showContaSelect(BuildContext context, int contaSelecionadaId) {
    final ContaDao _contaDao = Database.instance.contaDao;


     return showModalBottomSheet(
       context: context, isDismissible: true,
       backgroundColor: Colors.transparent,
       isScrollControlled: true,
       builder: (BuildContext context) =>
          roundedBottomSheet(StreamBuilder<List<Conta>>(
                    stream: _contaDao.listContas(),
                    builder: (context, AsyncSnapshot snapshot) {
                      const qtdOtherData = 2;
                      var data = snapshot.data;
                      return ListView.separated(
                          padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
                          itemCount: data == null ? qtdOtherData : data.length + qtdOtherData,
                          separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black26,),
                          itemBuilder: (BuildContext context, int index) {
                             if(index == 0) {
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
                                  title: Text('Gerenciar contas')
                              );
                            } else if(index == 1) {
                              return ListTile(
                                  contentPadding: EdgeInsets.all(6.0),
                                  onTap: () {

                                  },
                                  leading: Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Icon(Icons.add, color: Colors.white,)),
                                  title: Text('Adicionar nova conta')
                              );
                            } else {
                              return ListTile(
                                contentPadding: EdgeInsets.all(6.0),
                                onTap: () {
                                  Navigator.of(context).pop(data[index - qtdOtherData].id);
                                },
                                leading: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: colorMapping[data[index - qtdOtherData].cor],
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Icon(FontAwesomeIcons.moneyBillAlt, color: Colors.white, size: 18.0,)),
                                title: Text(data[index - qtdOtherData].nome),
                                trailing: Radio(value: data[index - qtdOtherData].id, onChanged: (v){
                                  Navigator.of(context).pop(data[index - qtdOtherData].id);
                                }, groupValue: contaSelecionadaId),
                              );
                            }
                          }
                      );
                    }
          )));
  }




