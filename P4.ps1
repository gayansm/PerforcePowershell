$p4Repo = 'tcp:perforce:1666'

#Setup connection parameters. This must be called before calling any of the other functions.
function ConnectToPerforce{
    $userName = Read-Host "Perforce User Name"
    $password = Read-Host -assecurestring "Perforce Password"
    $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

    $env:P4PORT = $p4Repo
    $env:P4USER = $userName
    $env:P4PASSWD = $password #not recommended for shared environments. Pass in the password with -P.
}

# A new workspace is created with the current directory set as the root. The views are based on the template workspace.
# Any existing workspace can be used as a template.
function CreateWorkspaceBasedOnTemplateWorkspace{
   param(
	[string]$templateWorkspace #eg.gayansm_AU12354_6975_template_test
        [string]$newWorkspace #eg.gayansm_AU98765_new_ws
   )
   p4 client -t $templateWorkspace -o $newWorkspace | p4 client -i
}

function GetLatest{
   p4 sync
}
