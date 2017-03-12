USE RRHH;
SELECT nombre, complemento +  sueldo
FROM Empleado
WHERE empleo = 'Vendedor';