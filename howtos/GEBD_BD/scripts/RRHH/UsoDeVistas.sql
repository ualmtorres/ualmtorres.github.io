USE RRHH;
SELECT departamento, MAX(sueldo) as maximo 
FROM EmpleadoDepartamento
GROUP BY departamento;