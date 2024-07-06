-- Producido usando ChatGPT
-- https://chatgpt.com/share/4a5903be-ab57-4000-a31e-29625e022e93

WITH Distances AS (
    SELECT 
        H.RecordName AS HETATM_RecordName,
        H.Serial AS HETATM_Serial,
        H.Name AS HETATM_Name,
        H.altLoc AS HETATM_altLoc,
        H.resName AS HETATM_resName,
        H.ChainID AS HETATM_ChainID,
        H.ResSeq AS HETATM_ResSeq,
        H.iCode AS HETATM_iCode,
        H.CoordX AS HETATM_CoordX,
        H.CoordY AS HETATM_CoordY,
        H.CoordZ AS HETATM_CoordZ,
        H.Occupancy AS HETATM_Occupancy,
        H.TempFactor AS HETATM_TempFactor,
        H.Element AS HETATM_Element,
        H.Charge AS HETATM_Charge,
        A.RecordName AS ATOM_RecordName,
        A.Serial AS ATOM_Serial,
        A.Name AS ATOM_Name,
        A.altLoc AS ATOM_altLoc,
        A.resName AS ATOM_resName,
        A.ChainID AS ATOM_ChainID,
        A.ResSeq AS ATOM_ResSeq,
        A.iCode AS ATOM_iCode,
        A.CoordX AS ATOM_CoordX,
        A.CoordY AS ATOM_CoordY,
        A.CoordZ AS ATOM_CoordZ,
        A.Occupancy AS ATOM_Occupancy,
        A.TempFactor AS ATOM_TempFactor,
        A.Element AS ATOM_Element,
        SQRT(
            POWER(H.CoordX - A.CoordX, 2) +
            POWER(H.CoordY - A.CoordY, 2) +
            POWER(H.CoordZ - A.CoordZ, 2)
        ) AS Distance
    FROM 
        Atomos H
    INNER JOIN 
        Atomos A ON A.RecordName = 'ATOM'
    WHERE 
        H.RecordName = 'HETATM'
)
SELECT 
    HETATM_RecordName,
    HETATM_Serial,
    HETATM_Name,
    HETATM_altLoc,
    HETATM_resName,
    HETATM_ChainID,
    HETATM_ResSeq,
    HETATM_iCode,
    HETATM_CoordX,
    HETATM_CoordY,
    HETATM_CoordZ,
    HETATM_Occupancy,
    HETATM_TempFactor,
    HETATM_Element,
    HETATM_Charge,
    ATOM_RecordName,
    ATOM_Serial,
    ATOM_Name,
    ATOM_altLoc,
    ATOM_resName,
    ATOM_ChainID,
    ATOM_ResSeq,
    ATOM_iCode,
    ATOM_CoordX,
    ATOM_CoordY,
    ATOM_CoordZ,
    ATOM_Occupancy,
    ATOM_TempFactor,
    ATOM_Element,
    Distance
FROM 
    Distances
WHERE 
    Distance = (
        SELECT MIN(Distance)
        FROM Distances D2
        WHERE D2.HETATM_Serial = Distances.HETATM_Serial
    )
ORDER BY 
    HETATM_Serial;
