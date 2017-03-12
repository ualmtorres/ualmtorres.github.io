USE RRHH;
SELECT nombre, empleo, sueldo 
FROM Empleado
WHERE empleo = 'Vendedor' AND complemento >= 500;