USE RRHH;
SELECT empleo, COUNT(*) AS empleados
FROM Empleado
GROUP BY empleo;