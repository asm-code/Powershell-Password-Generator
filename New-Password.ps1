<#
.Synopsis
	New-Password Sript CmdLet
.DESCRIPTION
	Generate Random Password(s) with user defined ASCI Character Set(s)
.PARAMETER UpperCase
	Use UpperCase ASCII Charaters A-Z
.PARAMETER LowerCase
	Use LowerCase ASCII Charaters a-z
.PARAMETER Digits
	Use Digits ASCII Charaters 0-9
.PARAMETER Symbols
	Use the Special ASCII Charaters ~!@#$%^&*_-+=`|\(){}[]:;"'<>,.?/
.PARAMETER All
	Use all alphanumeric and special symbols
	Default Generation Mode
.PARAMETER Length
	Number of Charaters in the generated Password. Default = 7
.PARAMETER Count
	Number of password to generate. Default = 1
.EXAMPLE
	Generate one Password using all alphanumeric and special symbols ASCII Charaters with a default length of 7
	.\New-Password
.EXAMPLE
	Generate 10 Password using all Alphanumeric and special symbols ASCII Charaters with the length of 14
	.\New-Password -Length 14 -Count 10 
.EXAMPLE
	Generate one Password using only Alphanumeric ASCII Charaters with a length of 10
	.\New-Password -UpperCase -LowerCase -Digits -Length 10
.NOTES
	Author: Ahmed S. Messaoudi
	Version: 1.0
#>

[CmdletBinding(DefaultParameterSetName="All")]

Param(
	[Parameter(ParameterSetName="Select")]
	[Switch]$UpperCase,
	[Parameter(ParameterSetName="Select")]
	[Switch]$LowerCase,
	[Parameter(ParameterSetName="Select")]
	[Switch]$Digits,
	[Parameter(ParameterSetName="Select")]
	[Switch]$Symbols,
	[Parameter(ParameterSetName="All")]
	[Switch]$All,
	[int] $Length = 7, 
	[int] $Count = 1
)

Begin {
    $Passwords = @()
    $CharArray = @()
		
    # Building Char Arrays (ASCII Decimal to Char) 
    $UpperCaseCharArray = (65..90) | ForEach-Object {[char]$_}
    $LowerCaseCharArray = (97..122) | ForEach-Object {[char]$_}
    $DigitsCharArray = (48..57) | ForEach-Object {[char]$_}
    $(33..47),$(58..64),$(91..96),$(123..126) | ForEach-Object {$SymbolsASCII += $_}
    $SymbolsCharArray = $SymbolsASCII | ForEach-Object {[char]$_}
	    
    # User Selection
    if ($PsCmdlet.ParameterSetName -eq "Select") {
	    if ($UpperCase)  {$CharArray += $UpperCaseCharArray}
	    if ($LowerCase)  {$CharArray += $LowerCaseCharArray}
	    if ($Digits   )  {$CharArray += $DigitsCharArray}
	    if ($Symbols  )  {$CharArray += $SymbolsCharArray}
    }
    # All Printable ASCII Charaters
    else { 
	    $CharArray = (33..126) | ForEach-Object {[char]$_}
    }
}

Process {
    For ($i=0 ; $i -lt $Count; $i++) {
        $Password = Get-Random -Count $Length -InputObject $CharArray
        $Passwords += (-join $Password)
    }
}

End { 
	$Passwords 
}