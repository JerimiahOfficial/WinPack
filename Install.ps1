# Variables
$Steam      = "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"
$Discord    = "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x64"
$LibreWolf  = "https://gitlab.com/api/v4/projects/44042130/packages/generic/librewolf/122.0.1-2/librewolf-122.0.1-2-windows-x86_64-setup.exe"
$PortMaster = "https://updates.safing.io/latest/windows_amd64/packages/portmaster-installer.exe"
$Nvidia     = "https://us.download.nvidia.com/nvapp/client/10.0.0.499/NVIDIA_app_beta_v10.0.0.499.exe"
$Corsair    = "https://www3.corsair.com/software/CUE_V5/public/modules/windows/installer/Install%20iCUE.exe"
$links = @($Steam, $Discord, $LibreWolf, $PortMaster, $Nvidia, $Corsair)

# Download installers
foreach ($link in $links) {
    if (!$link.EndsWith(".exe")) { 
        $request = Invoke-WebRequest -Uri $link -MaximumRedirection 0 -ErrorAction SilentlyContinue
        $regex = '<a href="([^"]+)">([^<]+)</a>'
        $link = [regex]::Match($request, $regex).Groups[1].Value
    }

    $installerPath = Join-Path $env:HOMEPATH\downloads (Split-Path $link -Leaf).Replace("%20", " ")
    Invoke-WebRequest -Uri $link -OutFile $installerPath -ErrorAction Stop
}
