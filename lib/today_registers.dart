import 'package:dailer_admin/api/state_provider.dart';
import 'package:dailer_admin/user_deatils_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'api/delete.dart';
import 'api/get.dart';
import 'api/post.dart';
import 'error.dart';
import 'models/businessUserByDate.dart';


class AllUserScrees extends StatefulWidget {
  const AllUserScrees({super.key});

  @override
  State<AllUserScrees> createState() => _AllUserScreesState();
}

class _AllUserScreesState extends State<AllUserScrees> {
  List<Widget> screens = [
BusinessUserRegistrationScreen(),
BusinessUserRegistrationScreen(),
    UserDetails(),
    //RemoveUserFromGroupScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StateProvider>(

        builder: (context,value,child) {
          return Column(
            children: [
              Container(height:55,color: Colors.deepOrange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child:  Text(
                        'Registered users',
                        style: TextStyle(
                          color: value.userIndex == 0 ?Colors.white : Colors.black,
                        ),
                      ),
                      onTap: () {
                        value.dashBoardUpdate2(0);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child:  Text(
                        'Registered Business Users',
                        style: TextStyle(
                          color: value.userIndex == 1 ?Colors.white : Colors.black,
                        ),
                      ),
                      onTap: () {
                        value.dashBoardUpdate2(1);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child:  Text(
                        'Search Users By Number',
                        style: TextStyle(
                          color: value.userIndex == 2 ?Colors.white : Colors.black,
                        ),
                      ),
                      onTap: () {
                        value.dashBoardUpdate2(2);
                      },
                    ),
                  ),

                          ],
              ),
              ),
              Expanded(flex: 3,child:Consumer<StateProvider>(
                  builder: (BuildContext context,value, Widget? child) {

                    return screens[value.userIndex];}),)
            ],
          );
        }
      ),
    );
  }
}










class BusinessUserRegistrationScreen extends StatefulWidget {
  @override
  _BusinessUserRegistrationScreenState createState() => _BusinessUserRegistrationScreenState();
}

class _BusinessUserRegistrationScreenState extends State<BusinessUserRegistrationScreen> {
  DateTime? selectedDate;
  DateTimeRange? selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
        print('Start Date: ${selectedDateRange!.start}');
        print('End Date: ${selectedDateRange!.end}');
      });

      // You can use the start and end dates in your logic.
      Provider.of<StateProvider>(context, listen: false).getBusinessByDate(
        _formatDate(selectedDateRange!.start),
        _formatDate(selectedDateRange!.end),
        context,
      );
    }
  }



  String _formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('yyyy-MM-dd').format(date);
    } else {
      return 'No date selected';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<StateProvider>(
          builder:(context,value,child){
            return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
            'Select Registration Date:',
            style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton(
            onPressed: () => _selectDateRange(context),
            child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            selectedDate != null
            ? Text(
            'Selected Date: ${_formatDate(selectedDate)}',
            style: TextStyle(fontSize: 16),
            )
                : Container(),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<StateProvider>(builder: (context,value,child){
                 return ListView.builder(
                shrinkWrap: true,
                  itemCount:value.user.length,
              itemBuilder: (context,i){
                return    _buildUserCard2(context,value.user);

              });}))
            ],
            );

          },

        ),
      ),
    );
  }
  Widget _buildUserCard2(BuildContext context, List<Datum> businessUser) {
    return Card(
        margin: EdgeInsets.all(8.0),
        child:  ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(businessUser[0].businessProfilePhoto??'https://dailer-backend.onrender.com/uploads/profile.png'),
          ),
          title: Text(businessUser[0].businessName??''),
          subtitle: Text(businessUser[0].phoneNum1.toString()??""),
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessProfileScreen2( userData: businessUser[0],),
              ),
            );
          },
        ));
  }
}




class BusinessProfileScreen2 extends StatefulWidget {
  final Datum userData;


  const BusinessProfileScreen2({Key? key, required this.userData})
      : super(key: key);

  @override
  _BusinessProfileScreen2State createState() => _BusinessProfileScreen2State();
}

