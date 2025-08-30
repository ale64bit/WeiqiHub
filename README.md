<h1 align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/ale64bit/WeiqiHub/blob/main/doc/header_dark.png">
    <img alt="WeiqiHub" src="./doc/header_light.png">
  </picture>
</h1>

[![Build Linux](https://github.com/ale64bit/WeiqiHub/actions/workflows/build_linux.yaml/badge.svg)](https://github.com/ale64bit/WeiqiHub/actions/workflows/build_linux.yaml)
[![Build MacOS](https://github.com/ale64bit/WeiqiHub/actions/workflows/build_macos.yaml/badge.svg)](https://github.com/ale64bit/WeiqiHub/actions/workflows/build_macos.yaml)
[![Build Windows](https://github.com/ale64bit/WeiqiHub/actions/workflows/build_windows.yaml/badge.svg)](https://github.com/ale64bit/WeiqiHub/actions/workflows/build_windows.yaml)

WeiqiHub is a unified client to multiple Go servers and offline puzzle solving.

## Features
- Local board
- Play on Fox Weiqi (unofficial client)
- Play on Tygem (unofficial client)
- Solve tsumego (no internet required):
  * Grading Exam: sets of 10 problems of the same rank, each with a 45s time limit. Solve at least 8 to pass (a.k.a. "guan").
  * Endgame Exam: sets of 10 endgame problems of the same rank, each with a 45s time limit. Solve at least 8 to pass.
  * Time Frenzy: solve as many problems as possible within 3 minutes. Difficulty increases the more you solve. If you make 3 mistakes, you are out.
  * Ranked Mode: solve problems without a time limit. Difficulty increases the more/faster you solve.
  * Collections: solve classic curated collections of problems without a time limit to improve your reading strength.
  * Topics: solve problems across various topics and ranks.
  * Custom Exam: solve problems from a customized set of topics, collections or from your mistakes
- Keep track of your solve stats and mistakes

## Development

A working installation of Flutter is needed. To run the app in debug mode, use `flutter run` or the Run button in VSCode.