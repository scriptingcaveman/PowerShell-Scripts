[cmdletbinding()]
param(
    [Parameter(Position=0,Mandatory=$true)][string]$SourcePath,
    [Parameter(Position=1,Mandatory=$true)][string]$DestinationPath
    )

Write-Verbose -Message 'Get all files recursively relative to the SourcePath'
Get-ChildItem -Path $SourcePath -Recurse | ForEach-Object {
    Write-Verbose -Message 'Replace Source Path with Destination Path'
    $DestinationFile = $_.FullName -replace [regex]::Escape($SourcePath),$DestinationPath
    $SourceFile = $_.FullName
    Write-Verbose -Message "Getting ACL from $SourceFile"
    $ACL = Get-ACL -Path $_.FullName
    
    Write-Verbose -Message "Setting ACL on $DestinationFile"
    Set-ACL -Path $DestinationFile -AclObject $ACL
}