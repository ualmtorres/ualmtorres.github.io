USE RRHH;
SELECT nombre, sueldo
FROM Empleado
WHERE sueldo > (
	SELECT sueldo
	FROM Empleado
	WHERE nombre = 'Allen')
ORDER BY sueldo DESC;