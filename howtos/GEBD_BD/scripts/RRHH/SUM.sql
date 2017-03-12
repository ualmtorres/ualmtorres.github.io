USE RRHH;
SELECT SUM(sueldo) AS sueldosDireccion
FROM Empleado
WHERE empleo LIKE 'Direc%';