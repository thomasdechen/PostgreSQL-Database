-- 1. Liste todas as localizações do departamento cujo número é 100, em ordem alfabética.
SELECT e_localizacao 
FROM edificios 
WHERE e_depto_num = 100 
ORDER BY e_localizacao ASC;


-- 2. Liste todos os números de projetos em que trabalha o(a) colaborador(a) com CPF 112.356.757-34.
SELECT t_proj_num 
FROM trabalha_em 
WHERE t_cpf = '112.356.757-34';


-- 3. Liste CPFs de colaboradores(as), números de projetos e horas trabalhadas. Classifique os resultados por ordem decrescente de horas trabalhadas. 
SELECT t_cpf AS cpf, COUNT(t_proj_num) AS num_projetos, SUM(t_horas) AS horas_trabalhadas
FROM trabalha_em
GROUP BY t_cpf
ORDER BY horas_trabalhadas DESC;


-- 4. Liste o nome, o endereço e o salário das colaboradoras que trabalham num dos seguintes departamentos: 66 ou 5.
SELECT c_nome, c_logradouro, c_salario 
FROM colaborador 
WHERE c_depto_num IN (5, 66) AND c_sexo = 'F';


-- 5. Liste nome e parentesco de dependentes de colaboradores(as) que recebem salário maior que 2.500.
SELECT de.de_nome, de.de_parentesco
FROM colaborador AS c
INNER JOIN dependente AS de ON c.c_cpf = de.de_cpf
WHERE c.c_salario > 2500;


-- 6. Liste nomes das gerentes cujo salário é maior que 1.000 e menor que 3.000.
SELECT c_nome
FROM colaborador
WHERE c_salario > 1000 AND c_salario < 3000
AND c_sexo = 'F' AND c_supervisor_cpf IS NULL;


-- 7. Nome e endereço das colaboradoras e o nome dos projetos nos quais trabalham, desde que elas dediquem mais que 3h aos projetos.
SELECT c.c_nome, c.c_logradouro, p.p_nome
FROM colaborador AS c
INNER JOIN trabalha_em AS t ON c.c_cpf = t.t_cpf
INNER JOIN projeto AS p ON t.t_proj_num = p.p_numero
WHERE t.t_horas > 3 AND c_sexo = 'F';

SELECT c.c_nome, c.c_logradouro, p.p_nome
FROM colaborador c, projeto p, trabalha_em t
WHERE p.p_numero = t.t_proj_num AND t.t_horas > 3 AND c.c_sexo = 'F'
ORDER BY c_nome, p_nome;


-- 8. Liste nome e endereço das supervisoras.
SELECT c_nome, c_logradouro
FROM colaborador
WHERE c_supervisor_cpf IS NULL AND c_sexo = 'F';

-- 9. Liste nomes de dependentes cujos pais trabalham no projeto 'Carro que voa'
SELECT de_nome
FROM dependente
INNER JOIN colaborador ON colaborador.c_cpf = dependente.de_cpf
INNER JOIN trabalha_em ON colaborador.c_cpf = trabalha_em.t_cpf
WHERE t_proj_num = 1;


-- 10. Liste os departamentos que não controlam nenhum projeto. Exiba: o número e o nome do departamento (e o número e o nome do projeto).
SELECT d_numero, d_nome, p_numero, p_nome
FROM departamento
LEFT JOIN projeto ON departamento.d_numero = projeto.p_depto_controle
WHERE projeto.p_numero IS NULL;


-- 11. Reescreva o exemplo de consulta seguinte, mas inverta o lado da junção. 
-- SELECT p.numero AS p_numero, p.nome AS p_nome, d.numero AS d_numero, d.nome as d_nome
-- FROM departamento d LEFT JOIN projeto p ON p.depto_num=d.numero;

SELECT p.p_numero, p.p_nome, d.d_numero, d.d_nome
FROM projeto AS p
RIGHT JOIN departamento AS d ON p.p_depto_controle = d.d_numero;

-- 12. Liste os dependentes de cada colaborador(a), mostrando inclusive quem não tem dependente. Exiba o nome e o parentesco do dependente, bem como o CPF e o nome do(a) colaborador(a).
SELECT c_nome AS colaborador, c_cpf AS cpf_colaborador, de_nome AS dependente, de_parentesco AS parentesco
FROM colaborador
LEFT JOIN dependente ON colaborador.c_cpf = dependente.de_cpf;

-- 13.Liste apenas colaboradores(as) que não possuem dependentes.
SELECT c_nome AS colaborador, de_nome AS dependente
FROM colaborador
LEFT JOIN dependente ON colaborador.c_cpf = dependente.de_cpf
WHERE dependente.de_cpf IS NULL;


-- 14. Calcule o total pago em salários pela empresa.
SELECT SUM(c_salario) AS total_salarios
FROM colaborador;


-- 15. Calcule a soma e a média dos salários pagos pelo departamento número 40.
SELECT SUM(c_salario) AS soma_salarios, ROUND(AVG(c_salario), 2) AS media_salarios
FROM colaborador
WHERE c_depto_num = 40;

-- Você é capaz de usar a função ROUND na consulta anterior para aproximar o cálculo da média para 2 dígitos decimais?  
-- Consulte: https://www.w3resource.com/PostgreSQL/round-function.php


-- 16. Exiba o nome e o salário do(a) colaborador(a) pertencente ao departamento número 40 e que recebe o maior salário.
SELECT c_nome AS nome, c_salario AS maior_salario
FROM colaborador
WHERE c_depto_num = 40
ORDER BY c_salario DESC
LIMIT 1;


-- 17. Exiba o nome e o salário do(a) colaborador(a) pertencente ao departamento número 40 e que recebe o menor salário.
SELECT c_nome AS nome, c_salario AS menor_salario
FROM colaborador
WHERE c_depto_num = 40
ORDER BY c_salario ASC
LIMIT 1;


-- 18. Exiba quantos colaboradores(as) trabalham no projeto de número 1.
SELECT COUNT(*) AS num_colaboradores
FROM trabalha_em
WHERE t_proj_num = 1;


-- 19. Mostre o nome do departamento e a sua quantidade de colaboradores(as).
SELECT d.d_nome AS nome_departamento, COUNT(*) AS num_colaboradoreas
FROM departamento AS d
INNER JOIN colaborador AS c ON d.d_numero = c.c_depto_num
GROUP BY d.d_nome;


-- 20. Mostre o nome de cada colaborador(a) e seu total de horas trabalhadas, desde que o total seja maior ou igual a 20 e menor ou igual a 40.
SELECT c.c_nome AS nome_colaboradorea, SUM(t.t_horas) AS horas_trabalhadas
FROM colaborador AS c
INNER JOIN trabalha_em AS t ON c.c_cpf = t.t_cpf
GROUP BY c.c_nome
HAVING SUM(t.t_horas) BETWEEN 20 AND 40;