class _BusinessProfileScreen2State extends State<BusinessProfileScreen2> {
  // Initialize controllers for each field
  TextEditingController businessName = TextEditingController();
  TextEditingController _viwersCountController = TextEditingController();
  TextEditingController _phoneNum1Controller = TextEditingController();
  TextEditingController _phoneNumAlternativeController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _cityNameController = TextEditingController();
  TextEditingController _stateNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _subcategoriesController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _isLoggedInController = TextEditingController();
  TextEditingController _webLinkController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();
  TextEditingController _paymentsAcceptedController = TextEditingController();
  TextEditingController _yearOfEstablishmentController = TextEditingController();
  TextEditingController _businessAboutUsController = TextEditingController();
  TextEditingController _workingHoursController = TextEditingController();
  TextEditingController _keyWordsController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _socialMediaLinkController = TextEditingController();
  TextEditingController _languageSpokenController = TextEditingController();
  TextEditingController _parkingAvilbilityController = TextEditingController();
  TextEditingController _videoTestimonsController = TextEditingController();
  TextEditingController _numberOfStaffController = TextEditingController();
  TextEditingController _achivementsAwardsController = TextEditingController();
  TextEditingController _fastResponseTimeController = TextEditingController();
  TextEditingController _currentResponseTimeController =
  TextEditingController();
  TextEditingController _getDicrectionController = TextEditingController();
  TextEditingController _holidaysController = TextEditingController();
  var _ratingAndCommentsController = [];
  TextEditingController _createdAtController = TextEditingController();
  TextEditingController _updatedAtController = TextEditingController();
  TextEditingController _vController = TextEditingController();
  TextEditingController _mailIdController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<PlatformFile>? _paths;
  List<PlatformFile>? _paths2;
  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {

      businessName.text = widget.userData.businessName;
      _viwersCountController.text = widget.userData.viwersCount.toString();
      _phoneNum1Controller.text = widget.userData.phoneNum1 ?? '';
      _phoneNumAlternativeController.text =
          widget.userData.phoneNumAlternative ?? '';
      _cityNameController.text = widget.userData.cityName ?? '';
      _stateNameController.text = widget.userData.stateName ?? '';
      _addressController.text = widget.userData.address ?? '';
      _categoryController.text = widget.userData.category ?? '';
      _subcategoriesController.text = widget.userData.subcategories ?? '';
      _pinCodeController.text = widget.userData.pinCode ?? '';
      _isLoggedInController.text = widget.userData.isLoggedIn ?? '';
      _webLinkController.text = widget.userData.webLink ?? '';
      _ratingController.text = widget.userData.rating.toString() ?? '';
      _paymentsAcceptedController.text = widget.userData.paymentsAccepted ?? '';
      _yearOfEstablishmentController.text =
          widget.userData.yearOfEstablishment ?? '';
      _businessAboutUsController.text = widget.userData.businessAboutUs ?? '';
      _workingHoursController.text = widget.userData.workingHours ?? '';
      _keyWordsController.text = widget.userData.keyWords ?? '';
      _locationController.text = widget.userData.location ?? '';
      _socialMediaLinkController.text = widget.userData.socialMediaLink ?? '';
      _languageSpokenController.text = widget.userData.languageSpoken ?? '';
      _parkingAvilbilityController.text = widget.userData.parkingAvilbility ?? '';
      _videoTestimonsController.text = widget.userData.videoTestimons ?? '';
      _numberOfStaffController.text = widget.userData.numberOfStaff ?? '';
      _achivementsAwardsController.text = widget.userData.achivementsAwards ?? '';
      _fastResponseTimeController.text =
          widget.userData.fastResponseTime.toString() ?? '';
      _currentResponseTimeController.text =
          widget.userData.currentResponseTime.toString() ?? '';
      _getDicrectionController.text = widget.userData.getDicrection ?? '';
      _holidaysController.text =
      widget.userData.holidays.isNotEmpty ? widget.userData.holidays[0] : '';
      _ratingAndCommentsController = widget.userData.ratingAndComments ?? [];
      _vController.text = widget.userData.v.toString() ?? '';
      _mailIdController.text = widget.userData.mailId ?? '';

      setState(() {

      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Profile'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            onPressed: ()async {
              var data = await PostApi().updateBusinessUser(
                  {
                    "userId":widget.userData.id,
                    "businessName": businessName.text,
                    "mailId": _mailIdController.text,
                    "phoneNum1": _phoneNum1Controller.text,
                    "phoneNumAlternative": _phoneNumAlternativeController.text,
                    "district": _districtController.text,
                    "cityName": _cityNameController.text,
                    "stateName": _stateNameController.text,
                    "address": _addressController.text,
                    "category": _categoryController.text,
                    "subcategories": _subcategoriesController.text,
                    "PinCode": _pinCodeController.text,
                    "isLoggedIn": _isLoggedInController.text,
                    "WebLink": _webLinkController.text,
                    "businessCoverPhoto": widget.userData.businessCoverPhoto,
                    "businessProfilePhoto": widget.userData.businessProfilePhoto,
                    "businessGallery":widget.userData.businessGallery,
                    "rating":_ratingController.text,
                    "paymentsAccepted": _paymentsAcceptedController.text,
                    "yearOfEstablishment": _yearOfEstablishmentController.text,
                    "businessAboutUs": _businessAboutUsController.text,
                    "workingHours": _workingHoursController.text,
                    "keyWords": _keyWordsController.text,
                    "location": _locationController.text,
                    "socialMediaLink": _socialMediaLinkController.text,
                    "languageSpoken":_languageSpokenController.text,
                    "parkingAvilbility": _parkingAvilbilityController.text,
                    "videoTestimons": _videoTestimonsController.text,
                    "numberOfStaff": _numberOfStaffController.text,
                    "achivementsAwards": _achivementsAwardsController.text,
                    "fastResponseTime": _fastResponseTimeController.text,
                    "getDicrection": _getDicrectionController.text,
                    "verified": widget.userData.verified,
                    "holidays": _holidaysController.text
                  }
                  ,context).then((v){
                GetApi().fetchUserData(phoneNumber: int.parse(widget.userData.phoneNum1),context:context);

              });
              print(data);
            },
            child: Text('Update Business Profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Business profile picture'),
                  profilePicture(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Business cover picture'),
                  profilePicture2(),
                ],
              ),

              ImageUploadWidget(galleryImages: widget.userData.businessGallery,),
              // Add TextFormFields for user data

              Text('Business Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildTextField('business name', businessName),
              _buildTextField('Mail Id', _mailIdController),
              _buildTextField('Viwers Count', _viwersCountController),
              _buildTextField('Phone Number 1', _phoneNum1Controller),
              _buildTextField('Phone Number Alternative', _phoneNumAlternativeController),
              _buildTextField('City Name', _cityNameController),
              _buildTextField('State Name', _stateNameController),
              _buildTextField('Address', _addressController),
              _buildTextField('Category', _categoryController),
              _buildTextField('Subcategories', _subcategoriesController),
              _buildTextField('Pin Code', _pinCodeController),
              _buildTextField('Is Logged In', _isLoggedInController),
              _buildTextField('Web Link', _webLinkController),
              _buildTextField('Rating', _ratingController),
              _buildTextField('Payments Accepted', _paymentsAcceptedController),
              _buildTextField(
                  'Year of Establishment', _yearOfEstablishmentController),
              _buildTextField('Business About Us', _businessAboutUsController),
              _buildTextField('Working Hours', _workingHoursController),
              _buildTextField('Key Words', _keyWordsController),
              _buildTextField('Location', _locationController),
              _buildTextField('Social Media Link', _socialMediaLinkController),
              _buildTextField('Language Spoken', _languageSpokenController),
              _buildTextField(
                  'Parking Availability', _parkingAvilbilityController),
              _buildTextField('Video Testimonials', _videoTestimonsController),
              _buildTextField('Number of Staff', _numberOfStaffController),
              _buildTextField(
                  'Achievements and Awards', _achivementsAwardsController),
              _buildTextField(
                  'Fast Response Time', _fastResponseTimeController),
              _buildTextField(
                  'Current Response Time', _currentResponseTimeController),
              _buildTextField('Get Direction', _getDicrectionController),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSwitch('Verified', widget.userData.verified,
                        (value) {
                      // Handle switch changes
                      setState(() {
                        widget.userData.verified = value;
                      });
                    }),
              ),
              _buildTextField('Holidays', _holidaysController),
              Text("Ratings and comments",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search comments...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  setState(() {
                    // Trigger a rebuild when the user types to update the displayed list
                  });
                },
              ),

