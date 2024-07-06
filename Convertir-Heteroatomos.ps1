[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $InputFile = "C:\Users\feder\Facultad de Ingenieria - Universidad ORT Uruguay\2024 Obl Bioinfo2 CM-FD - General\07-03\heteroatomos-input.txt",
    [Parameter()]
    [string]
    $OuputFile = "C:\Users\feder\Facultad de Ingenieria - Universidad ORT Uruguay\2024 Obl Bioinfo2 CM-FD - General\07-03\heteroatomos-output.txt",
    [Parameter()]
    [int]
    $start = 12835
)

if (Test-Path $OuputFile) {
    Remove-Item $OuputFile
}
$contador = 0
$archivo = Get-Content $inputFile
$largo = $archivo.Length
$archivo | ForEach-Object {
    # Extraer la primera columna (4 caracteres)
    $col1 = $_.Substring(0, 6)
    # Extraer la segunda columna (5 caracteres, quitar espacios en blanco)
    #$col2 = [int]$_.Substring(6, 7).Trim()
    # Extraer la tercera columna (10 caracteres)
    $col3 = $_.Substring(11, $_.Length - 11)

    # Sumar $start a la segunda columna
    $newCol2 = $start
    $start++

    # Formatear la nueva segunda columna para mantener el ancho fijo de 5 caracteres
    $newCol2 = "{0,5}" -f $newCol2

    # Construir la nueva línea
    $newLine = $col1 + $newCol2 + $col3

    # Escribir la nueva línea en el archivo de salida
    $contador ++
    $porcentaje = [System.Math]::Round(100 * $contador / $largo)
    Write-Progress -Activity "Writing file..." -Status "$newCol2" -PercentComplete $porcentaje 
    Add-Content -Path $OuputFile -Value $newLine
}