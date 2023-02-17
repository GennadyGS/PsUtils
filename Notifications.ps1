$imagesPath = "$PSScriptRoot/Images"
$notifacationsModule = "$PSScriptRoot/PsModules/BurntToast/BurntToast/BurntToast.psm1"
$notificationsEnabled = Test-Path $notifacationsModule

if ($notificationsEnabled) {
    Import-Module $notifacationsModule
}

Function NotifySuccess {
    param (
        $message
    )
    if ($notificationsEnabled) {
        New-BurntToastNotification -Text $message -AppLogo "$imagesPath/StatusOK_256x.png"
    }
}

Function NotifyError {
    param (
        $message
    )
    if ($notificationsEnabled) {
        New-BurntToastNotification -Text $message -AppLogo "$imagesPath/StatusCriticalError_256x.png"
    }
}
