USE RRHH;
SELECT nombre, empleo, sueldo, E.numeroDepartamento
FROM Empleado E INNER JOIN 
	(SELECT numeroDepartamento, MAX(sueldo) as maximo 
		FROM EmpleadoDepartamento
		GROUP BY numeroDepartamento) M ON E.numeroDepartamento = M.numeroDepartamento
WHERE sueldo = maximo