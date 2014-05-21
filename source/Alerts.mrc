;-----------------------------------------------------------------------------------
;ChatSentry
'By Andrew Pinion
;Version 1.0 (3-26-09)
;This program is the sucessor to JoinAlert.
;Visit http://megalith.us/ for updates and online documentation.
;-----------------------------------------------------------------------------------


;--------------------------------------------------------------
;Initialization commands and Default Settings
;--------------------------------------------------------------

on 1:LOAD: {
  /ja.default
  //echo $active 0*
  //echo $active 3***ChatSentry successfully Installed!
  //echo $active 3*To change options, use the right-click menu in the channel or PM window.
}

alias ja.default {

  /.remote on
  /set %JAver ChatSentry 1.0 (3-26-09)

  ;Enable Groups
  /.enable #alert
  /.disable #alertwords
  /.enable #noalertwords
  /.enable #jamenu

  /set %abeep.alert 3
  /set %abeep.join 5
  /set %abeep.part 5
  /set %abeep.quit 5
  /set %abeep.nick 0
  //set %abeep.name $mircdir\addons\sounds\alert1.wav
  /set %abeep.word 2

  /set %aflash.word 1
  /set %aflash.alert 0
  /set %aflash.join 1
  /set %aflash.name 1
  /set %aflash.nick 1
  /set %aflash.part 1
  /set %aflash.quit 1

  /set %a1 moose
  /set %a2 sheep
  /unset %a3 
  /unset %a4 
  /unset %a5 
  /unset %a6 
  /unset %a7 
  /unset %a8 
  /unset %a9 
  /unset %a10
}

;--------------------------------------------
;Uninstalling
;--------------------------------------------

alias ja.uninstall {

  /.remote on
  /unset %JAver

  /unset %abeep
  /unset %abeep.alert 
  /unset %abeep.join 
  /unset %abeep.part
  /unset %abeep.quit 
  /unset %abeep.nick 
  /unset %abeep.name 
  /unset %abeep.word 

  /unset %aflash
  /unset %aflash.word 
  /unset %aflash.alert 
  /unset %aflash.join 
  /unset %aflash.name 
  /unset %aflash.nick 
  /unset %aflash.part 
  /unset %aflash.quit 

  /unset %a1
  /unset %a2
  /unset %a3
  /unset %a4
  /unset %a5
  /unset %a6
  /unset %a7
  /unset %a8
  /unset %a9
  /unset %a10
  /unset %a11
  /unset %a12
  /unset %cline

  //echo $active 0*
  //echo $active 3***ChatSentry successfully Uninstalled!
  /unload -rs Alerts.mrc
}


;--------------------------------------------
;Version Information
;--------------------------------------------



;-----------------------------------
;the /CTCP <nick> ALERT trigger.
;-----------------------------------

#AlertAlert on
ctcp 1:ALERT:*:{ 
  //set %Abeep %Abeep.Alert
  //set %Aflash %Aflash.Alert
  /alert.start
}
#alertAlert end

;-----------------------------------
;Someone joining a channel you're on
;-----------------------------------

#alertjoin on
on *:JOIN:#: {
  if ($nick != $me) { //set %Abeep %Abeep.Join | //set %Aflash %Aflash.Join | /alert.start }
}
#alertjoin end

;-----------------------------------
;Someone parting a channel you're on
;-----------------------------------

#alertpart on
on *:PART:#: {
  if ($nick != $me) { //set %Abeep %Abeep.Part | //set %Aflash %Aflash.Part | /alert.start }
}
#alertpart end

;-----------------------------------
;Someone quitting IRC
;-----------------------------------

