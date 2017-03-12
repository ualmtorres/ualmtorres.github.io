USE RRHH;
CREATE OR REPLACE VIEW EmpleadoDepartamento AS
SELECT E.*, D.nombre AS departamento, D.ciudad
FROM Departamento D LEFT JOIN 
	Empleado E ON D.numero = E.numeroDepartamento;