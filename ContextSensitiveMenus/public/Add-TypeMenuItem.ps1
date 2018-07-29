<#
.SYNOPSIS
Associates a set of menu item names/actions with a specific type

.DESCRIPTION
Associates a set of menu item names/actions with a specific type

.PARAMETER typename
The full typename that the menu action should be associated with

.PARAMETER label
For a single action, the text of the menu item.

.PARAMETER action
For a single action, the scriptblock to be called when the menu item is clicked

.PARAMETER items
A hashtable of labels/actions to be associated

.PARAMETER UseControl
Whether the control itself is to be considered the clicked item (as opposed to an item in a list, for example)

.EXAMPLE
An example

.NOTES
General notes
#>
function Add-Typemenuitem{
    param([string]$typename,
          [Parameter(ParameterSetName='SingleAction')][string]$label,
          [Parameter(ParameterSetName='SingleAction')][Scriptblock]$action,
          [Parameter(ParameterSetName='MultipleActions')][hashtable]$items,
          [switch]$UseControl)
          if(-not $typeMenuItems.ContainsKey($typeName)){
            $typeMenuItems[$typeName]=@{}
           }
        if($action){
               $item=@{Label=$label;Action=$action;UseControl=$useControl}

               $typeMenuItems[$typeName].Add($Label,$item)
        } else {
          foreach($menu in $items.GetEnumerator()){
                $item=@{Label=$menu.Name;Action=$menu.Value;UseControl=$useControl}
                $typeMenuItems[$typeName].Add($menu.Name,$item)
          }
        }
    }