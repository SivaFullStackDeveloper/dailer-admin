/*

import 'dart:convert';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio; // Import dio as dio to avoid conflicts with html.File
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'error.dart';

*//*

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController webLinkController = TextEditingController();
  final TextEditingController alternateNumberController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  List<PlatformFile>? _imageFile;

 List<PlatformFile>? _paths;

  void _uploadProfilePicture() async {

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
    } on PlatformException catch (e) {

    } catch (e) {

    }
    setState(() {
      if (_paths != null) {
        if (_paths != null) {
          //passing file bytes and file name for API call
          //ApiClient.uploadFile(_paths!.first.bytes!, _paths!.first.name);
        }
      }
    });
  }

  void _submitForm(List<int> fileBytes, String fileName) async {
    LoadingIndicatorPopup.show(context,true);
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    final apiUrl = '${baseUrl}auth/register';
print(apiUrl);
    try {

      FormData formData = FormData.fromMap({
        'name': nameController.text,
        'email': emailController.text,
        'pinCode': pinCodeController.text,
        'phoneNumber': phoneNumberController.text,
        'password': passwordController.text,
        'state': stateController.text,
        'district': districtController.text,
        'city': cityController.text,
        'webLink': webLinkController.text,
        'alternateNumber': alternateNumberController.text,
        'jobTitle': jobTitleController.text,
        'companyName': companyNameController.text,
      });
      // Add form fields


      // Add image file if available
      if (fileBytes != null) {
        formData.files.add(MapEntry(
          'profilePicture',
          await MultipartFile.fromBytes(
            fileBytes,
            filename: fileName,
          ),
        ));
      }

      // Make the Dio API call
      final response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(

          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ),
      );
print(response.statusCode);
      // Handle the response
      if (response.statusCode == 201) {
        LoadingIndicatorPopup.show(context,false);
        print(response);
      } else {
        LoadingIndicatorPopup.show(context,false);
        ErrorDialog.show(context,'Failed to submit form. Status code: ${response}');
        print('Failed to submit form. Status code: ${response}');
      }
    } catch (error) {
      LoadingIndicatorPopup.show(context,false);
      ErrorDialog.show(context,'Error during API request: $error');
      print('Error during API request: $error');
    }
  }


  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 132.00,
                  width: 327.00,
                  margin: const EdgeInsets.only(
                    left: 10.00,
                    top: 24.00,
                    right: 10.00,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _paths != null
                          ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100.00,
                          width: 100.00,
                          margin: const EdgeInsets.only(
                            left: 113.00,
                            top: 10.00,
                            right: 113.00,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                50.00,
                              ),
                              image: DecorationImage(
                                  image: MemoryImage(_paths!
                                      .first.bytes!))),
                        ),
                      )
                          : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100.00,
                          width: 100.00,
                          margin: const EdgeInsets.only(
                            left: 113.00,
                            top: 10.00,
                            right: 113.00,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius:
                              BorderRadius.circular(
                                50.00,
                              ),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/profile.png'))),
                        ),
                      ),
                      InkWell(
                        onTap: _uploadProfilePicture,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 30.00,
                            width: 30.00,
                            margin: const EdgeInsets.only(
                              left: 183.00,
                              top: 10.00,
                              right: 113.00,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(
                                5.00,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),]),
                // Add other form fields...
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: pinCodeController,
                  decoration: InputDecoration(labelText: 'Pin Code'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: stateController,
                  decoration: InputDecoration(labelText: 'State'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: districtController,
                  decoration: InputDecoration(labelText: 'District'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: webLinkController,
                  decoration: InputDecoration(labelText: 'Web Link'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: alternateNumberController,
                  decoration: InputDecoration(labelText: 'Alternate Number'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: jobTitleController,
                  decoration: InputDecoration(labelText: 'Job Title'),
                  validator: (value) => _validateRequired(value),
                ),
                TextFormField(
                  controller: companyNameController,
                  decoration: InputDecoration(labelText: 'Company Name'),
                  validator: (value) => _validateRequired(value),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_paths == null) {
                      ErrorDialog.show(context, 'Please upload a profile picture');
                    }
                    if (_formKey.currentState?.validate() ?? false) {
                      _submitForm(_paths![0].bytes!, _paths![0].name);
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
/*

*/
