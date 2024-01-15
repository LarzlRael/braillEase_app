import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as ProviderState;

import '../env/environment_variables.dart';
import '../provider/providers.dart';
import '../router/app_router.dart';
import '../utils/utils.dart';

part 'simple_text.dart';
part './cards/image_gallery.dart';
part 'buttons/button_category.dart';
part 'buttons/pick_color_button.dart';

part 'appbar/custom_appbar.dart';
part 'anim/fade_in_transition.dart';
part 'anim/fade_in_right.dart';
part 'anim/fade_in_opacity.dart';
part 'ad/banner_widget.dart';
part 'slideshow/slide_item.dart';
part 'slideshow/slideshow.dart';

part 'braille/braille_creator.dart';

part '404/no_information.dart';
part 'notifications/handle_notification_interactive.dart';
