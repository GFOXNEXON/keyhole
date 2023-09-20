#Load DLLs
Add-Type -AssemblyName System.Windows.Forms

# variable to sync between runspaces
$sync = [Hashtable]::Synchronized(@{})
$sync.PSScriptRoot = $PSScriptRoot
$sync.version = "23.09.14"
$sync.configs = @{}
$sync.ProcessRunning = $false


if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Winutil needs to be run as Administrator. Attempting to relaunch."
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList “iwr -useb https://raw.githubusercontent.com/GFOXNEXON/keyhole/main/keyhole.ps1 | iex”
    break
}
Write-Host "Special Sauce"
Add-Type -AssemblyName System.Windows.Forms


 #>



# Load the image
#$image = [System.Drawing.Image]::FromFile('D:\SpecialSauce\ss.png')

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


# Variables
$cachePath = "C:\SpecialSauceCache"

# Create cache directory if it doesn't exist
if (!(Test-Path $cachePath)) {
    New-Item -ItemType Directory -Path $cachePath | Out-Null
}



# Function to copy files from USB drive to local cache if they don't already exist
function CopyToCache($source, $destination) {
    if (!(Test-Path $destination)) {
        Copy-Item $source $destination
    }
}


# Copy scripts and installers to the local cache
#CopyToCache "D:\SpecialSauce\enrol-kit.ps1" "$cachePath\enrol-kit.ps1"
#CopyToCache "D:\SpecialSauce\AutopilotNuke.ps1" "$cachePath\AutopilotNuke.ps1"
#CopyToCache "D:\SpecialSauce\Script3.ps1" "$cachePath\Script3.ps1"
#CopyToCache "D:\SpecialSauce\Software\AACOXDR-7-8-0-64267_x64.msi" "$cachePath\AACOXDR-7-8-0-64267_x64.msi"
#CopyToCache "D:\SpecialSauce\Software\AcroRdrDCx642200320258_MUI.exe" "$cachePath\AcroRdrDCx642200320258_MUI.exe"
#CopyToCache "D:\SpecialSauce\Software\GoogleChrome.msi" "$cachePath\GoogleChrome.msi"
#CopyToCache "D:\SpecialSauce\tboneupdate.exe" "$cachePath\tboneupdate.exe"



# Get the hostname and serial number
$hostname = $env:COMPUTERNAME
$serial = (Get-WmiObject -Class Win32_BIOS).SerialNumber

# Create the form and set its properties
$form = New-Object System.Windows.Forms.Form
$form.Text = "Special Sauce"
$form.Size = New-Object System.Drawing.Size(800, 500)

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
    Start-Process powershell.exe -ArgumentList "-File D:\SpecialSauce\enrol-kit.ps1"
})
$form.Controls.Add($button1)

# Create the button to launch the second script
$button2 = New-Object System.Windows.Forms.Button
$button2.Location = New-Object System.Drawing.Point(120, 80)
$button2.Size = New-Object System.Drawing.Size(100, 40)
$button2.Text = "UNCLUSTERFUCK DEVICE"
$button2.Add_Click({
    Start-Process powershell.exe -ArgumentList "-File D:\SpecialSauce\enrol-kitadvanced.ps1"
})
$form.Controls.Add($button2)

# Create the button to launch the third script
$button3 = New-Object System.Windows.Forms.Button
$button3.Location = New-Object System.Drawing.Point(230, 80)
$button3.Size = New-Object System.Drawing.Size(100, 40)
$button3.Text = "SFC DISM"
$button3.Add_Click({
     Start-Process PowerShell -ArgumentList "Write-Host '(1/4) Chkdsk' -ForegroundColor Green; Chkdsk /scan;
    Write-Host '`n(2/4) SFC - 1st scan' -ForegroundColor Green; sfc /scannow;
    Write-Host '`n(3/4) DISM' -ForegroundColor Green; DISM /Online /Cleanup-Image /Restorehealth;
    Write-Host '`n(4/4) SFC - 2nd scan' -ForegroundColor Green; sfc /scannow;
    Read-Host '`nPress Enter to Continue'" -verb runas
})
$form.Controls.Add($button3)


# Create the label for the software installs section
$softwareInstallsLabel = New-Object System.Windows.Forms.Label
$softwareInstallsLabel.Location = New-Object System.Drawing.Point(10, 230) # Adjust the location as needed
$softwareInstallsLabel.Size = New-Object System.Drawing.Size(200, 20)
$softwareInstallsLabel.Text = "Software Installs:"
$form.Controls.Add($softwareInstallsLabel)


# Create the button to launch XDR
$button4 = New-Object System.Windows.Forms.Button
$button4.Location = New-Object System.Drawing.Point(10, 260)
$button4.Size = New-Object System.Drawing.Size(100, 40)
$button4.Text = "XDR"
$button4.Add_Click({
    Start-Process $cachePath\AACOXDR-7-8-0-64267_x64.msi
})
$form.Controls.Add($button4)


# Create the button to launch Adobe Reader
$button5 = New-Object System.Windows.Forms.Button
$button5.Location = New-Object System.Drawing.Point(120, 260)
$button5.Size = New-Object System.Drawing.Size(100, 40)
$button5.Text = "Adobe Reader"
$button5.Add_Click({
Start-Process "$cachePath\AcroRdrDCx642200320258_MUI.exe"
})
$form.Controls.Add($button5)


