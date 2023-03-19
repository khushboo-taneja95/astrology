import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/constant/colors.dart';
import 'package:login/models/user_profile.dart';
import 'package:login/network/api_service.dart';
import 'package:login/utils/utility.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController dobController = TextEditingController(text: '');
  TextEditingController timeOfBirthController = TextEditingController(text: '');
  TextEditingController cityOfBirthController = TextEditingController(text: '');
  String? gender;
  bool isChecked = false;
  bool loading = false;
  ApiService apiService = ApiService();

  var _image;

  showLoading() {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
  }

  hideLoading() {
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  initialize() async {
    try {
      showLoading();
      UserProfile response = await apiService.getUserProfile();
      hideLoading();
      setState(() {
        phoneController.text = response.phone!;
        nameController.text = response.name ?? '';
        gender = response.gender;
        dobController.text = response.dateOfBirth ?? '';
        cityOfBirthController.text = response.placeOfBirth ?? '';
        timeOfBirthController.text = response.timeOfBirth ?? '';
      });
    } catch (e) {
      devtools.log('$e');
      hideLoading();
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    dobController.dispose();
    timeOfBirthController.dispose();
    cityOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              editProfile(),
            ],
          );
  }

  Widget editProfile() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Personal Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              profile(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          controller: phoneController,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              borderSide: BorderSide(
                                color: AstroColors.colorLightGrey,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 5.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AstroColors.colorLightGrey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            hintText: '  Mobile Number',
                            hintStyle: hintStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: InkResponse(
              //     onTap: () {},
              //     child: Row(
              //       children: [
              //         Expanded(
              //             child: TextField(
              //           decoration: InputDecoration(
              //             enabledBorder: const OutlineInputBorder(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(15.0)),
              //               borderSide: BorderSide(
              //                   color: AstroColors.colorLightGrey, width: 1.0),
              //             ),
              //             border: OutlineInputBorder(
              //                 borderSide: const BorderSide(
              //                     width: 5.0, style: BorderStyle.solid),
              //                 borderRadius: BorderRadius.circular(50.0)),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                   color: AstroColors.colorLightGrey, width: 2.0),
              //               borderRadius: BorderRadius.circular(50.0),
              //             ),
              //             hintText: '  Email',
              //             hintStyle: const TextStyle(
              //                 color: Colors.grey, fontWeight: FontWeight.bold),
              //           ),
              //         )),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              borderSide: BorderSide(
                                  color: AstroColors.colorLightGrey,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 5.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AstroColors.colorLightGrey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            hintText: '  Name',
                            hintStyle: hintStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    groupValue: gender,
                    fillColor: radioStates(),
                    value: 'Male',
                    onChanged: (String? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  const Text('Male'),
                  const SizedBox(
                    width: 40,
                  ),
                  Radio(
                    groupValue: gender,
                    fillColor: radioStates(),
                    value: 'Female',
                    onChanged: (String? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: dobController,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              borderSide: BorderSide(
                                color: AstroColors.colorLightGrey,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 5.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AstroColors.colorLightGrey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            hintText: '  Date of Birth',
                            hintStyle: hintStyle(),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime selectedDate =
                                dobController.text.isNotEmpty
                                    ? DateTime.parse(dobController.text)
                                    : DateTime.now();
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(1970),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(
                                pickedDate,
                              );

                              setState(() {
                                dobController.text = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cityOfBirthController,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              borderSide: BorderSide(
                                color: AstroColors.colorLightGrey,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 5.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AstroColors.colorLightGrey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            hintText: '  City Of Birth',
                            hintStyle: hintStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: timeOfBirthController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            borderSide: BorderSide(
                              color: AstroColors.colorLightGrey,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 5.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AstroColors.colorLightGrey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: '  Time Of Birth',
                          hintStyle: hintStyle(),
                        ),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: selectedTimeOfDay(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            DateTime parsedTime = DateFormat.jm().parse(
                              pickedTime.format(context).toString(),
                            );
                            String formattedTime = DateFormat('HH:mm').format(
                              parsedTime,
                            );

                            setState(() {
                              timeOfBirthController.text = formattedTime;
                            });
                          }
                        },
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 40,
                            left: 40,
                            bottom: 20,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AstroColors.appColor,
                            ),
                            onPressed: updateProfile,
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                color: AstroColors.aboutUsCardBackgroud,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle hintStyle() {
    return const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
    );
  }

  Widget profile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () {
                // handleCameraPermission();
              },
              child: CircleAvatar(
                child: Image.asset('assets/ic_contact.png'),
                backgroundColor: AstroColors.appColor,
              ),
            ),
            // Positioned(
            //   right: -16,
            //   bottom: 0,
            //   child: SizedBox(
            //     height: 46,
            //     width: 46,
            //     child: TextButton(
            //       style: TextButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(50),
            //           side: const BorderSide(color: Colors.white),
            //         ),
            //         primary: Colors.white,
            //         backgroundColor: const Color(0xFFF5F6F9),
            //       ),
            //       onPressed: () {},
            //       child: SvgPicture.asset("assets/ic_camera.svg"),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  radioStates() {
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.red;
      } else if (states.contains(MaterialState.disabled)) {
        return Colors.grey.withOpacity(.5);
      }
    });
  }

  updateProfile() async {
    try {
      showLoading();
      UserProfile data = UserProfile(
        name: nameController.text,
        gender: gender,
        dateOfBirth: dobController.text,
        placeOfBirth: cityOfBirthController.text,
        timeOfBirth: timeOfBirthController.text,
      );

      dynamic response = await apiService.updateUserProfile(data);

      Utility.showToast(
        msg: 'Your profile has been updated successfully',
      );
      hideLoading();
    } catch (e) {
      devtools.log('$e');
      hideLoading();
      Utility.showToast(
        msg: 'Error while updating your profile, please try again later.',
      );
    }
  }

  TimeOfDay selectedTimeOfDay() {
    if (timeOfBirthController.text.isNotEmpty &&
        timeOfBirthController.text.contains(':')) {
      return TimeOfDay(
          hour: int.parse(timeOfBirthController.text.split(':')[0]),
          minute: int.parse(timeOfBirthController.text.split(':')[1]));
    }
    return TimeOfDay.now();
  }
}
