# Description: Boxstarter Script
# Author: Microsoft
# My own Personal Setup

Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$strpos = $helperUri.LastIndexOf("/personal/")
$helperUri = $helperUri.Substring(0, $strpos)
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "SystemConfiguration.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "Browsers.ps1";

executeScript "HyperV.ps1";
RefreshEnv
executeScript "WSL.ps1";
RefreshEnv
executeScript "Docker.ps1";

# Install tools in WSL instance
write-host "Installing tools inside the WSL distro..."
Ubuntu1804 run apt install nodejs -y

# Install VS
choco install -y visualstudio2017community --package-parameters="'--add Microsoft.VisualStudio.Component.Git'"
Update-SessionEnvironment #refreshing env due to Git install

#--- UWP Workload and installing Windows Template Studio ---
choco install -y visualstudio2017-workload-azure
choco install -y visualstudio2017-workload-universal
choco install -y visualstudio2017-workload-manageddesktop
choco install -y visualstudio2017-workload-nativedesktop

# personalize
## utils
choco install -y conemu
choco install -y ditto
choco install -y greenshot
choco install -y adobereader
choco install -y vlc
choco install -y youtube-dl
choco install -y aria2
choco install -y keepass.install
choco install -y rufus

## to create chocolatey packages
choco install -y ussf
choco install -y checksum

## development
choco install -y node
choco install -y firacode 
choco install -y postman

# checkout recent projects
mkdir C:\github
cd C:\github
git.exe clone https://github.com/ddieppa/windows-dev-box-setup-scripts.git
git.exe clone https://github.com/ddieppa/colors.git
git.exe clone https://github.com/ddieppa/ddieppa.github.io.git
git.exe clone https://github.com/ddieppa/bitandbang.git

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
