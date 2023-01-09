import 'package:flutter/material.dart';
import 'package:images/Image_controller.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
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

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () {},
            child: Text('My Arts'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                                imageText: _imageTextController.text.trim(),
                                size: '',
                              );
                            },
                            child: Text('Create'));
                  })
                ],
              ),
              SizedBox(
                height: 30,
              ),

              
              Obx(() {
                return _imageController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: _imageController.data.value.isNotEmpty
                                    ? NetworkImage(_imageController.data.value)
                                    : NetworkImage(''))),
                      );
              }),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton.icon(
                    icon: Icon(Icons.download_for_offline_rounded),
                    onPressed: () {},
                    label: Text('Download'),
                  )),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                    label: Text('Shares wewe'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
