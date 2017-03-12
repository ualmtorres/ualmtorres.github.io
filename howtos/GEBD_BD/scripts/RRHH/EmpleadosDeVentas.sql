USE RRHH;
SELECT empleo, COUNT(*) as empleadosDeVentas
FROM Empleado, 
	Departamento
WHERE Empleado.numeroDepartamento = Departamento.numero AND
	Departamento.nombre = 'Ventas'
GROUP BY empleo;
