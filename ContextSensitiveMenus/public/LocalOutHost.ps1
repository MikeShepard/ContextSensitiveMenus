<#
.SYNOPSIS
Function which allows output to be routed to either out-host or a custom scriptblock

.DESCRIPTION
Long description

.PARAMETER params
Pipeline input of items to be output

.EXAMPLE
An example

.NOTES
General notes
#>
function LocalOutHost{
    param([parameter(ValueFromPipeline=$true)][PSObject]$params)
     process{
      if ($output){
         $params | & $output
      } else {
        $params | out-host
      }
      }
    }