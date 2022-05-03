import 'dart:io';

import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/modules/profile/blocs/getProfileBloc/get_profile_bloc.dart';
import 'package:chart_ganga/modules/profile/blocs/update_profile_bloc/update_profile_bloc.dart';
import 'package:chart_ganga/modules/profile/models/profile_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/custom_colors.dart';
import '../../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? selectedImage;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  pickImageHandler() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File? croppedImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      print(croppedImage!.path.toString());
      setState(() {
        selectedImage = croppedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateProfileBloc(),
        ),
        BlocProvider(
          create: (context) => GetProfileBloc()..add(GetProfileAttempt()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: CustomColors.black),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: Text(
            "Profile Edit",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: BlocConsumer<GetProfileBloc, GetProfileState>(
          listener: ((context, state) {
            if (state is GetProfileSuccessState) {
              _firstnameController.text = state.profileModel.firstname ?? "";
              _lastnameController.text = state.profileModel.lastname ?? "";
            }
          }),
          builder: (context, state) {
            if (state is GetProfileSuccessState) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            pickImageHandler();
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    image: (selectedImage != null)
                                        ? DecorationImage(
                                            image: FileImage(selectedImage!),
                                            fit: BoxFit.cover)
                                        : (state.profileModel.cover_image_url !=
                                                null)
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(state
                                                    .profileModel
                                                    .cover_image_url!))
                                            : DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/images/profile_image.png")),
                                    borderRadius: BorderRadius.circular(99),
                                    color: CustomColors.white),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  child: Icon(
                                    EvaIcons.edit,
                                    color: CustomColors.purpleRegular,
                                  ),
                                  decoration: BoxDecoration(
                                      color: CustomColors.white,
                                      border: Border.all(
                                          width: 1,
                                          color: CustomColors.greyRegular),
                                      borderRadius: BorderRadius.circular(99)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "First name",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: CustomColors.purpleShadeLight, width: 1),
                            color: CustomColors.purpleLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Center(
                              child: TextField(
                                controller: _firstnameController,
                                style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    hintText: "First name",
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Last name",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: CustomColors.purpleShadeLight, width: 1),
                            color: CustomColors.purpleLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Center(
                              child: TextField(
                                controller: _lastnameController,
                                style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    hintText: "Last name",
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                        listener: (context, state) {
                          if (state is UpdateProfileSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Profile updated successfully."),
                            ));
                            Navigator.pushReplacementNamed(
                                context, PROFILE_ROUTE);
                          } else if (state is UpdateProfileFailedState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                            ));
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            text: "Update",
                            onTap: () {
                              context.read<UpdateProfileBloc>().add(
                                  UpdateProfileAttempt(
                                      profileModel: ProfileModel(
                                          cover_image: selectedImage,
                                          firstname: _firstnameController.text,
                                          lastname: _lastnameController.text)));
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: CustomColors.purpleRegular,
                  strokeWidth: 1,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
