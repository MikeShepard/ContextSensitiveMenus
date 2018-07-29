<#
.SYNOPSIS
Adds custom context menu to control for type-sensitive menu items

.DESCRIPTION
Adds custom context menu to control for type-sensitive menu items.  Event handler inspects PSTypeNames of object clicked on, builds appropriate menu,
displays it, and responds to menu item clicks

.PARAMETER window
The window that the control is in

.PARAMETER controlName
The name of the control (used if Control is not passed)

.PARAMETER control
The control

.PARAMETER Output
An optional scriptblock to use to send output from a menu clicked event.

.EXAMPLE
An example

.NOTES
General notes
#>
function Add-ContextMenuToControl{

Param([Parameter(ParameterSetName='NamedControl')]$window,
      [Parameter(ParameterSetName='NamedControl')]$controlName,
      [Parameter(ParameterSetName='ControlObject')]$control,
      [scriptblock]$Output)
if($output){
  $script:output=$output
}
if(-not $control){
    $control=$window.GetControlByName($controlname)
}
$control.ContextMenu=new-object System.Windows.Controls.ContextMenu
$control.Add_ContextMenuOpening({
    Param($sender,$e)
    if($this| get-member -Name Items){
        $selectedItem=$this.SelectedItem
        $clickedItem=$selectedItem
    } else {
        $selectedItem=$this
        $clickedItem=$this
    }
    if($SelectedItem -is [System.Windows.Controls.Control] -and $selectedItem.Tag){
      $selectedItem=$selectedItem.Tag
    }
    if($null -eq $selectedItem){
        $e.handled=$true
    } else {
        $items=get-RelevantMenuItems -item $selectedItem
        $items |foreach-object {
                 $item=$_
                 $script=[scriptblock]($item.Tag)
                 $useControl=[boolean]($item | get-member UseControl)
                 $item.Add_click({
                       #LocalOutHost '--------------------'
                       if($useControl){
                         $selectedItem=$clickedItem
                       }
                       $values=& $script $selectedItem
                       $values | out-string -Width 200 | LocalOutHost
                       #LocalOutHost '--------------------'
                    }.GetNewClosure())
                 $this.ContextMenu.Items.Add($item) | out-null}
    }
})
$control.add_ContextMenuClosing({
    $this.ContextMenu.Items.Clear()
 })
}
