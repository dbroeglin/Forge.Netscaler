Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge.Netscaler\$sut"

Describe "New-NSClear" {
    It "should just work" {
        # TODO: an actual test
    }
}