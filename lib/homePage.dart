import 'package:api_filmes/api.dart';
import 'package:flutter/material.dart';
import 'films.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController buscarController = TextEditingController();
  String filmePesquisa = 'spider';
  List<dynamic> dados = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    getFilmes(filmePesquisa).then((response) {
      setState(() {
        dados = response['Search'];
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
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
                      controller: buscarController,
                      onChanged: (value) => {
                        setState(() {
                          filmePesquisa = value;
                          fetchData();
                        }),
                      },
                      decoration: InputDecoration(
                        labelText: 'Pesquisar',
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 18,
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dados.length,
                itemBuilder: (context, index) {
                  final filme = dados[index];
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Films(
                                    filmes: filme['imdbID'],
                                  )))
                    },
                    child: ListTile(
                      title: Text(filme['Title']),
                      subtitle: Text(filme['Year']),
                      leading: Hero(
                        tag: filme['imdbID'],
                        child: Image.network(
                          filme['Poster'],
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                                'data:image/png;base64,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');
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
