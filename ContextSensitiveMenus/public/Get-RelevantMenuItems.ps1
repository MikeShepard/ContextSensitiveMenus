<#
.SYNOPSIS
Outputs a list of menu items that are associated with the PSTypenames of an object

.DESCRIPTION
Outputs a list of menu items that are associated with the PSTypenames of an object

.PARAMETER item
The item to get relevant menu items for.  Each typename in PSTypeNames will potentially provide menu items.

.EXAMPLE
An example

.NOTES
General notes
#>
function Get-RelevantMenuItems{
    param($item)
    foreach($type in $item.PSTypeNames){
        if($typeMenuItems.ContainsKey($type)){
            $typeMenuItems[$type].Values | foreach-object {
                $menuitem=New-object System.Windows.Controls.MenuItem -property @{Header=$_.label}
                $menuitem.Tag=$_.action;
                if($_.UseControl){$menuitem | add-member -MemberType NoteProperty -Name UseControl -Value $True}
                $menuitem
            }
        }
    }
}