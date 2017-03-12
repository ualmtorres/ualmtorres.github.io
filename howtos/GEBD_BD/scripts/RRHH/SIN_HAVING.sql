USE RRHH;
SELECT YEAR(fechaEntrada), COUNT(*) AS empleados
FROM Empleado
WHERE sueldo BETWEEN 2000 AND 3000
GROUP BY YEAR(fechaEntrada)