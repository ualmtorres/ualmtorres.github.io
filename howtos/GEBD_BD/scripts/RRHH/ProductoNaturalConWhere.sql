USE RRHH;
SELECT *
FROM Empleado, 
	Departamento
WHERE Empleado.numeroDepartamento = Departamento.numero
