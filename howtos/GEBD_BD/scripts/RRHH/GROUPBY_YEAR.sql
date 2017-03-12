USE RRHH;
SELECT YEAR(fechaEntrada), COUNT(*) AS empleados
FROM Empleado
GROUP BY YEAR(fechaEntrada);