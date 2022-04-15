import 'dart:io';

import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/home/blocs/categoryBloc/category_bloc.dart';
import 'package:chart_ganga/modules/main/screens/main_screen_wrapper.dart';
import 'package:chart_ganga/modules/new_post/blocs/addNewPostBloc/addnewpost_bloc.dart';
import 'package:chart_ganga/modules/new_post/models/add_new_post_model.dart';
import 'package:chart_ganga/widgets/custom_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  File? selectedImage;
  late int categoryIndex;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _cotentController = TextEditingController();

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
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoryBloc()..add(GetAllCategoryForNewPostEvent()),
        ),
        BlocProvider(
          create: (context) => AddnewpostBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: Text(
            "Add new post",
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  EvaIcons.close,
                  color: CustomColors.black,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Cover Image",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      pickImageHandler();
                    },
                    child: Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: (selectedImage != null)
                              ? DecorationImage(
                                  image: FileImage(selectedImage!),
                                  fit: BoxFit.cover)
                              : null,
                          color: CustomColors.purpleLight,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          "Select Image",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Title",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                        fillColor: CustomColors.purpleLight,
                        filled: true,
                        hintText: "eg. Lorem ipsum dolor sit amet",
                        hintStyle: Theme.of(context).textTheme.bodyText2,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Category",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      return Container(
                        padding: EdgeInsets.only(left: 12, right: 8),
                        decoration: BoxDecoration(
                            color: CustomColors.purpleLight,
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton(
                            style: Theme.of(context).textTheme.headline3,
                            value: categoryIndex,
                            isExpanded: true,
                            underline: SizedBox(),
                            dropdownColor: CustomColors.purpleLight,
                            items: (state is GetAllCategorySuccessState)
                                ? state.categoryList
                                    .map(
                                      (data) => DropdownMenuItem(
                                          value: data.id,
                                          child: Text(
                                            data.name ?? "--",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          )),
                                    )
                                    .toList()
                                : [
                                    DropdownMenuItem(
                                        value: 0,
                                        child: Text(
                                          "Select a category",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ))
                                  ],
                            onChanged: (int? value) {
                              setState(() {
                                categoryIndex = value!;
                              });
                            }),
                      );
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Content",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    minLines: 14,
                    maxLines: 99,
                    controller: _cotentController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                        fillColor: CustomColors.purpleLight,
                        filled: true,
                        hintText: "Enter your content here...",
                        hintStyle: Theme.of(context).textTheme.bodyText2,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  BlocConsumer<AddnewpostBloc, AddnewpostState>(
                    listener: (context, state) {
                      if (state is AddNewPostFailedState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                      } else if (state is AddNewPostValidationErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                      } else if (state is AddNewPostSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Your post has been successfully uploaded.")));

                        Navigator.pushNamed(context, PROFILE_ROUTE);
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: "POST NOW",
                        isLoading: (state is AddNewPostLoadingState),
                        onTap: () {
                          context.read<AddnewpostBloc>().add(
                              AddNewPostAttemptEvent(
                                  addNewPostModel: AddNewPostModel(
                                      title: _titleController.text,
                                      content: _cotentController.text,
                                      categoryId: categoryIndex,
                                      image: selectedImage)));
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
