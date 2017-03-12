USE RRHH;
SELECT nombre, empleo, DATE_FORMAT(fechaEntrada, '%d %b %Y') AS fechaEntrada
FROM Empleado;