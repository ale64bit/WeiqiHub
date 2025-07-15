import 'dart:developer';

import 'package:wqhub/settings/settings.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/task_repository.dart';

void applyVersionPatch(Settings settings) {
  _versionPatch_0_1_8(settings);
}

void _versionPatch_0_1_8(Settings settings) {
  const version = '0.1.8';
  if (settings.getVersionPatchStatus(version)) {
    log('skipping version patch: $version');
    return;
  }
  log('applying version patch: $version');

  StatsDB().deleteMistakes([
    'wqhub://t/100100026138',
    'wqhub://t/1200000028e9',
    'wqhub://t/12010001902b',
    'wqhub://t/120200017387',
    'wqhub://t/1300000192da',
    'wqhub://t/13000002403a',
    'wqhub://t/130200026208',
    'wqhub://t/1302000263a9',
    'wqhub://t/140200007a9a',
    'wqhub://t/1500000041b8',
    'wqhub://t/150000008ff8',
    'wqhub://t/15020001b6ea',
    'wqhub://t/16000000651d',
    'wqhub://t/16000000aa1c',
    'wqhub://t/1603000015e6',
    'wqhub://t/17000000acc7',
    'wqhub://t/18000000650f',
    'wqhub://t/1800000065a6',
    'wqhub://t/18000001fc59',
    'wqhub://t/18070001c505',
    'wqhub://t/190000000edf',
    'wqhub://t/190000006537',
    'wqhub://t/19000000dfca',
    'wqhub://t/190100007e42',
    'wqhub://t/1a00000064c4',
    'wqhub://t/1a000000acb2',
    'wqhub://t/1a000000c28c',
    'wqhub://t/1a000000c4c0',
    'wqhub://t/1a000000f807',
    'wqhub://t/1a0000014593',
    'wqhub://t/1a0000015d1b',
    'wqhub://t/1a000001aedb',
    'wqhub://t/1a000001e9ac',
    'wqhub://t/1a01000064bd',
    'wqhub://t/1a01000070ab',
    'wqhub://t/1a010000968e',
    'wqhub://t/1a010000ee93',
    'wqhub://t/1a010001f5a4',
    'wqhub://t/1a0300003c0f',
    'wqhub://t/1a070001ef1f',
    'wqhub://t/1b0000000578',
    'wqhub://t/1b0000000e32',
    'wqhub://t/1b000000cc02',
    'wqhub://t/1b000000f6b8',
    'wqhub://t/1b0000021a1c',
    'wqhub://t/1b010000ed9a',
    'wqhub://t/1b0300000ff7',
    'wqhub://t/1b03000182c0',
    'wqhub://t/1b03000253ae',
    'wqhub://t/1c0000000e71',
    'wqhub://t/1c0000014318',
    'wqhub://t/1c000001c0bf',
    'wqhub://t/1c000001f2d8',
    'wqhub://t/1c0100004f20',
    'wqhub://t/1d010001d45e',
    'wqhub://t/200000010305',
    'wqhub://t/2107000057c5',
  ].map((u) => TaskRef.ofUri(u)));

  settings.setVersionPatchStatus(version, true);
}
