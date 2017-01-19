<#
.Synopsis
	PowerShell Password Generator GUI
.DESCRIPTION
	GUI for New-Password Scipt CmdLet
	IMPORTANT: Generate-Password.ps1 must be present in the same folder.
.EXAMPLE
	.\PSPassGenGUI.ps1
.NOTES
	Author: Ahmed S. Messaoudi
	Version: 1.0
#>

[CmdletBinding()]
Param()

Begin {	
	Add-Type -AssemblyName PresentationFramework
	$NewPassScript = Join-Path -Path $PSScriptRoot -ChildPath "New-Password.ps1"
	if (-not (Test-Path $NewPassScript)) {
		[System.Windows.MessageBox]::Show("'New-Password.ps1' is missing", "Error", [System.Windows.MessageBoxButton]"OK"  , [System.Windows.MessageBoxImage]"Error")
		Break
	}

	# XAML Definition
	[xml]$MainForm = @"
	<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
			Title="PowerShell Password Generator" Height="300" Width="290" Background="White" Foreground="Black" ResizeMode="NoResize" WindowStartupLocation="CenterScreen">
		<Grid>
			<GroupBox Name="ParametersBox" Header="Parameters" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="5,0,5,0">
				<StackPanel Orientation="Vertical" Height="52" VerticalAlignment="Top" Margin="10,5,10,5">
					<StackPanel Orientation="Horizontal" Height="26" Margin="0,0,0,0" HorizontalAlignment="Center">
						<Label Name="lbl_length" Content="Lenght" Width="50" Padding="0,5" HorizontalContentAlignment="Left" ToolTip="Password Length"/>
						<TextBox Name="Length" Width="55" Height="26" Text="7" TextWrapping="NoWrap" VerticalContentAlignment="Center" ToolTip="Password Length"/>
						<Label Name="lbl_count" Content="Count" Padding="10,5"  Width="55" Height="26" HorizontalContentAlignment="Right" ToolTip="Number of different passwords to generate"/>
						<TextBox Name="Count" Width="55" Height="26" Text="1" TextWrapping="NoWrap" VerticalContentAlignment="Center" ToolTip="Number of different passwords to generate"/>
					</StackPanel>
					<StackPanel Orientation="Horizontal" Height="15" Margin="0,10,0,0" HorizontalAlignment="Center">
						<CheckBox Name="UpperCase" Content="A-Z" VerticalAlignment="Top" Height="15" Width="56" IsChecked="True" />
						<CheckBox Name="LowerCase" Content="a-z" VerticalAlignment="Top" Height="15" Width="56" IsChecked="True"/>
						<CheckBox Name="Digits" Content="0-9"  VerticalAlignment="Top" Height="15"  Width="56" IsChecked="True"/>
						<CheckBox Name="Symbols" Content="!#@$" VerticalAlignment="Top" Height="15" Width="50"  IsChecked="True"/>
					</StackPanel>
				</StackPanel>
			</GroupBox>
			<Button Name="Generate" Content="Generate" Margin="10,90
					,10,0" VerticalAlignment="Top" Height="20"/>
			<TextBox Name="Result" Margin="10,115,10,10" Padding="5,2" Background="#FF363636" Foreground="White"  ScrollViewer.VerticalScrollBarVisibility="Auto" TextWrapping="Wrap" IsReadOnly="True"/>
		</Grid>
	</Window>
"@

	# Create Main Window
	$XmlNodeReader = New-Object System.Xml.XmlNodeReader $MainForm
	$MainWindow = [System.Windows.Markup.XamlReader]::Load($XmlNodeReader)

	#Find all elements
	$Generate = $MainWindow.FindName("Generate")
	$Result = $MainWindow.FindName("Result")
	$Length = $MainWindow.FindName("Length")
	$Count = $MainWindow.FindName("Count")
	$UpperCase = $MainWindow.FindName("UpperCase")
	$LowerCase = $MainWindow.FindName("LowerCase")
	$Digits = $MainWindow.FindName("Digits")
	$Symbols = $MainWindow.FindName("Symbols")

	#Add OnClick Click Event to the "Generate" Button
	$Generate.Add_Click({
		$Result.Text = ""
		$Params = @{
			Length = $Length.Text 
			Count = $Count.Text 
			UpperCase = $UpperCase.IsChecked
			LowerCase = $LowerCase.IsChecked
			Digits = $Digits.IsChecked
			Symbols = $Symbols.IsChecked
			}
		$Passwords = & $NewPassScript @Params
       		foreach ($Password in $Passwords) {
			$Result.Text += $Password + [System.Environment]::NewLine
		}
	})
}

Process { $MainWindow.ShowDialog() | Out-Null }

End {}
