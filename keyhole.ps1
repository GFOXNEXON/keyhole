# Set the execution policy to RemoteSigned for the current process
Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Verify the execution policy
Get-ExecutionPolicy -Scope Process

#Load DLLs
#GFOX Special Sauce V4.1 

Add-Type -AssemblyName System.Windows.Forms

# Check if the script is running as Administrator and relaunch if not
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Engineers Toolkit - Keyhole needs to be run as Administrator."
    #Start-Process -Verb runas -FilePath powershell.exe -ArgumentList “iwr -useb https://raw.githubusercontent.com/GFOXNEXON/keyhole/main/keyhole.ps1 | iex”
    break
}
Write-Host "Special Sauce - Engineers Toolkit"
# Set the message to display
$message = "Loading Special Sauce...."

# Loop through each character in the message
for ($i = 0; $i -lt $message.Length; $i++) {

    # Get the current character
    $char = $message[$i]

    # Append the character to the status
    $status += $char

    # Display the progress bar with the status
    Write-Progress -Activity "Please wait" -Status $status -PercentComplete (($i + 1) / $message.Length * 100)

    # Wait for 100 milliseconds
    Start-Sleep -Milliseconds 100
}

# Clear the progress bar
Write-Progress -Activity "Please wait" -Completed



# Variables
#$cachePath = "C:\SpecialSauceCache"

# Create cache directory if it doesn't exist
#if (!(Test-Path $cachePath)) {
#    New-Item -ItemType Directory -Path $cachePath | Out-Null
#}

# Get the hostname and serial number
$hostname = $env:COMPUTERNAME
$serial = (Get-WmiObject -Class Win32_BIOS).SerialNumber

# Create the form and set its properties
$form = New-Object System.Windows.Forms.Form
#$Form.Icon = [System.Drawing.SystemIcons]::Question
$form.Text = "Special Sauce - Engineers Toolkit"
$form.Size = New-Object System.Drawing.Size(500, 400)
# Event Handler to delete cache when form is closed and any closing actions
$form.Add_FormClosing({
    #Remove-Item -Recurse -Force $cachePath -ErrorAction SilentlyContinue
    Write-Host "#########################"
    Write-Host "##SIGTERM SPECIAL SAUCE##"
    Write-Host "#########################"

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
$serialLabel.Text = "$serial"
$serialLabel.Font = $labelFont
$serialLabel.ForeColor = $labelColor
$serialLabel.BackColor = $labelBackColor
$form.Controls.Add($serialLabel)


# Buttons

# Create a tooltip object for the buttons
$tooltip = New-Object System.Windows.Forms.ToolTip

# Create the button to launch the Updates
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(10, 80)
$button1.Size = New-Object System.Drawing.Size(100, 40)
$button1.Text = "Update"

$button1.ImageAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$tooltip.SetToolTip($button1, "This will install all updates, firmware and drivers across all hardware architectures.")
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

Write-Host "DEVICE WILL ASK TO REBOOT" -ForegroundColor Green


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

# Create the button AutoPilot Enrol
$button2 = New-Object System.Windows.Forms.Button
$button2.Location = New-Object System.Drawing.Point(120, 80)
$button2.Size = New-Object System.Drawing.Size(100, 40)
$button2.Text = "AUTOPILOT Enrol"
#$button2.Image = [System.Drawing.Image]::FromStream((New-Object System.Net.WebClient).OpenRead("https://i.imgur.com/0w9xZ6F.png"))
$button2.ImageAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$tooltip.SetToolTip($button2, "This will connect to any tenant using your 365 credentials and import the serial number and add a AzureAD group tag")
$button2.Add_Click({
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$false -Force:$true;
Install-Script get-windowsautopilotinfo -Confirm:$false -Force:$true ;
get-windowsautopilotinfo -Online -GroupTag AzureAD
})
$form.Controls.Add($button2)

# Create Button
$button3 = New-Object System.Windows.Forms.Button
$button3.Location = New-Object System.Drawing.Point(230, 80)
$button3.Size = New-Object System.Drawing.Size(100, 40)
$button3.Text = "S3"
#$button3.Image = [System.Drawing.Image]::FromStream((New-Object System.Net.WebClient).OpenRead("https://i.imgur.com/0w9xZ6F.png"))
$button3.ImageAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$tooltip.SetToolTip($button3, "Adding Script from Sauce")
$button3.Add_Click({
    Start ms-settings:
})
$form.Controls.Add($button3)

# Show the form
$form.ShowDialog()
