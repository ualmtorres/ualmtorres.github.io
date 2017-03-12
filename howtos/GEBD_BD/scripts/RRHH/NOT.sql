USE RRHH;
SELECT nombre, empleo, sueldo 
FROM Empleado
WHERE NOT empleo = 'Vendedor';