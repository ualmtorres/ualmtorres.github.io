USE RRHH;
SELECT DATE_FORMAT(MIN(fechaEntrada), '%d %b %Y') AS primeraEntrada
FROM Empleado;