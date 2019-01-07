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

# VSCode extensions
code --install-extension Angular.ng-template
code --install-extension christian-kohler.npm-intellisense
code --install-extension christian-kohler.path-intellisense
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension cyrilletuzi.angular-schematics
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension davidbabel.vscode-simpler-icons
code --install-extension dbaeumer.vscode-eslint
code --install-extension docsmsft.docs-article-templates
code --install-extension docsmsft.docs-authoring-pack
code --install-extension docsmsft.docs-markdown
code --install-extension docsmsft.docs-preview
code --install-extension doggy8088.angular-extension-pack
code --install-extension donjayamanne.githistory
code --install-extension DSKWRK.vscode-generate-getter-setter
code --install-extension eamodio.gitlens
code --install-extension ecmel.vscode-html-css
code --install-extension EditorConfig.EditorConfig
code --install-extension eg2.tslint
code --install-extension eg2.vscode-npm-script
code --install-extension Equinusocio.vsc-material-theme
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-rename-tag
code --install-extension HookyQR.beautify
code --install-extension IBM.output-colorizer
code --install-extension idbartosz.darkpp-italic
code --install-extension infinity1207.angular2-switcher
code --install-extension joelday.docthis
code --install-extension johnpapa.Angular2
code --install-extension johnpapa.winteriscoming
code --install-extension jrebocho.vscode-random
code --install-extension krizzdewizz.refactorix
code --install-extension MariusAlchimavicius.json-to-ts
code --install-extension markvincze.code-fragments
code --install-extension Mikael.Angular-BeastCode
code --install-extension ms-docfx.DocFX
code --install-extension ms-mssql.mssql
code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.PowerShell
code --install-extension ms-vscode.typescript-javascript-grammar
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension nikitaKunevich.snippet-creator
code --install-extension NoHomey.angular-io-code
code --install-extension pflannery.vscode-versionlens
code --install-extension pmneo.tsimporter
code --install-extension pnp.polacode
code --install-extension quicktype.quicktype
code --install-extension redhat.java
code --install-extension robertohuertasm.vscode-icons
code --install-extension sdras.night-owl
code --install-extension Shan.code-settings-sync
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension stringham.move-ts
code --install-extension tariky.easy-snippet-maker
code --install-extension vscjava.vscode-java-debug
code --install-extension vscjava.vscode-java-dependency
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-maven
code --install-extension WallabyJs.quokka-vscode
code --install-extension wayou.vscode-todo-highlight
code --install-extension wesbos.theme-cobalt2
code --install-extension wix.vscode-import-cost
code --install-extension xabikos.JavaScriptSnippets
code --install-extension yzhang.markdown-all-in-one

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

# Install VS
choco install -y visualstudio2017community --package-parameters="'--add Microsoft.VisualStudio.Component.Git'"
Update-SessionEnvironment #refreshing env due to Git install

# VS Workloads
choco install -y visualstudio2017-workload-azure
choco install -y visualstudio2017-workload-universal
choco install -y visualstudio2017-workload-manageddesktop
choco install -y visualstudio2017-workload-nativedesktop
choco install -y visualstudio2017-workload-data 
choco install -y visualstudio2017-workload-netcoretools
choco install -y visualstudio2017-workload-netcrossplat
choco install -y visualstudio2017-workload-netweb
choco install -y visualstudio2017-workload-node
choco install -y visualstudio2017-workload-webcrossplat
choco install -y visualstudio2017-workload-xamarinbuildtools

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
