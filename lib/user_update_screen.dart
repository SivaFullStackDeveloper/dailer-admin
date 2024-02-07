import 'package:dailer_admin/api/get.dart';
import 'package:dailer_admin/api/update.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'api/delete.dart';
import 'api/post.dart';
import 'api/state_provider.dart';
import 'error.dart';
import 'models/user_details.dart';
import 'dart:typed_data';

class UserProfileForm extends StatefulWidget {
  final List<CombinedUserData> user;

  UserProfileForm({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  List<PlatformFile>? _paths;
  late TextEditingController _nameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _companyNameController;
  late TextEditingController _emailController;
  late TextEditingController _alternateNumberController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _webLinkController;
  late TextEditingController _cityController;
  late TextEditingController _districtController;
  late TextEditingController _stateController;
  late TextEditingController _pinCodeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user[0].user.name);
    _jobTitleController =
        TextEditingController(text: widget.user[0].user.jobTitle);
    _companyNameController =
        TextEditingController(text: widget.user[0].user.companyName);
    _emailController = TextEditingController(text: widget.user[0].user.email);
    _alternateNumberController =
        TextEditingController(text: widget.user[0].user.alternateNumber);
    _phoneNumberController =
        TextEditingController(text: widget.user[0].user.phoneNumber.toString());
    _webLinkController =
        TextEditingController(text: widget.user[0].user.webLink);
    _cityController = TextEditingController(text: widget.user[0].user.city);
    _districtController =
        TextEditingController(text: widget.user[0].user.district);
    _stateController = TextEditingController(text: widget.user[0].user.state);
    _pinCodeController =
        TextEditingController(text: widget.user[0].user.pinCode);
  }

  // ... (rest of the code)

  @override
  Widget build(BuildContext context) {
    var stateProvider = Provider.of<StateProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            onPressed: () {
              // Handle the save button press
              saveChanges();
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            profilePicture(),
                _buildTextField('Name', _nameController),
                _buildTextField('Job Title', _jobTitleController),
                _buildTextField('Company Name', _companyNameController),
                _buildTextField('Email', _emailController),
                _buildTextField('Alternate Number', _phoneNumberController),
                _buildTextField('Alternate Number', _alternateNumberController),
                _buildTextField('Web Link', _webLinkController),
                _buildTextField('City', _cityController),
                _buildTextField('District', _districtController),
                _buildTextField('State', _stateController),
                _buildTextField('Pin Code', _pinCodeController),
            // Add text fields for other String fields as needed
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Business Register',style: TextStyle(),),
                  Text(widget.user[0].user.businessRegister==true?"Already Registerd":"Not Registered",
                    style: TextStyle(fontWeight: FontWeight.bold,color: widget.user[0].user.businessRegister==true?Colors.green:Colors.red),),

                ],
              ),
            ),

            _buildSwitch('User Blocked', widget.user[0].user.userBlocked,
                (value) {
              // Handle switch changes
              setState(() {
                widget.user[0].user.userBlocked = value;
              });
            }),
            _buildSwitch('Active', widget.user[0].user.active, (value) {
              // Handle switch changes
              setState(() {
                widget.user[0].user.active = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
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

  void saveChanges() async{
var jsn = {
  "id":widget.user[0].user.id,
  "name": _nameController.text,
  "email": _emailController.text,
  "pinCode": _pinCodeController.text,
  "jobTitle": _jobTitleController.text,
  "companyName": _companyNameController.text,
  "phoneNumber": _phoneNumberController.text,
  "state": _stateController.text,
  "district": _districtController.text,
  "city": _cityController.text,
  "webLink": _webLinkController.text,
  "alternateNumber": _alternateNumberController.text,
  "profilePicture":widget.user[0].user.profilePicture,
  "businessRegister": widget.user[0].user.businessRegister,
  "userBlocked": widget.user[0].user.userBlocked,
  "active": widget.user[0].user.active
};
var data = await UpdateApi().updateUser(jsn,context).then((n){
   GetApi().fetchUserData(phoneNumber: widget.user[0].user.phoneNumber,context:context);
});
print(data);
  }

  profilePicture() {
    return Container(
      height: 150.00,
      width: 150.00,
      margin: const EdgeInsets.only(
        left: 10.00,
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
                      widget.user[0].user.profilePicture,
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
    );
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
      ErrorDialog.show(context,"Failed to upload"+e.toString());
    } catch (e) {
      ErrorDialog.show(context,"Failed to upload"+e.toString());
      print(e.toString());
    }

      if (_paths != null) {
        if (_paths != null) {
        var data =   await PostApi().uploadFile(_paths!.first.bytes!, _paths!.first.name,context);
        var imageList = UploadResponse.fromJson(data);
        setState(() {
          widget.user[0].user.profilePicture =imageList.data[0];
        });

        }
      }

  }
}

class BusinessProfileScreen extends StatefulWidget {
  final BusinessUser userData;
  final User userData1;

  const BusinessProfileScreen({Key? key, required this.userData,required this.userData1})
      : super(key: key);

  @override
  _BusinessProfileScreenState createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
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
    print(widget.userData1.businessRegister);
if(widget.userData1.businessRegister==false){
    _phoneNum1Controller.text = widget.userData1.phoneNumber.toString() ?? '';
    _phoneNumAlternativeController.text = widget.userData1.alternateNumber ?? '';
    _cityNameController.text = widget.userData1.city;
    _stateNameController.text = widget.userData1.state ?? '';
    _pinCodeController.text = widget.userData1.pinCode ?? '';
    _mailIdController.text = widget.userData1.email ?? '';

}else if (widget.userData1.businessRegister==true){
print(widget.userData.businessName);
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
  _pinCodeController.text = widget.userData.PinCode ?? '';
  _isLoggedInController.text = widget.userData.isLoggedIn ?? '';
  _webLinkController.text = widget.userData.WebLink ?? '';
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
  _createdAtController.text = widget.userData.createdAt ?? '';
  _updatedAtController.text = widget.userData.updatedAt ?? '';
  _vController.text = widget.userData.v.toString() ?? '';
  _mailIdController.text = widget.userData.mailId ?? '';

  setState(() {

  });
}
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
                    "userId":widget.userData1.id,
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
                GetApi().fetchUserData(phoneNumber: widget.userData1.phoneNumber,context:context);

              });
              print(data);
            },
            child: Text(widget.userData1.businessRegister==true
                ? 'Update Business Profile'
                : 'create business Profile'),
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

