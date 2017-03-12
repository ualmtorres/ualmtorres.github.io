USE RRHH;
SELECT Departamento.nombre, COUNT(Empleado.numero) AS empleados
FROM Departamento LEFT JOIN 
	Empleado ON Departamento.numero = Empleado.numeroDepartamento
GROUP BY Departamento.nombre;