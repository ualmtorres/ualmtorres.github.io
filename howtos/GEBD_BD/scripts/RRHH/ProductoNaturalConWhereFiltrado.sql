USE RRHH;
SELECT *
FROM Empleado, 
	Departamento
WHERE Empleado.numeroDepartamento = Departamento.numero AND
	Departamento.nombre = 'Ventas'
