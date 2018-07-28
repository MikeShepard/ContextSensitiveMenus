Add-Type -AssemblyName PresentationFramework

$typeMenuItems=@{}
function get-wpfMenu{
    $t=new-object System.Windows.Controls.ContextMenu 
    $t 
}
function get-RelevantMenuItems{
param($item)
foreach($type in $item.PSTypeNames){
    if($typeMenuItems.ContainsKey($type)){
        $typeMenuItems[$type].Values | foreach-object {
            $menuitem=New-object System.Windows.Controls.MenuItem -property @{Header=$_.label}
            $menuitem.Tag=$_.action;
            $menuitem
        }
    }
}
}
function add-typemenuitem{
param([string]$typename,
      [string]$label,
      [Scriptblock]$action)

      if(-not $typeMenuItems.ContainsKey($typeName)){
        $typeMenuItems[$typeName]=@{}
       }
       $item=@{Label=$label;Action=$action}

       $typeMenuItems[$typeName].Add($Label,$item)
}

$w = new-object system.windows.window  -Property @{    SizeToContent = 'WidthandHeight'}

$lb=new-object System.Windows.Controls.ListBox -Property @{Name='list';MinWidth=250}
$lb.ContextMenu=get-WPFMenu
$lb.add_ContextMenuOpening({
    Param($sender,$e)
    $selectedItem=$lb.SelectedItem
    if($selectedItem -eq $null){
        $e.handled=$true 
    } else {
        $items=get-RelevantMenuItems -item $selectedItem
        $items |foreach-object {
                 $item=$_
                 $script=[scriptblock]($item.Tag)

                $item.Add_click({
                       write-host '--------------------'
                       & $script $selectedItem | out-host
                       write-host '--------------------'
                    }.GetNewClosure()) 
                 $lb.ContextMenu.Items.Add($item) | out-null}
    }
})

$lb.add_ContextMenuClosing({
    $lb.ContextMenu.Items.Clear()
 })
get-childitem c:\temp -file| select-object -first 5 | foreach-object{
     $lb.Items.add($_)
}

$lb.Items.Add((get-service Spooler))
$w.Content=$lb

add-typemenuitem -typename System.IO.FileInfo -label 'Show Contents' -action {Param($file) Get-Content -Path $file.FullName}
add-typemenuitem -typename System.Object -label 'Show Details' -action {$args[0] | select-object *}
add-typemenuitem -typename System.ServiceProcess.ServiceController -label 'Stop Service' -action {$args[0] | stop-service}
$w.ShowDialog()

