USE RRHH;
SELECT ciudad, COUNT(*) as empleados, AVG(sueldo) as sueldoMedio
FROM Empleado, 
	Departamento
WHERE Empleado.numeroDepartamento = Departamento.numero AND
	Departamento.ciudad IN ('Dallas', 'Chicago')
GROUP BY ciudad;
