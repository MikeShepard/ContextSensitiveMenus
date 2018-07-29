Import-Module WPFBot3000 -force
Import-Module ContextSensitiveMenus -force



$treeContents=@{Prod=@(Set-CustomType -property @{Name='CRM91PRD'} -typename MDS_ENV -toSTring {$this.Name}
                       Set-CustomType -property @{Name='FIN90PRD'} -typename MDS_ENV -toSTring {$this.Name})
                      }
$w= window {TreeView Blah -contents $treeContents}

add-typemenuitem -typename System.String -label 'Start Children' -action {
    $args[0].Items.Tag | ForEach-Object { "starting $($_.Name)"}
    } -UseControl
add-typemenuitem -typename System.String -label 'Stop Children' -action {
    $args[0].Items.Tag | ForEach-Object { "stopping $($_.Name)"}
    } -UseControl

add-typemenuitem -typename MDS_ENV -label 'Start Environment' -action {"starting $($args[0].Name)"}
add-typemenuitem -typename MDS_ENV -label 'Stop Environment' -action {"stopping $($args[0].Name)"}
add-ContextMenuToControl -window $w -controlName Blah
$w.ShowDialog()