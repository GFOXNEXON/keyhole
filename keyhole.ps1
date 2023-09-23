#Load DLLs
Add-Type -AssemblyName System.Windows.Forms

# Check if the script is running as Administrator and relaunch if not
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Engineers Toolkit - Keyhole needs to be run as Administrator. Attempting to relaunch."
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList “iwr -useb https://raw.githubusercontent.com/GFOXNEXON/keyhole/main/keyhole.ps1 | iex”
    break
}
Write-Host "Special Sauce"

# Variables
$cachePath = "C:\SpecialSauceCache"

# Create cache directory if it doesn't exist
if (!(Test-Path $cachePath)) {
    New-Item -ItemType Directory -Path $cachePath | Out-Null
}

# Get the hostname and serial number
$hostname = $env:COMPUTERNAME
$serial = (Get-WmiObject -Class Win32_BIOS).SerialNumber

# Create the form and set its properties
$form = New-Object System.Windows.Forms.Form
$form.Text = "Special Sauce"
$form.Size = New-Object System.Drawing.Size(900, 5600)
# Event Handler to delete cache when form is closed
$form.Add_FormClosing({
    Remove-Item -Recurse -Force $cachePath -ErrorAction SilentlyContinue
})

# Set a background image for the form from a URL and stretch it to fill the form
$form.BackgroundImage = [System.Drawing.Image]::FromStream((New-Object System.Net.WebClient).OpenRead("https://raw.githubusercontent.com/GFOXNEXON/keyhole/main/specialsauce.jpeg"))
$form.BackgroundImageLayout = [System.Windows.Forms.ImageLayout]::Stretch

# Labels

# Set a bold white font for the labels
$labelFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$labelColor = [System.Drawing.Color]::White

# Set a transparent background color for the labels
$labelBackColor = [System.Drawing.Color]::FromName("Transparent")

# Create the label for the hostname and set its font, color, and background
$hostnameLabel = New-Object System.Windows.Forms.Label
$hostnameLabel.Location = New-Object System.Drawing.Point(10, 10)
$hostnameLabel.Size = New-Object System.Drawing.Size(380, 20)
$hostnameLabel.Text = "Hostname: $hostname"
$hostnameLabel.Font = $labelFont
$hostnameLabel.ForeColor = $labelColor
$hostnameLabel.BackColor = $labelBackColor
$form.Controls.Add($hostnameLabel)

# Create the label for the serial number and set its font, color, and background
$serialLabel = New-Object System.Windows.Forms.Label
$serialLabel.Location = New-Object System.Drawing.Point(10, 30)
$serialLabel.Size = New-Object System.Drawing.Size(380, 20)
$serialLabel.Text = "Serial number: $serial"
$serialLabel.Font = $labelFont
$serialLabel.ForeColor = $labelColor
$serialLabel.BackColor = $labelBackColor
$form.Controls.Add($serialLabel)


# Buttons

# Create a tooltip object for the buttons
$tooltip = New-Object System.Windows.Forms.ToolTip

# Create the button to launch the first script and set its image and tooltip
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(10, 80)
$button1.Size = New-Object System.Drawing.Size(100, 40)
$button1.Text = "Connect and Update"
#$button1.Image = [System.Drawing.Image]::FromStream((New-Object System.Net.WebClient).OpenRead("https://i.imgur.com/0w9xZ6F.png"))
$button1.ImageAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$tooltip.SetToolTip($button1, "This will connect the device to Intune and install all updates")
$button1.Add_Click({
    
Write-Host "Funny Farm modules"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12



# Install the NuGet package provider if it is not already installed
if (!(Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
  Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$false -Force:$true;
}

# Install the pswindowsupdate module if it is not already installed
if (!(Get-Module -Name PswindowsUpdate -ErrorAction SilentlyContinue)) {
  Install-Module -Name pswindowsupdate -force
}


Write-Host "Set Time Zone AUS Eastern Standard Time"

Set-TimeZone -Id "AUS Eastern Standard Time"



Write-Host "##############################################################" -ForegroundColor Yellow

Write-Host "Automated Update of all Drivers, Firmware and Windows Updates." -ForegroundColor Green

Write-Host "DEVICE WILL AUTO REBOOT" -ForegroundColor Green


Write-Host "##############################################################" -ForegroundColor Yellow

#GFOX V4.2

Import-Module PswindowsUpdate
Write-Host "Standby " -ForegroundColor Green
#VET UPDATES Exclude Defender and Problem Updates the following are excluded
#KB5007651   18MB Update for Windows Security platform antimalware platform - KB5007651 
#KB890830    57MB Windows Malicious Software Removal Tool x64 - v5.116 (KB890830)
#KB2267602  127MB Security Intelligence Update for Microsoft Defender Antivirus - KB2267602
#KB4023057    3MB 2023-04 Update for Windows 11 Version 22H2 for x64-based Systems

Install-WindowsUpdate -NotKBArticleID KB2267602, KB4023057, KB5007651, KB890830 -AcceptAll
#-AcceptAll -AutoReboot
})
$form.Controls.Add($button1)

# Create the button to launch the second script and set its image and tooltip
$button2 = New-Object System.Windows.Forms.Button
$button2.Location = New-Object System.Drawing.Point(120, 80)
$button2.Size = New-Object System.Drawing.Size(100, 40)
$button2.Text = "AUTOPILOT ENROL DEVICE"
#$button2.Image = [System.Drawing.Image]::FromStream((New-Object System.Net.WebClient).OpenRead("https://i.imgur.com/0w9xZ6F.png"))
$button2.ImageAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$tooltip.SetToolTip($button2, "This will reset the device to factory settings and remove all data")
$button2.Add_Click({
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$false -Force:$true;
Install-Script get-windowsautopilotinfo -Confirm:$false -Force:$true ;
get-windowsautopilotinfo -Online -GroupTag AzureAD
})
$form.Controls.Add($button2)

# Create the button to launch the third script and set its image and tooltip
$button3 = New-Object System.Windows.Forms.Button
$button3.Location = New-Object System.Drawing.Point(230, 80)
$button3.Size = New-Object System.Drawing.Size(100, 40)
$button3.Text = "Script 3"
#$button3.Image = [System.Drawing.Image]::FromStream((New-Object System.Net.WebClient).OpenRead("https://i.imgur.com/0w9xZ6F.png"))
$button3.ImageAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$tooltip.SetToolTip($button3, "This will run the third script")
$button3.Add_Click({
    Start-Process powershell.exe -ArgumentList "-File D:\SpecialSauce\Script3.ps1"
})
$form.Controls.Add($button3)

# Show the form
$form.ShowDialog()
