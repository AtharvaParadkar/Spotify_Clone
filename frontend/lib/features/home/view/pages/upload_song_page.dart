import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/theme/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:frontend/core/utils.dart';
import 'package:frontend/core/widgets/custom_field.dart';
import 'package:frontend/core/widgets/loader.dart';
import 'package:frontend/features/home/view/pages/home_page.dart';
import 'package:frontend/features/home/view/widgets/audio_wave.dart';
import 'package:frontend/features/home/viewmodel/home_viewmodel.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  final fromKey = GlobalKey<FormState>();

  void selectAudio() async {
    final pickedAudio = await Utils.pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await Utils.pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    songNameController.dispose();
    artistController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      homeViewModelProvider.select((val) => val?.isLoading == true),
    );

    ref.listen(homeViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          Utils.showSnackBar(
            context,
            'Song uploaded successfully!',
            Colors.greenAccent,
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (_) => false,
          );
        },
        error: (error, st) {
          Utils.showSnackBar(context, error.toString(), Colors.deepOrange);
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Song'),
        actions: [
          IconButton(
            onPressed: () async {
              if (fromKey.currentState!.validate() &&
                  selectedAudio != null &&
                  selectedImage != null) {
                ref
                    .read(homeViewModelProvider.notifier)
                    .uploadSong(
                      selectedAudio: selectedAudio!,
                      selectedThumbnail: selectedImage!,
                      songName: songNameController.text,
                      artist: artistController.text,
                      selectedColor: selectedColor,
                    );
              } else {
                Utils.showSnackBar(
                  context,
                  "Fill all the fileds",
                  Colors.deepOrange,
                );
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: isLoading
          ? Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: fromKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: selectImage,
                        child: selectedImage != null
                            ? SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : DottedBorder(
                                color: const Color.fromARGB(255, 189, 187, 214),
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                child: const SizedBox(
                                  width: double.infinity,
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.folder_open, size: 40),
                                      SizedBox(height: 15),
                                      Text(
                                        "Select the thumbnail for your song",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 40),
                      selectedAudio != null
                          ? AudioWave(path: selectedAudio!.path)
                          : CustomField(
                              hintText: 'Pick a Song',
                              controller: null,
                              readOnly: true,
                              onTap: selectAudio,
                            ),
                      const SizedBox(height: 20),
                      CustomField(
                        hintText: 'Artist',
                        controller: artistController,
                      ),
                      const SizedBox(height: 20),
                      CustomField(
                        hintText: 'Song Name',
                        controller: songNameController,
                      ),
                      const SizedBox(height: 20),
                      ColorPicker(
                        pickersEnabled: const {
                          ColorPickerType.accent: false,
                          ColorPickerType.primary: false,
                          ColorPickerType.wheel: true,
                        },
                        onColorChanged: (Color color) =>
                            setState(() => selectedColor = color),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
