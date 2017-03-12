USE RRHH;
SELECT nombre, empleo, DATEDIFF(CURDATE(), fechaEntrada) as antiguedad
FROM Empleado;