$specialSymbols = ("`"", "'", "|")

Function EscapeSpecialSymbols {
    param ([Parameter(ValueFromPipeline = $true)] [string] $value)
    $result = $value
    $specialSymbols
    | ForEach-Object { $result = $result.Replace($_, "``" + $_) }
    $result
}

Function EscapeSpaces {
    param ([Parameter(ValueFromPipeline = $true)] [string] $value)
    $value.Contains(" ") ? "`"$value`"" : $value
}

Function EscapeArgument {
    param ([Parameter(ValueFromPipeline = $true)] [string] $value)
    $value
    | EscapeSpecialSymbols
    | EscapeSpaces
}

Function EscapeArguments {
    param ([string[]] $values)
    $values
    | ForEach-Object { $_ | EscapeArgument }
}

Function ArgumentsToCommandText {
    param ([string[]] $values)
    [string] (EscapeArguments $values)
}

Function ExtractPositionalArgs {
    Function DoIteration {
        param ($regularArgs, $inputArgs)
        if (!$inputArgs) {
            return ,(,@() + $regularArgs)
        }
        $head, $tail = $inputArgs
        if ($head -eq "--") {
            return ,(,$tail + $regularArgs)
        }
        return DoIteration ($regularArgs + $head) $tail
    }
    return DoIteration @() $args
}
