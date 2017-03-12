USE RRHH;
SELECT ciudad, AVG(sueldo) as sueldoMedio
FROM Empleado, 
	Departamento
WHERE Empleado.numeroDepartamento = Departamento.numero
GROUP BY ciudad
HAVING AVG(sueldo) > 2000;
