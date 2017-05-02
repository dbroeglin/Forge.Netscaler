Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
if (!(Get-Module "Forge")) {
    Import-Module "Forge"
}
. "$PSScriptRoot\..\Forge.Netscaler\$sut"

Describe "New-NSNew" {
    $Name = "TestGenerator"
    $TestPath = Join-Path $TestDrive $Name 
    $Params = @{ 
        Name   = $Name
        Path   = $TestPath
        Type   = "NSTestType"
    }

    Context "-Name $Name -Path... "{
        New-NSNew @Params 

        It "should do something" {
            # TODO: Some assertions...
        }

    }
}
