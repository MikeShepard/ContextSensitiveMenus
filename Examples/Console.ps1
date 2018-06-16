ipmo wpf_Dsl -force
ipmo contextsensitivemenus -force
$items=@{
          Start={$args[0] | Start-Service}
          Stop={$args[0] | Stop-Service}
          Status={$args[0] | Get-Service}
}

$w=Window {
   StackPanel {
      $script:l=ListBox Items -property @{MinWidth=300;MinHeight=400;MaxHeight=400} -contents (get-service)
      $l 
      StackPanel {
         $script:t=MultilineTextBox Editor -property @{MinWidth=300;MinHeight=200;MaxHeight=200}
         $t.PSTypeNames.Add('MDS_Editor')
         $t
         $script:t2=TextBox CommandLine -property @{MinWidth=300} 
         $t2
         $script:t3=MultilineTextBox Output -property @{MinWidth=300;MinHeight=200;MaxHeight=200;FontFamily='Consolas'}
         $t3.PSTypeNames.Add('MDS_Output')
         $t3
      } -Orientation Vertical 
   } -Orientation Horizontal

} 

$outputHandler= {
param([parameter(ValueFromPipeline=$true)][PSObject]$params) $params | 
                                     out-string | 
                                     foreach {
                                        $t3.AppendText($_)
                                        $t3.ScrollToEnd()
                                       }
}

$t2.Add_KeyDown({
    param($sender,$e) 
    if($e.Key -eq [system.windows.input.key]::Return){
      & ([ScriptBlock]::Create($this.Text)) | out-string -Width 200 | & $outputHandler
      $this.text=''
    }
})

Add-TypeMenuItem -typename System.ServiceProcess.ServiceController -items $items

$ExecuteScript={
                $script=$args[0].Text
                $sb=[ScriptBlock]::Create($script)
                & $sb
                }

$ExecuteSelected={
                $script=$args[0].SelectedText
                $sb=[ScriptBlock]::Create($script)
                & $sb 
                }


Add-TypeMenuItem -typename MDS_Editor -items @{Run=$ExecuteScript
                                               RunSelected=$ExecuteSelected}
                                                
add-typemenuitem -typename MDS_Output -items @{Clear={$args[0].Text=''}} -UseControl

Add-ContextMenuToControl -control $l 
Add-ContextMenuToControl -Control $t
Add-ContextMenuToControl -Control $t2
Add-ContextMenuToControl -Control $t3 -output $outputHandler

$w.ShowDialog() | out-null