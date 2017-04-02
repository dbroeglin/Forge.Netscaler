function New-NSNew {
    <#
    .SYNOPSIS
        Generates a skeleton 'New-NS*' function.

    .DESCRIPTION
        Generates a skeleton 'New-NS*' function.

    .EXAMPLE
        New-NSNew -Name Bar -Parameter a,b -ShouldProcessLabel "Create new bar" -Description "Create a new bar entity"

        Creates a 'New-NSBar' function.

    .PARAMETER Name
        TODO.

    .PARAMETER Path
        TODO.

    .PARAMETER ShouldProcessLabel
        ShouldProcessLabel description.

    .PARAMETER Parameter
        Parameter description.


    .PARAMETER Description
        TODO: Description description.
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact='Low')]
    Param(
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [String]$Path = "$Name",

        [String]$Description = "TODO: Description",

        [Parameter(Mandatory = $true)]
        [String]$Type,

        [String]$ShouldProcessLabel,

        [String[]]$Parameter = @()
    )
    Begin {
        Initialize-ForgeContext -SourceRoot (Join-Path $PSScriptRoot "Templates") `
            -DestinationPath $Path
    }
    Process {
        $FunctionName  = "Get-NS$Name"
        if (!$PSCmdlet.ShouldProcess($Name, "Create $FunctionName")) {
            return
        }
        $Author = Get-ValueOrGitOrDefault $Author "user.user" ""
        $CopyrightYear = Get-Date -UFormat %Y

        Set-ForgeBinding @{
            FunctionName       = $FunctionName
            Name               = $Name
            Description        = $Description
            Author             = $Author
            CopyrightYear      = $CopyrightYear
            ConfirmImpactLevel = "low"           
        }

        # New-ForgeDirectory -Destination Test > $Null
        # Copy-ForgeFile -Source "README.md"
    }
}