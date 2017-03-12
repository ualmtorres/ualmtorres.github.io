USE RRHH;
SELECT MAX(sueldo + COALESCE(complemento, 0)) AS sueldoTotalMaximo
FROM Empleado
WHERE complemento IS NOT NULL;