USE RRHH;
SELECT nombre, sueldo
FROM Empleado
WHERE sueldo > ANY (
	SELECT sueldo
	FROM Empleado E INNER JOIN
		Departamento D ON E.numeroDepartamento = D.numero
	WHERE empleo = 'Vendedor' AND
		ciudad = 'Chicago')
ORDER BY sueldo DESC;