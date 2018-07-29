---
external help file: contextsensitivemenus-help.xml
Module Name: contextsensitivemenus
online version:
schema: 2.0.0
---

# add-typemenuitem

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### SingleAction
```
add-typemenuitem [-typename <String>] [-label <String>] [-action <ScriptBlock>] [-UseControl]
 [<CommonParameters>]
```

### MultipleActions
```
add-typemenuitem [-typename <String>] [-label <String>] [-items <Hashtable>] [-UseControl] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -UseControl
{{Fill UseControl Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -action
{{Fill action Description}}

```yaml
Type: ScriptBlock
Parameter Sets: SingleAction
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -items
{{Fill items Description}}

```yaml
Type: Hashtable
Parameter Sets: MultipleActions
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -label
{{Fill label Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -typename
{{Fill typename Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
