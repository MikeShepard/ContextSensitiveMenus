ipmo wpf_dsl -force
ipmo ContextSensitiveMenus -force

$files=get-childitem c:\temp -file | Select-Object -first 5

$w= window2 {textbox Fred 'Hello world'
            ListBox files $files
            Checkbox Blah
            MultiLineTextBox} -Events @{Name='Fred';EventName='TextChanged';Action={$store=$this.CaretPosition;$this.Text=$This.Text.ToUpper();$this.CaretPosition=$store}}
                
add-typemenuitem -typename System.IO.FileInfo -label 'Show Contents' -action {Param($file) Get-Content -Path $file.FullName}
add-typemenuitem -typename System.Object -label 'Show Details' -action {$args[0] | select-object *}
add-typemenuitem -typename System.ServiceProcess.ServiceController -label 'Stop Service' -action {$args[0] | stop-service}
add-ContextMenuToControl -window $w -controlName Files

$w.ShowDialog()