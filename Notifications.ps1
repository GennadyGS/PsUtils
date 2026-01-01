$imagesPath = "$PSScriptRoot/Images"
$notificationsModule = "$PSScriptRoot/PsModules/BurntToast/BurntToast/BurntToast.psm1"
$notificationsEnabled = Test-Path $notificationsModule

if ($notificationsEnabled) {
    Import-Module $notificationsModule
}

Function NotifySuccess {
    param (
        $message
    )
    if ($notificationsEnabled) {
        New-BurntToastNotification -Text $message -AppLogo "$imagesPath/StatusOK_256x.png"
    }
}

Function NotifyWarning {
    param (
        $message
    )
    if ($notificationsEnabled) {
        New-BurntToastNotification -Text $message -AppLogo "$imagesPath/StatusWarning_256x.png"
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
