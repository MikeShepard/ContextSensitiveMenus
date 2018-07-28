$typeMenuItems=@{}
$output=$null
function get-RelevantMenuItems{
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
function add-typemenuitem{
param([string]$typename,
      [string]$label,
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


function Set-CustomType{
param($object,[hashtable]$property,$typename,[scriptblock]$ToString)
if(-not $object){
   $property.Add('PSTypeName',$Typename)
   $object=[pscustomobject]$property

   $object | add-member -MemberType ScriptMethod -Name ToString -Value $ToString -force
} else {
  $object.PSTypeNames.Insert($Typename,0) | out-null
}
$object
}
