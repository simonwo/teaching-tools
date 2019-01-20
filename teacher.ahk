; Copyright (c) 2019 Simon Worthington, simon@simonwo.net
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SysGet Mon, Monitor
Width := MonRight - MonLeft ; Set width for full screen display

; Change these options to change the random choosing!
Numbers := [4, 5, 6, 7, 8]
Letters := ["A", "B", "C", "D", "E", "F", "G", "H"]

; Default timer time, change with Win+Y
TimerSeconds := 10

; Display welcome message
MsgBox, 64, Teaching Tools, Teaching Tools is running! Press Win+? for help.,

; Win+O: Open a student file to randomly pick students from
#o::
FileSelectFile, StudentFile, 1
return

; Win+J: Randomly pick and display a student
#j::
FileRead, StudentText, %StudentFile%
Students := StrSplit(StudentText, "`n")
Random, StudentNum, Students.MinIndex(), Students.MaxIndex()
Student := Trim(Students[StudentNum], " `r`n")
Progress, zh0 fs72 B W%Width%, %Student%, , , Tahoma
Sleep, 4000
Progress, Off
return

; Win+K: Randomly pick a number
#k::
Random, RandomIndex, Numbers.MinIndex(), Numbers.MaxIndex()
RandomNumber := Trim(Numbers[RandomIndex])
Progress, zh0 fs150 B W%Width%, %RandomNumber%, , , Tahoma
Sleep, 4000
Progress, Off
return

; Win+H: Randomly pick a letter
#h::
Random, RandomIndex, Letters.MinIndex(), Letters.MaxIndex()
RandomLetter := Trim(Letters[RandomIndex])
Progress, zh0 fs150 B W%Width%, %RandomLetter%, , , Tahoma
Sleep, 4000
Progress, Off
return

; Win+Y: Pick the time for the timer, in seconds
#y::
InputBox, TimerSeconds, Timer, Specify the time for the timer in seconds:
return

; Win+T: Start a timer for the specified time
#t::
NumLoops := TimerSeconds * 20
Progress, P0 B W%Width% zh150 fs75, %TimerSeconds% second timer, , , Tahoma
Loop %NumLoops% {
  Percentage := (A_Index / NumLoops) * 100
  Progress, %Percentage%
  Sleep 50
}
Progress, Off
return

; Win+?: Help
#/::
MsgBox, 64, Teaching Tools, Win+O: Open a student file`nWin+H: Randomly pick a letter`nWin+J: Randomly pick a student`nWin+K: Randomly pick a number`nWin+Y: Set timer`nWin+T: Reset and run timer
return
