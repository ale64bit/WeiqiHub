# Changelog

## 0.1.12
- Ukrainian localization (@vabue)
- OGS: fix bug where correspondence games would be resumed (@benjaminpjones)
- OGS: fix byoyomi update bug (@benjaminpjones)
- improve login error descriptions (@benjaminpjones)
- set iOS app audio as background to avoid interruptions (@adudenamedruby)
- persist local board state on shared preferences
- add exam and task type charts to statistics
- fix: task title overflow
- add result page for exams and collections
- add Custom Exam presets
- improve selection granularity of task topics
- add setting for hiding players' rank (@adudenamedruby)
- add fullscreen setting for mobile platforms

## 0.1.11
- OGS support (@benjaminpjones)
- add setting to track Time Frenzy mistakes (@hemme)
- add option to copy task SGF (@hemme)
- accessibility: add setting to show wrong moves as crosses (@hemme)
- Italian localization (@hemme)
- Romanian localization (@adudenamedruby)
- German localization (@StHagel, @InfoKendoKing)
- next task can be triggered with a swipe gesture where applicable
- add setting for randomizing task orientation (@hemme)

## 0.1.10
- now available in Chinese (simplified), Russian and Spanish
- add task search by pattern
- add help dialogs for several pages
- show current rank for each topic
- fix topic progress display bug when returning to topic page
- fix timezone bug in statistics
- new theme: BadukTV
- remove experimental 9x9 human-like AI bot 
- remove a few broken tasks

## 0.1.9
- add Next button for topic exams 
- fix: redo button bug on custom exams
- fix: disable start custom exam if there are no tasks available
- fix: custom exam reports more mistakes than available
- fix many broken tasks
- improve overall routing/navigation
- improve statistics page: daily/weekly/monthly stats
- new themes by Pumu
- experimental: 9x9 human-like AI bot 
- improved sound settings

## 0.1.8
- add file picker dialog to save games on desktop
- add task topics
- fix: starting a collection warns about ongoing sessions
- fix: collections page refreshes after exiting current session
- add mode to try custom moves in tasks
- add Custom Exam mode
- fix several broken tasks

## 0.1.7
- hotfix for Windows game downloads

## 0.1.6
- add My Mistakes page
- add Collections page
- download games to Downloads directory on all desktop platforms
- fix several broken tasks
- fix always-black-to-play setting
- fix broken game sharing on iPad
- fix missing last-move annotation when rejoining game
- fix receiving counting requests from opponents on foxwq
- improve disconnection handling on mobile platforms
- display player online status during games

## 0.1.5
- fix several broken tasks
- add Endgame Exam mode
- add setting to set all tasks as black-to-play
- add task share link and Find Task mode
- improved stone assets (thanks @Eraleis!)
- save SGF from local board
- improve download and parsing of Fox games

## 0.1.4
- fix several broken and duplicated tasks
- update Tygem automatch presets to match the official client
- add Windows VS Redistributable files to installer
- make downloading games more responsive
- use an older GitHub runner for Linux builds (based on Ubuntu 22.04)

## 0.1.3
- remove Register button for iOS and MacOS due to Apple guidelines
- logout support
- add button to show task continuations (correct and wrong variations)

## 0.1.2
- recent results and rank up/down requirements
- refresh game record automatically after games
- fix: refresh issue caused opponent's move to not show up on ranked mode
- add board navigation keyboard shortcuts
- fix: rank display issue in ranked mode
- clear ghost stone when tapping a occupied point
- add buttons to redo and go to next rank grading exam

## 0.1.1
- game list, download and AI Sensei sharing
- grading exam result now shows the average time per task as well
- add a task solving response delay setting
- fix: grading exam counts as failed when exiting in the middle of it
- fix: remove ghost stone from captured stones
- fix: do not spam result banner after solving a task
- relax disconnection threshold for foxwq

## 0.1.0+3

- fix: show hovering stone only when it's your turn during games
- fix: result banner doesn't get in the middle of the next button in wide layout
- settings page refactored into separate sections
- add setting to confirm moves on large boards to avoid misclicks on small screens