              widget.userData.ratingAndComments.isEmpty?Center(child: Text("No Ratings and comments",style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),)) : ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.userData.ratingAndComments.length??0,
                  itemBuilder: (context,i){

                    return Card(
                      elevation: 4.0, // Set the elevation value as needed
                      child:ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child:Image.network(
                            widget.userData.ratingAndComments[i].profilePicture,
                            errorBuilder: (context, error, stackTrace) {
                              // Error occurred, show fallback image
                              return Image.network(
                                'https://dailer-backend.onrender.com/uploads/profile.png',
                                fit: BoxFit.cover, // Adjust the BoxFit property as needed
                              );
                            },
                          ),
                        ),

                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name: " + widget.userData.ratingAndComments[i].userName),
                            Text("Rating: " + widget.userData.ratingAndComments[i].rating.toString()),
                            Text("Comment " + widget.userData.ratingAndComments[i].comment),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{
                            await DeleteApi().deleteRatingAndComment(context, widget.userData.id, widget.userData.ratingAndComments[i].userId);
                            setState(() {
                              widget.userData.ratingAndComments.removeAt(i);
                            });
                          },
                        ),),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
  Widget _buildTextField(String label, TextEditingController controller) {
    final FocusNode _focusNode = FocusNode();
    Color _borderColor = Colors.transparent;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _borderColor, width: 2),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            label: Text(label),
          ),
          onTap: () {
            setState(() {
              _borderColor = Colors.orange;
            });
          },
          onEditingComplete: () {
            setState(() {
              _borderColor = Colors.transparent;
            });
          },
        ));
  }
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
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    if (_paths != null) {
      if (_paths != null) {
        var data =   await PostApi().uploadFile(_paths!.first.bytes!, _paths!.first.name,context);
        var imageList = UploadResponse.fromJson(data);
        setState(() {
          widget.userData.businessProfilePhoto =imageList.data[0];
        });
      }
    }

  }
  void _uploadProfilePicture2() async {
    try {
      _paths2 = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    if (_paths != null) {
      if (_paths != null) {
        var data =   await PostApi().uploadFile(_paths!.first.bytes!, _paths!.first.name,context);
        var imageList = UploadResponse.fromJson(data);
        setState(() {
          widget.userData.businessCoverPhoto =imageList.data[0];
        });
      }
    }

  }
  profilePicture() {
    return Row(
      children: [
        Stack(
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
                    borderRadius: BorderRadius.circular(
                      50.00,
                    ),
                    image: DecorationImage(
                        image: MemoryImage(_paths!.first.bytes!))),
              ),
            )
                : Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150.00,
                width: 150.00,
                margin: const EdgeInsets.only(
                  left: 113.00,
                  top: 10.00,
                  right: 113.00,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(
                    100.00,
                  ),
                ),
                child: Image.network(
                  widget.userData.businessProfilePhoto,
                  errorBuilder: (context, error, stackTrace) {
                    // Error occurred, show fallback image
                    return Image.network(
                      'https://dailer-backend.onrender.com/uploads/profile.png',
                      fit: BoxFit.cover, // Adjust the BoxFit property as needed
                    );
                  },
                ),

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


      ],
    );
  }
  profilePicture2() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [

            _paths2 != null
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
                    borderRadius: BorderRadius.circular(
                      50.00,
                    ),
                    image: DecorationImage(
                        image: MemoryImage(_paths2!.first.bytes!))),
              ),
            )
                : Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150.00,
                width: 150.00,
                margin: const EdgeInsets.only(
                  left: 113.00,
                  top: 10.00,
                  right: 113.00,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(
                    100.00,
                  ),
                ),
                child: Image.network(
                  widget.userData.businessCoverPhoto,
                  errorBuilder: (context, error, stackTrace) {
                    // Error occurred, show fallback image
                    return Image.network(
                      'https://dailer-backend.onrender.com/uploads/profile.png',
                      fit: BoxFit.cover, // Adjust the BoxFit property as needed
                    );
                  },
                ),

              ),
            ),
            InkWell(
              onTap: _uploadProfilePicture2,
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
      ],
    );
  }
}






