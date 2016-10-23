Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
if (!(Get-Module "Forge")) {
    Import-Module "Forge"
}
. "$PSScriptRoot\..\Forge.Netscaler\$sut"

Describe "New-NSGet" {
    $Name = "TestGenerator"
    $Label = "Test generator label"
    $Params = @{ 
        Name   = $Name
        Label  = $Label
        Path   = $TestDrive
    }

    Context "-Name $Name -Label '$Label' -Path... "{
        New-NSGet @Params

        It "should do something" {
            Join-Path $TestDrive "Get-NS$Name.ps1" | Should Exist
        }
    }
}

