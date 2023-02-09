import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:khushi/Api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          lazy: true,
          create: ((
            context,
          ) =>
              Api()))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     super.key,
//   });

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   final ScrollController _scrollController = ScrollController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     category();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _scrollController.addListener(() {
//         if (!_scrollController.hasClients) {
//           return;
//         }
//         final provider =
//             Provider.of<Api>(context, listen: false);
//         if (_scrollController.offset ==
//                 _scrollController.position.maxScrollExtent
//             ) {

//           provider.incrementPage();
//           provider.getCategory(provider.page);
//         }
//       });
//     });
//   }

//   category() {
//     Provider.of<Api>(context, listen: false).getCategory(1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Api>(builder: (s, contexts, ss) {
//       List data=[];
//       data.addAll(Provider.of<Api>(context, listen: true).category
//       );
//       return Scaffold(
//         appBar: AppBar(
//           title: data.isEmpty
//               ? Text("data fetching")
//               : Text("Data fetching completed"),
//         ),
//         body: data.isEmpty
//             ? const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.yellow,
//                 ),
//               )
//             : SingleChildScrollView(
//               child: Container(
//                 height: 500,

//                 color: Colors.green,
//                 child: RefreshIndicator(
//                   onRefresh: () async {
//                     contexts.getCategory(1);
//                     contexts.page=1;
//                   },
//                   child: ListView.builder(
//                     controller: _scrollController,
//                     itemCount: data.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         focusColor: Colors.yellow,
//                         hoverColor: Colors.pink,
//                         leading: Text(
//                           data[index]["id"].toString(),
//                         ),
//                         title: Text(
//                           data[index]["category_name"]
//                               .toString(),
//                           style: TextStyle(
//                             color: Colors.black,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//         // This trailing comma makes auto-formatting nicer for build methods.
//       );
//     });
//   }
// }
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        if (!_scrollController.hasClients) {
          return;
        }
        final provider = Provider.of<Api>(context, listen: false);
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          provider.incrementPage();
          provider.getCategory(provider.page);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Api().getCategory(Provider.of<Api>(context).page),
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Error"));
          }

          return ListView.builder(
              controller: _scrollController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index]["id"]),
                    //subtitle: Text(dataToShow[index].ourPrice.toString()),
                  ),
                );
              });
        });
  }
}
