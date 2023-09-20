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
$form.Size = New-Object System.Drawing.Size(800, 500)
# Event Handler to delete cache when form is closed
$form.Add_FormClosing({
    Remove-Item -Recurse -Force $cachePath -ErrorAction SilentlyContinue
})

#$form.BackgroundImage = $image
#$form.BackgroundImageLayout = [System.Windows.Forms.ImageLayout]::Stretch  # Stretch the image to fill the form

# Labels

# Create the label for the hostname
$hostnameLabel = New-Object System.Windows.Forms.Label
$hostnameLabel.Location = New-Object System.Drawing.Point(10, 10)
$hostnameLabel.Size = New-Object System.Drawing.Size(380, 20)
$hostnameLabel.Text = "Hostname: $hostname"
$form.Controls.Add($hostnameLabel)

# Create the label for the serial number
$serialLabel = New-Object System.Windows.Forms.Label
$serialLabel.Location = New-Object System.Drawing.Point(10, 30)
$serialLabel.Size = New-Object System.Drawing.Size(380, 20)
$serialLabel.Text = "Serial number: $serial"
$form.Controls.Add($serialLabel)

# Buttons

# Create the button to launch the first script
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(10, 80)
$button1.Size = New-Object System.Drawing.Size(100, 40)
$button1.Text = "Connect and Update"
$button1.Add_Click({
    Start-Process powershell.exe -ArgumentList "-File $cachePath\enrol-kit.ps1"
})
$form.Controls.Add($button1)

# Create the button to launch the second script
$button2 = New-Object System.Windows.Forms.Button
$button2.Location = New-Object System.Drawing.Point(120, 80)
$button2.Size = New-Object System.Drawing.Size(100, 40)
$button2.Text = "AutoPilotEnrol AzureAD"
$button2.Add_Click({
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$false -Force:$true;
Install-Script get-windowsautopilotinfo -Confirm:$false -Force:$true ;
get-windowsautopilotinfo -Online -GroupTag AzureAD
})
$form.Controls.Add($button2)

# Create the button to launch the third script
$button3 = New-Object System.Windows.Forms.Button
$button3.Location = New-Object System.Drawing.Point(230, 80)
$button3.Size = New-Object System.Drawing.Size(100, 40)
$button3.Text = "Script 3"
$button3.Add_Click({
    Start-Process powershell.exe -ArgumentList "-File $cachePath\Script3.ps1"
})
$form.Controls.Add($button3)

# Show the form
$form.ShowDialog()
