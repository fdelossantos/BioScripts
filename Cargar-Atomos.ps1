# Define la ruta del archivo PDB
$pdbFilePath = "C:\Users\feder\Facultad de Ingenieria - Universidad ORT Uruguay\2024 Obl Bioinfo2 CM-FD - General\8JD3\coordenadas.txt"

# Lee las líneas del archivo PDB
$pdbLines = Get-Content -Path $pdbFilePath # | Select-String "^ATOM"

# Conexión a la base de datos SQL Server
$server = "localhost"
$database = "Molecula"
$table = "Atomos"
$connectionString = "Server=$server;Database=$database;Integrated Security=True;TrustServerCertificate=True"

# Función para parsear las líneas ATOM del archivo PDB
function Parse-AtomLine {
    param (
        [string]$line
    )

    return @{
        RecordName = $line.Substring(0, 6).Trim()
        Serial = [int]$line.Substring(6, 5).Trim()
        Name = $line.Substring(12, 4).Trim()
        altLoc = $line.Substring(16, 1).Trim()
        resName = $line.Substring(17, 3).Trim()
        ChainID = $line.Substring(21, 1).Trim()
        ResSeq = [int]$line.Substring(22, 4).Trim()
        iCode = $line.Substring(26, 1).Trim()
        CoordX = [decimal]$line.Substring(30, 8).Trim()
        CoordY = [decimal]$line.Substring(38, 8).Trim()
        CoordZ = [decimal]$line.Substring(46, 8).Trim()
        Occupancy = [decimal]$line.Substring(54, 6).Trim()
        TempFactor = [decimal]$line.Substring(60, 6).Trim()
        Element = $line.Substring(76, 2).Trim()
        #Charge = $line.Substring(78, 2).Trim()
    }
}

# Función para insertar los datos en la base de datos SQL Server
function Insert-AtomData {
    param (
        [string]$connectionString,
        [hashtable]$atomData
    )

    $query = @"
INSERT INTO $table
    (RecordName, Serial, Name, altLoc, resName, ChainID, ResSeq, iCode, CoordX, CoordY, CoordZ, Occupancy, TempFactor, Element)
VALUES
    ('$($atomData.RecordName)', $($atomData.Serial), '$($atomData.Name)', '$($atomData.altLoc)', '$($atomData.resName)', '$($atomData.ChainID)', $($atomData.ResSeq), '$($atomData.iCode)', $($atomData.CoordX), $($atomData.CoordY), $($atomData.CoordZ), $($atomData.Occupancy), $($atomData.TempFactor), '$($atomData.Element)')
"@

    Invoke-Sqlcmd -ConnectionString $connectionString -Query $query
}

# Procesar las líneas y insertar en la base de datos
foreach ($line in $pdbLines) {
    $atomData = Parse-AtomLine -line $line
    Insert-AtomData -connectionString $connectionString -atomData $atomData
}

Write-Host "Importación completada."
