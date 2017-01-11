# PowerShell Password Generator
Random password generator in PowerShell. CmdLet and GUI.
## New-Password.ps1
Standalone script CmdLet. Generate random Password(s) using user defined ASCII Character Set(s).
Output is a String Object or an Array of Strings and can be integrated in any Pipeline.
### Usage
Generate a Password with a default length of 7 using all ASCII alphanumeric charaters and symbols. 
```
PS C:\> .\New-Password.ps1
"4p='Yi
```
Generate 5 Passwords with a lenght of 14 characters using all ASCII alphanumeric charaters and symbols. 
```
PS C:\> .\New-Password.ps1 -Length 14 -Count 5
T;J8\7Iw\<5$LM
Y|QUsV4_YDQnL"
YQXC:Ef'a'z1'j
Q>S.->z]+TNm*)
xmQXMq~3,iJzy+
```
Generate 5 Passwords with a lenght of 14 characters using only ASCII alphanumeric charaters. 
```
PS C:\> .\New-Password.ps1 -Length 14 -Count 5 -UpperCase -LowerCase -Digits
BWMTkeS5AqgQmv
wQCShJqVyFAHgw
gUbIrOkvayITfT
0vjyTgXBjOCT1o
Z3TUkb1JptQnaZ
```
## PSPassGenGUI.ps1
A GUI for New-Password.ps1
### Screenshot
![PowerShell Password Generator](https://github.com/ASM-bler/Powershell-Password-Generator/blob/master/Screenshot.JPG)