ipmo WPFBot3000 -force
ipmo ContextSensitiveMenus -force

$files=get-childitem c:\temp -file | Select-Object -first 5

$w= window2 {textbox Fred 'Hello world'
            ListBox files $files
            Checkbox Blah
            MultiLineTextBox Output -property @{FontFamily='Consolas'}}  
                
add-typemenuitem -typename System.IO.FileInfo -label 'Show Contents' -action {Param($file) Get-Content -Path $file.FullName}
add-typemenuitem -typename System.Object -label 'Show Details' -action {$args[0] | select-object * | out-string -width 200}
add-typemenuitem -typename System.ServiceProcess.ServiceController -label 'Stop Service' -action {$args[0] | stop-service}
$txt=$w.GetControlByName('Output')
add-ContextMenuToControl -window $w -controlName Files -output {
param([parameter(ValueFromPipeline=$true)][PSObject]$params) $params | foreach {$txt.Text=$txt.Text+$_.Tostring()+"`r`n"}
}

$w.ShowDialog()