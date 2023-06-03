import 'package:api_filmes/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filmePesquisa = 'batman';
  List<dynamic> dados = [];

  @override
  void initState() {
    super.initState();
    data();
  }

  void data() {
    getFilmes(filmePesquisa)
        .then((response) => {
              dados = response['Search'],
              // print(dados)
            })
        .catchError((onError) => {print(onError)});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultas filmes'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Positioned(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Pesquisar',
                        ),
                      ),
                    ),
                    Positioned(right: 0, top: 18, child: Icon(Icons.search))
                  ],
                )),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10),
                child: dados.isEmpty
                    ? Center(
                        child: Icon(
                        Icons.circle,
                        size: 8,
                      ))
                    : ListView.builder(itemBuilder: (context, index) {
                        final filme = dados[index];
                        return ListTile(
                          title: Text(filme['title']),
                        );
                      })),
          ],
        ),
      ),
    );
  }
}
