import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:templat_project/constants/constant.dart';
import 'package:templat_project/provider/providers.dart';

import '../env/environment_variables.dart';
import '../services/services.dart';
part 'text_utils.dart';
part 'letter_converted.dart';
/* part 'ad_utils.dart'; */
part 'user_preferences.dart';
part 'pdf_creator.dart';
part 'ad_utils.dart';
part 'intersitial_util.dart';
part 'menu_utils.dart';