# Create the button to install latest Chrome
$button6 = New-Object System.Windows.Forms.Button
$button6.Location = New-Object System.Drawing.Point(230, 260)
$button6.Size = New-Object System.Drawing.Size(150, 40)
$button6.Text = "Install Latest Chrome"
$button6.Add_Click({
    $tempFile = "D:\SpecialSauce\Software\GoogleChrome.msi"
    Write-Output "Chrome installer downloaded successfully."
    Write-Output "Installing Chrome..."
    Start-Process msiexec.exe -ArgumentList "/i `"$tempFile`" /qb" -Wait
    Write-Output "Chrome installed successfully."
})
$form.Controls.Add($button6)


# Create the button to launch XDR
$button7 = New-Object System.Windows.Forms.Button
$button7.Location = New-Object System.Drawing.Point(200, 150)
$button7.Size = New-Object System.Drawing.Size(150, 40)
$button7.Text = "N-able"
$button7.Add_Click({
 Write-Host "Standby....."


})
$form.Controls.Add($button7)


# Create the label for the cache location
$cacheLabel = New-Object System.Windows.Forms.Label
$cacheLabel.Location = New-Object System.Drawing.Point(10, 50)
$cacheLabel.Size = New-Object System.Drawing.Size(380, 20)
$cacheLabel.Text = "Cache location: $cachePath"
$form.Controls.Add($cacheLabel)






# Create the button to destroy the cache
$button8 = New-Object System.Windows.Forms.Button
$button8.Location = New-Object System.Drawing.Point(200, 400)
$button8.Size = New-Object System.Drawing.Size(150, 40)
$button8.Text = "Destroy Cache"
$button8.Add_Click({
    Remove-Item -Recurse -Force $cachePath -ErrorAction SilentlyContinue
    $cacheLabel.ForeColor = [System.Drawing.Color]::Red
    $cacheLabel.Text = "Cache location: $cachePath (Absent)"
    [System.Windows.Forms.MessageBox]::Show("Cache destroyed.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$form.Controls.Add($button8)


# Create the button to reboot the computer
$buttonReboot = New-Object System.Windows.Forms.Button
$buttonReboot.Location = New-Object System.Drawing.Point(400, 270)
$buttonReboot.Size = New-Object System.Drawing.Size(150, 40)
$buttonReboot.Text = "Reboot"
$buttonReboot.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to restart?", "Confirmation", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
    if ($result -eq "Yes") {
        Restart-Computer -Confirm:$false
        Write-Output "SIGTERM"
    }
})
$form.Controls.Add($buttonReboot)

# Create the button to open MSEDGE
$buttonSettings = New-Object System.Windows.Forms.Button
$buttonSettings.Location = New-Object System.Drawing.Point(200, 430)  # Adjust coordinates as needed
$buttonSettings.Size = New-Object System.Drawing.Size(150, 40)
$buttonSettings.Text = "MSEDGE"
$buttonSettings.Add_Click({
    Start-Process "msedge"
})
$form.Controls.Add($buttonSettings)

# Create the button to open the settings
$buttonSettings = New-Object System.Windows.Forms.Button
$buttonSettings.Location = New-Object System.Drawing.Point(200, 310)  # Adjust coordinates as needed
$buttonSettings.Size = New-Object System.Drawing.Size(150, 40)
$buttonSettings.Text = "Settings"
$buttonSettings.Add_Click({
    Start-Process "ms-settings:"
})
$form.Controls.Add($buttonSettings)


# Create the button to open the network connections
$buttonNetwork = New-Object System.Windows.Forms.Button
$buttonNetwork.Location = New-Object System.Drawing.Point(50, 300)  # Adjust coordinates as needed
$buttonNetwork.Size = New-Object System.Drawing.Size(150, 40)
$buttonNetwork.Text = "Network Connections"
$buttonNetwork.Add_Click({
    Start-Process "ms-settings:network"
})
$form.Controls.Add($buttonNetwork)

$buttonResetPC = New-Object System.Windows.Forms.Button
$buttonResetPC.Location = New-Object System.Drawing.Point(50, 350)  # Adjust coordinates as needed
$buttonResetPC.Size = New-Object System.Drawing.Size(150, 40)
$buttonResetPC.Text = "Reset This PC"
$buttonResetPC.Add_Click({
    Start-Process "ms-settings:recovery"
})
$form.Controls.Add($buttonResetPC)

# Create the button to open the workplace settings (Intune sync)
$buttonSync = New-Object System.Windows.Forms.Button
$buttonSync.Location = New-Object System.Drawing.Point(400, 450)  # Adjust coordinates as needed
$buttonSync.Size = New-Object System.Drawing.Size(150, 40)
$buttonSync.Text = "Sync Autopilot"
$buttonSync.Add_Click({
    Start-Process "ms-settings:workplace"
})
$form.Controls.Add($buttonSync)



# Create the button to open Windows Explorer
$buttonExplorer = New-Object System.Windows.Forms.Button
$buttonExplorer.Location = New-Object System.Drawing.Point(400, 400)  # Adjust coordinates as needed
$buttonExplorer.Size = New-Object System.Drawing.Size(150, 40)
$buttonExplorer.Text = "Explorer"
$buttonExplorer.Add_Click({
    Start-Process "explorer.exe"
})
$form.Controls.Add($buttonExplorer)



# Show the form
$form.ShowDialog() | Out-Null