class ImageUploadWidget extends StatefulWidget {
  var galleryImages;
  ImageUploadWidget({super.key,required this.galleryImages});


  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  List<PlatformFile>? _paths;

  void _uploadProfilePicture() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      ErrorDialog.show(context,"Failed to upload"+e.toString());
    } catch (e) {
      ErrorDialog.show(context,"Failed to upload"+e.toString());
      print(e.toString());
    }

    if (_paths != null) {
      if (_paths != null) {
        for(var i =0; i<_paths!.length;i++){
          var data =   await PostApi().uploadFile( _paths![i].bytes!, _paths![i].name,context);
          var imageList = UploadResponse.fromJson(data);
          setState(() {
            widget.galleryImages.add(imageList.data[0]);
          });

        }

      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageList(),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _uploadProfilePicture,
          child: Text('Pick Multiple Images For Business Pictures'),
        ),
      ],
    );
  }

  Widget _buildImageList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.galleryImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Image.network(
                  widget.galleryImages[index],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Error occurred, show fallback image
                    return Image.network(
                      'https://dailer-backend.onrender.com/uploads/profile.png',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,// Adjust the BoxFit property as needed
                    );
                  },
                ),
                TextButton(onPressed: (){
                  setState((){
                    widget.galleryImages.remove( widget.galleryImages[index]);
                  });

                }, child: Text("remove"))
              ],
            ),
          );
        },
      ),
    );
  }
}



class UploadResponse {
  final bool success;
  final List<String> data;
  final String message;

  UploadResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      success: json['success'] ?? false,
      data: List<String>.from(json['data'] ?? []),
      message: json['message'] ?? '',
    );
  }
}













