function New-NSGet {
    <#
    .SYNOPSIS
        Creates a new "Get" function for the Netscaler Module.

    .DESCRIPTION
        Creates a new "Get" function for the Netscaler Module.

    .EXAMPLE
        New-NSGet -Name MyName

        Would generate a new Get-NSMyName function.

    .PARAMETER Name
        Name of the entity for which the function is generated.

    .PARAMETER ResourceIdParamName
        Name of the paramter that will be used to identify a Nitro resource by
        its identifier.

        Default value: Name

    .PARAMETER Path
        Path where the function should be generated. By default it will be generated
        in ./Netscaler/Public/

    .PARAMETER Type
        Type of netscaler object the function retrieves.

    .PARAMETER Label
        Label to use in the function documentation.

    .PARAMETER Filters
        Array of filters the function will allow. 

    .PARAMETER Author
        Author of this function

    .PARAMETER Partial
        If true, a note is added to the comment-base help topic to indicate thate the
        implemenation is only partial.

    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact='Low')]
    Param(
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [String]$ResourceIdParamName = "Name",

        [String]$Path = "Netscaler/Public/",

        [String]$Type = $Name.ToLower(),
    
        [Parameter(Mandatory = $true)]
        [String]$Label,

        [Hashtable]$Filters = @{},  

        [Switch]$Arguments,

        [String]$Author,

        [Switch]$Partial
    )

    Begin {
        Initialize-ForgeContext -SourceRoot (Join-Path $PSScriptRoot "Templates") `
            -DestinationPath $Path
    }
    Process {
        function PrepareFilters {
            Param($Filters)
            $Result = [ordered]@{}

            $Filters.GetEnumerator() | ForEach-Object {
                $FilterName, $FilterDesc = $_.Key, $_.Value

                if ($FilterDesc -is [String]) {
                    $FilterDesc = @($FilterDesc, $FilterDesc)
                } 

                $Result[$FilterName] = $FilterDesc
            }
            $Result
        }
        if (!$PSCmdlet.ShouldProcess($Name, "Create New Netscaler Get")) {
            return
        }
        $FunctionName  = "Get-NS$Name"
        $Author = Get-ValueOrGitOrDefault $Author "user.user" ""
        $CopyrightYear = Get-Date -UFormat %Y

        Set-ForgeBinding @{
            Name                = $Name
            ResourceIdParamName = $ResourceIdParamName
            FunctionName        = $FunctionName
            Type                = $Type
            Label               = $Label
            Filters             = PrepareFilters $Filters
            Arguments           = $Arguments
            Author              = $Author
            CopyrightYear       = $CopyrightYear
            Partial             = $Partial
        }

        Copy-ForgeFile -Source "NSGet" -Destination "$FunctionName.ps1"
    }
}
