USE RRHH;
SELECT * 
FROM Empleado
WHERE empleo NOT IN ('Vendedor', 'Directivo', 'Ordenanza');