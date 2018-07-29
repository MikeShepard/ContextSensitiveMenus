<#
.SYNOPSIS
Adds a custom typename to an object and optionally a custom ToString() method

.DESCRIPTION
Adds a custom typename to an object and optionally a custom ToString() method

.PARAMETER object
An object to add a typename to.

.PARAMETER property
A hashtable to create a custom object from and add a typename to 

.PARAMETER typename
The typename to be added

.PARAMETER ToString
An optional scriptblock to create a ToString() scriptmethod from 

.EXAMPLE
An example

.NOTES
General notes
#>
function Set-CustomType {
    param([Parameter(ParameterSetName = 'Object')]$object,
        [Parameter(ParameterSetName = 'HashTable')][hashtable]$property,
        $typename,
        [scriptblock]$ToString)
    if (-not $object) {
        $property.Add('PSTypeName', $Typename)
        $object = [pscustomobject]$property
        if ($ToString) {
            $object | add-member -MemberType ScriptMethod -Name ToString -Value $ToString -force
        }
    }
    else {
        $object.PSTypeNames.Insert($Typename, 0) | out-null
    }
    $object
}