#alertquit on
on *:QUIT: {
  if ($nick != $me) { //set %Abeep %Abeep.Quit | //set %Aflash %Aflash.Quit | /alert.start }
}
#alertquit end

;-----------------------------------
;Someone changing nicks
;-----------------------------------

#alertnick on
on *:NICK: {
  if ($nick != $me) { //set %Abeep %Abeep.Nick | //set %Aflash %Aflash.Nick | /alert.start }
}
#alertnick end

;-----------------------------------------------
;main TEXT trigger
;-----------------------------------------------


on *:TEXT:*:*: {
  /set %cline $1-
  if ($group(#alertname) == on) && ($me isin %cline) { /alert.name }
  else {
    /alertwords
  }
}

;-----------------------------------------------
;Someone saying your name in chat
;-----------------------------------------------


#Alertname on
#alertname end

alias Alert.Name {
  //set %Abeep %Abeep.Name
  //set %Aflash %Aflash.Name
  /alert.start

}

;-----------------------------------------------
;Alertwords
;-----------------------------------------------


#alertwords off
Alias alertwords {
  if (%a1 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a2 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a3 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a4 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a5 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a6 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a7 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a8 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a9 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
  if (%a10 isin %cline) { //set %Abeep %Abeep.word | //set %Aflash %Aflash.word | /alert.start }
}

#alertwords end

;-----------------------------------
;Error Handler - No Alertwords
;-----------------------------------
#noalertwords on

alias alertwords {
  halt
}
#noalertwords end


;-----------------------------------
;Main Alert Processing
;-----------------------------------

#alert on
;alias alert.start {
;  //beep %Abeep 
;  /alert.finish
;}

alias alert.start {
  if (wav isin %abeep) {
    /alert.play
    /alert.finish
  }
  else {
    /alert.beep
    /alert.finish
  }
}

#alert end

alias alert.finish {
  if (%Aflash != 0) { //flash -rn %Aflash | halt }
}

alias alert.beep {
  //beep %abeep
}

alias alert.play {
  //splay %abeep
}

;-----------------------------------
;Error Handler - Master Alert disable
;-----------------------------------
#noalerts off

alias alert.start {
  halt
}
#noalerts end

;-----------------------------------
;The Master Command
;-----------------------------------

alias alt {
  if ($$1- == on) { /.enable #alerts }
  if ($$1- == off) { /.disable #alerts }
  if ($$1- == wordson) { /.enable #alertwords | /.disable #noalertwords }
  if ($$1- == wordsoff) { /.disable #alertwords | /.enable #noalertwords }
  if ($$1- == uninstall) { /ja.uninstall }
  if ($$1- == default) { /ja.default }
  if ($$1- == menuon) { /.enable #jamenu | /echo $active ***All Right-Click menus restored.  }
  if ($$1 == menuoff) { /.disable #jamenu | /echo $acitve ***All Right-Click menus disabled! Use "/alt menuon" to restore them. }
}



;-----------------------------------
;Main Dialog Table
;-----------------------------------

#jamenu on
menu channel {
  Alerts: /dialog -mk ja ja
}

menu query {
  Alerts: /dialog -mk ja ja
}
#jamenu end

dialog ja {
  title "Alerts Control Panel"
  size -1 -1 456 260
  option pixels
  tab "Events Editor", 1, -1 -1 455 263
  check "Enable All Alerts", 28, 8 30 100 20, tab 1
  box "Alert Settings", 29, 8 55 439 194, tab 1
  text "Joins", 30, 19 75 50 16, tab 1
  text "Parts", 31, 19 112 50 16, tab 1
  text "Quits", 32, 19 148 50 16, tab 1
  text "Nickchange", 33, 19 219 61 16, tab 1
  text "Namecall", 34, 19 183 50 16, tab 1
  check "Flash", 36, 92 73 56 20, tab 1
  button "Use Wav...", 44, 325 71 75 25, tab 1
  text "Beeps:", 35, 160 75 45 16, tab 1
  edit "", 37, 218 73 100 21, tab 1 autohs
  button "Use Wav...", 38, 325 109 75 25, tab 1
  button "Use Wav...", 39, 325 145 75 25, tab 1
  button "Use Wav...", 40, 325 180 75 25, tab 1
  button "Use Wav...", 41, 325 215 75 25, tab 1
  check "Flash", 51, 92 110 56 20, tab 1
  check "Flash", 52, 92 146 56 20, tab 1
  check "Flash", 53, 92 181 56 20, tab 1
  check "Flash", 54, 92 217 56 20, tab 1
  text "Beeps:", 47, 160 112 45 16, tab 1
  text "Beeps:", 48, 160 148 45 16, tab 1
  text "Beeps:", 49, 160 183 45 16, tab 1
  text "Beeps:", 50, 160 219 45 16, tab 1
  edit "", 46, 218 217 100 21, tab 1 autohs
  edit "", 45, 218 182 100 21, tab 1 autohs
  edit "", 43, 218 147 100 21, tab 1 autohs
  edit "", 42, 218 111 100 21, tab 1 autohs
  button "Test", 55, 406 71 30 25, tab 1
  button "Test", 56, 406 109 30 25, tab 1
  button "Test", 57, 406 145 30 25, tab 1
  button "Test", 58, 406 180 30 25, tab 1
  button "Test", 59, 406 215 30 25, tab 1
  tab "Word Alerts", 2
  check "Enable Word Alerts", 9, 16 41 122 20, tab 2
  button "Use Wav...", 12, 327 58 75 25, tab 2
  text "Beeps:", 14, 22 66 46 16, tab 2
  check "Flash Window", 10, 180 40 100 20, tab 2
  box "Options", 11, 7 23 440 71, tab 2
  box "Words Editor", 15, 6 99 439 151, tab 2
  edit "", 16, 15 122 135 21, tab 2 autohs
  edit "", 27, 158 122 135 21, tab 2 autohs
  edit "", 26, 300 122 135 21, tab 2 autohs
  edit "", 17, 15 150 135 21, tab 2 autohs
  edit "", 22, 158 150 135 21, tab 2 autohs
  edit "", 25, 300 150 135 21, tab 2 autohs
  edit "", 18, 15 184 135 21, tab 2 autohs
  edit "", 21, 158 184 135 21, tab 2 autohs
  edit "", 24, 300 184 135 21, tab 2 autohs
  edit "", 19, 15 216 135 21, tab 2 autohs
  edit "", 20, 158 216 135 21, tab 2 autohs
  edit "", 23, 300 216 135 21, tab 2 autohs
  edit "", 13, 74 62 247 21, tab 2 autohs
  button "Test", 60, 408 58 30 25, tab 2
  tab "About", 3
  button "Help", 4, 16 223 75 25, tab 3
  button "Restore Defaults", 5, 114 223 103 25, tab 3
  button "Check for Updates", 6, 238 223 108 25, tab 3
  button "Uninstall", 7, 367 223 75 25, tab 3
  icon 8, 11 28 433 183,  addons/images/cs.jpg, 0, tab 3
}






;-----------------------------------
;Main Dialog Initialization
;-----------------------------------

On *:DIALOG:ja:init:0:{
  ;Initialize Text Boxes
  did -a ja 16 %a1
  did -a ja 17 %a2
  did -a ja 18 %a3
  did -a ja 19 %a4
  did -a ja 27 %a5
  did -a ja 22 %a6
  did -a ja 21 %a7
  did -a ja 20 %a8
  did -a ja 26 %a9
  did -a ja 25 %a10
  did -a ja 24 %a11
  did -a ja 23 %a12
  did -a ja 37 %abeep.join
  did -a ja 42 %abeep.part
  did -a ja 43 %abeep.quit
  did -a ja 45 %abeep.name
  did -a ja 46 %abeep.nick
  did -a ja 13 %abeep.word

  ;Initialize Check Boxes

  if ($group(#alert) == on) {
    did -c ja 28
  }
  else {
    /alertGuiOff
  }
  if ($group(#alertwords) == on) {
    did -c ja 9
  }
  else {
    /awordguioff
  }
  if (%aflash.word == 1) {
    did -c ja 10
  }
  if (%aflash.join == 1) {
    did -c ja 36
  }
  if (%aflash.part == 1) {
    did -c ja 51
  }
  if (%aflash.quit == 1) {
    did -c ja 52
  }
  if (%aflash.name == 1) {
    did -c ja 53
  }
  if (%aflash.nick == 1) {
    did -c ja 54
  }
}

;-----------------------------------
;GUI Mode Changes
;-----------------------------------

alias AlertGuiOff {
  did -b ja 36
  did -b ja 37
  did -b ja 38  
  did -b ja 39 
  did -b ja 40
  did -b ja 41
  did -b ja 42
  did -b ja 43
  did -b ja 44
  did -b ja 45
  did -b ja 46
  did -b ja 51
  did -b ja 52
  did -b ja 53
  did -b ja 54
  did -b ja 55
  did -b ja 56
  did -b ja 57
  did -b ja 58
  did -b ja 59
}

alias AlertGuiOn {
  did -e ja 36
  did -e ja 37
  did -e ja 38  
  did -e ja 39 
  did -e ja 40
  did -e ja 41
  did -e ja 42
  did -e ja 43
  did -e ja 44
  did -e ja 45
  did -e ja 46
  did -e ja 51
  did -e ja 52
  did -e ja 53
  did -e ja 54
  did -e ja 55
  did -e ja 56
  did -e ja 57
  did -e ja 58
  did -e ja 59
}
alias AwordGuiOn {
  did -e ja 10
  did -e ja 12
  did -e ja 16
  did -e ja 17 
  did -e ja 18
  did -e ja 19
  did -e ja 27
  did -e ja 22
  did -e ja 21
  did -e ja 20
  did -e ja 26
  did -e ja 25
  did -e ja 24
  did -e ja 23
  did -e ja 13
  did -e ja 60
}

alias AwordGuiOff {
  did -b ja 10
  did -b ja 12
  did -b ja 16
  did -b ja 17 
  did -b ja 18
  did -b ja 19
  did -b ja 27
  did -b ja 22
  did -b ja 21
  did -b ja 20
  did -b ja 26
  did -b ja 25
  did -b ja 24
  did -b ja 23
  did -b ja 13
  did -b ja 60
}
;-----------------------------------
;Tab 1 Check Marks
;-----------------------------------
on *:DIALOG:ja:sclick:28:{
  if ($group(#alert) == off) {
    /.enable #alert
    /.disable #noalerts
    /alertguion
  }
  else {
    /.disable #alert
    /.enable #noalerts
    /alertguioff
  }
}

on *:DIALOG:ja:sclick:36:{
  if (%aflash.join == 0) {
    /set %aflash.join 1
  }
  else {
    /set %aflash.join 0
  }
}

on *:DIALOG:ja:sclick:51:{
  if (%aflash.part == 0) {
    /set %aflash.part 1
  }
  else {
    /set %aflash.part 0
  }
}

on *:DIALOG:ja:sclick:52:{
  if (%aflash.quit == 0) {
    /set %aflash.quit 1
  }
  else {
    /set %aflash.quit 0
  }
}

on *:DIALOG:ja:sclick:53:{
  if (%aflash.name == 0) {
    /set %aflash.name 1
  }
  else {
    /set %aflash.name 0
  }
}

on *:DIALOG:ja:sclick:54:{
  if (%aflash.nick == 0) {
    /set %aflash.nick 1
  }
  else {
    /set %aflash.nick 0
  }
}

;-----------------------------------
;Tab 1 Edit Boxes
;-----------------------------------

On *:DIALOG:ja:edit:37:{
  //set %abeep.join $did(37)
}

On *:DIALOG:ja:edit:42:{
  //set %abeep.part $did(42)
}

On *:DIALOG:ja:edit:43:{
  //set %abeep.quit $did(43)
}
On *:DIALOG:ja:edit:45:{
  //set %abeep.name $did(45)
}
On *:DIALOG:ja:edit:46:{
  //set %abeep.nick $did(46)
}

;-----------------------------------
;Tab 1 File Browse Buttons
;-----------------------------------

on *:DIALOG:ja:sclick:44:{
  set %abeep.join $sfile($mircdir/addons/sounds,Select a .wav file)
  did -ra ja 37 %abeep.join
}
on *:DIALOG:ja:sclick:38:{
  set %abeep.part $sfile($mircdir/addons/sounds,Select a .wav file)
  did -ra ja 42 %abeep.part
}
on *:DIALOG:ja:sclick:39:{
  set %abeep.quit $sfile($mircdir/addons/sounds,Select a .wav file)
  did -ra ja 43 %abeep.quit
}
on *:DIALOG:ja:sclick:40:{
  set %abeep.name $sfile($mircdir/addons/sounds,Select a .wav file)
  did -ra ja 45 %abeep.name
}
on *:DIALOG:ja:sclick:41:{
  set %abeep.nick $sfile($mircdir/addons/sounds,Select a .wav file)
  did -ra ja 46 %abeep.nick
}

;-----------------------------------
;Test Buttons
;-----------------------------------
on *:DIALOG:ja:sclick:55:{
  set %abeep %abeep.join
  set %aflash %aflash.join
  alert.start
}

on *:DIALOG:ja:sclick:56:{
  set %abeep %abeep.part
  set %aflash %aflash.part
  alert.start
}
on *:DIALOG:ja:sclick:57:{
  set %abeep %abeep.quit
  set %aflash %aflash.quit
  alert.start
}

on *:DIALOG:ja:sclick:58:{
  set %abeep %abeep.name
  set %aflash %aflash.name
  alert.start
}
on *:DIALOG:ja:sclick:59:{
  set %abeep %abeep.nick
  set %aflash %aflash.nick
  alert.start
}
on *:DIALOG:ja:sclick:60:{
  set %abeep %abeep.word
  set %aflash %aflash.word
  alert.start
}

;-----------------------------------
;Tab 2 Edit Boxes
;-----------------------------------

On *:DIALOG:ja:edit:16:{
  //set %a1 $did(16)
}
On *:DIALOG:ja:edit:17:{
  //set %a2 $did(17)
}
On *:DIALOG:ja:edit:18:{
  //set %a3 $did(18)
}
On *:DIALOG:ja:edit:19:{
  //set %a4 $did(19)
}

On *:DIALOG:ja:edit:27:{
  //set %a5 $did(27)
}
On *:DIALOG:ja:edit:22:{
  //set %a6 $did(22)
}
On *:DIALOG:ja:edit:21:{
  //set %a7 $did(21)
}
On *:DIALOG:ja:edit:20:{
  //set %a8 $did(20)
}

On *:DIALOG:ja:edit:26:{
  //set %a9 $did(26)
}
On *:DIALOG:ja:edit:25:{
  //set %a10 $did(25)
}
On *:DIALOG:ja:edit:24:{
  //set %a11 $did(24)
}
On *:DIALOG:ja:edit:23:{
  //set %a12 $did(23)
}
On *:DIALOG:ja:edit:13:{
  //set %abeep.word $did(13)
}

on *:DIALOG:ja:sclick:12:{
  set %abeep.word $sfile($mircdir/addons/sounds,Select a .wav file)
  did -ra ja 13 %abeep.word
}
;-----------------------------------
;Tab 2 Check Boxes
;-----------------------------------

on *:DIALOG:ja:sclick:9:{
  if ($group(#alertwords) == off) {
    /.enable #alertwords
    /.disable #noalertwords
    /awordguion
  }
  else {
    /.disable #alertwords
    /.enable #noalertwords
    /awordguioff  
  }
}

on *:DIALOG:ja:sclick:10:{
  if (%aflash.word == 0) {
    /set %aflash.word 1
  }
  else {
    /set %aflash.word 0
  }
}

;-----------------------------------
;Tab 3
;-----------------------------------

on *:DIALOG:ja:sclick:5:{
  /beep 1
  /dialog -mk alertdef alertdef
}

On *:DIALOG:ja:sclick:7:{
  /beep 1
  /dialog -mk alertundo alertundo
}

on *:DIALOG:ja:sclick:6:{
  /run iexplore.exe http://main.megalith.us/index.php/ChatSentry
}

;View Help File
on *:DIALOG:ja:sclick:4:{
  /run notepad.exe addons/AlertsHelp.txt
}


;-----------------------------------
;Uninstall GUI
;-----------------------------------

dialog alertundo {
  title "Addon Uninstaller"
  size -1 -1 124 33
  option dbu
  button "Uninstall", 1, 71 16 37 12
  button "Cancel", 2, 23 16 37 12
  text "Do you really wish to uninstall ChatSentry? ", 3, 5 4 111 8, center
}


on *:DIALOG:alertundo:sclick:1:{
  /dialog -x ja
  /dialog -x alertundo
  /ja.uninstall
}

on *:DIALOG:alertundo:sclick:2:{
  /dialog -x alertundo
}

;-----------------------------------
;Restore Defaults GUI
;-----------------------------------

dialog alertdef {
  title "Confirm Restore Defaults"
  size -1 -1 124 33
  option dbu
  button "Yes", 1, 71 16 37 12
  button "Cancel", 2, 23 16 37 12
  text "Do you really wish to restore defaults? ", 3, 5 4 111 8, center
}


on *:DIALOG:alertdef:sclick:1:{
  /dialog -x ja
  /dialog -x alertdef
  /ja.default
  /dialog -mk ja ja
}

on *:DIALOG:alertdef:sclick:2:{
  /dialog -x alertdef
}
