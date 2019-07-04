#!/usr/bin/env wolframscript
(* ::Package:: *)

arduino = DeviceOpen["Arduino", "COM6"]; (*Opening the Arduino Uno*)
temp = PrintTemporary["Arduino Connected"]; 
Needs["JLink`"];          
NotebookDelete[temp]; temp = PrintTemporary["JavaLink established"];
ReinstallJava[];
robot = JavaNew["java.awt.Robot"];
NotebookDelete[temp]; temp = PrintTemporary["Robot produced"];
NotebookDelete[temp]; temp = PrintTemporary["Mouse running. Press Alt + . to abort."];
speed = 10; (*The speed of the mouse*)
While[True, pos = Round/@(MousePosition["ScreenScaled"]*{1920, 1080}); (*Reads mouse coordinates relative to entire screen*)
robot@mouseMove[pos[[1]]+Round[(QuantityMagnitude[DeviceRead[arduino, "A0"]] - 2.5 - 0.1)*speed],pos[[2]]+Round[(QuantityMagnitude[DeviceRead[arduino, "A1"]] - 2.5 - 0.1)*speed]]]
(*Need to add error component to stop it 'sagging' downwards on the screen*)
