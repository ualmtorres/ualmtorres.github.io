USE RRHH;
SELECT D.nombre, COUNT(E.numero) AS empleados
FROM Departamento D INNER JOIN 
	Empleado E ON D.numero = E.numeroDepartamento
GROUP BY D.nombre;