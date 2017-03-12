USE RRHH;
SELECT Empleado.*, Departamento.nombre
FROM Empleado INNER JOIN 
	Departamento ON Empleado.numeroDepartamento = Departamento.numero
WHERE Departamento.nombre = 'Contabilidad';