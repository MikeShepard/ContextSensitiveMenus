ipmo ContextSensitiveMenus -force
ipmo wpf_dsl -force


$treeContents=get-service | select -first 25| Group-Object -Property Status -AsHashTable 
$w= window {TreeView Blah -contents $treeContents} 

Update-TypeData -TypeName System.ServiceProcess.ServiceController -MemberType ScriptMethod -MemberName ToString -Value {$this.Name} -force
                
add-typemenuitem -typename System.ServiceProcess.ServiceController -label 'Start Service' -action {$args[0] | select-object *}
add-typemenuitem -typename System.ServiceProcess.ServiceController -label 'Stop Service' -action {$args[0] | select-object *}
add-typemenuitem -typename System.ServiceProcess.ServiceController -items @{'Start Service2'={$args[0] | start-service}
                                                                            'Stop Service2' ={$args[0] | stop-service}
                                                                           }
add-ContextMenuToControl -window $w -controlName Blah
$w.ShowDialog()

