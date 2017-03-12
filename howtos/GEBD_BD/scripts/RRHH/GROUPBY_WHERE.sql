USE RRHH;
SELECT empleo, COUNT(*) AS empleados
FROM Empleado
WHERE YEAR(fechaEntrada) = 2001
GROUP BY empleo;