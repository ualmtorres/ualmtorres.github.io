USE RRHH;
SELECT nombre, empleo, CURDATE(), fechaEntrada, CURDATE() - fechaEntrada
FROM Empleado;