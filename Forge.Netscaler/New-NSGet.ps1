function New-NSGet {
    <#
    .SYNOPSIS
        TODO.

    .DESCRIPTION
        TODO: description.

    .EXAMPLE
        New-NSGet -Name MyName

        Would generate a new Get-NSMyName function.

    .PARAMETER Name
        Name of the entity for which the function is generated.

    .PARAMETER Path
        Path where the function should be generated.

    .PARAMETER Type
        Type of netscaler object the function retrieves.

    .PARAMETER Label
        Label to use in the function documentation.

    .PARAMETER FilterList
        Array of filters the function will allow. 

    .PARAMETER Author
        Author of this function

    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact='Low')]
    Param(
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [String]$Path = ".\",

        [String]$Type = $Name.ToLower(),
    
        [Parameter(Mandatory = $true)]
        [String]$Label,

        [Hashtable]$FilterList = @{},  

        [Switch]$Arguments,

        [String]$Author
    )
    Begin {
        Initialize-ForgeContext -SourceRoot (Join-Path $PSScriptRoot "Templates") `
            -DestinationPath $Path
    }
    Process {
        if (!$PSCmdlet.ShouldProcess($Name, "Create New Netscaler Get")) {
            return
        }
        $FunctionName  = "Get-NS$Name"
        $Author = Get-ValueOrGitOrDefault $Author "user.user" ""
        $CopyrightYear = Get-Date -UFormat %Y

        Set-ForgeBinding @{
            Name          = $Name
            FunctionName  = $FunctionName
            Type          = $Type
            Label         = $Label
            FilterList    = $FilterList
            Arguments     = $Arguments
            Author        = $Author
            CopyrightYear = $CopyrightYear
        }

        Copy-ForgeFile -Source "NSGet" -Destination "$FunctionName.ps1"
    }
}
