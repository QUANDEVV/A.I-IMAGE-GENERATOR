import 'package:flutter/material.dart';
import 'package:images/Image_controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Images(),
    );
  }
}

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  final ImageController _imageController = Get.put(ImageController());
  final TextEditingController _imageTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _imageTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Image",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 20,
                ),
                Obx(() {
                  return _imageController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await _imageController.getImage(
                              imageText: _imageTextController.text.trim(), size: '',
                            );
                          },
                          child: Text('Create'));
                })
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Obx( ()  {
                return _imageController.isLoading.value  ? 
                const Center(
                  child: CircularProgressIndicator(),
                ) :
                
                 Container(
                  width: double.infinity,
                  height: 300,
                 decoration: BoxDecoration(
                  image: DecorationImage(
                  image: _imageController.data.value.isNotEmpty ? NetworkImage(_imageController.data.value) : NetworkImage('') )),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
