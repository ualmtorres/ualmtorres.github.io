USE RRHH;
SELECT *
FROM Empleado
WHERE NOT YEAR(fechaEntrada) = 2000;