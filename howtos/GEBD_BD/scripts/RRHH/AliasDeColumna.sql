USE RRHH;
SELECT nombre, sueldo, complemento, sueldo + COALESCE(complemento, 0) AS sueldoTotal
FROM Empleado;