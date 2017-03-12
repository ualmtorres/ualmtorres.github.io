USE RRHH;
SELECT AVG(sueldo) AS sueldoMedioVendedor
FROM Empleado
WHERE empleo = 'Vendedor';