/*Para cada departamento, realize uma consulta em PostgresSQL que mostre o nome do departamento, a quantidade de empregados, 
a média salarial, o maior e o menor salários. Ordene o resultado pela maior média salarial.

Dicas: você pode usar a função COALESCE(value , 0) para substituir um valor nulo por zero e pode usar a função ROUND(value, 2) 
para mostrar valores com duas casas decimais.

tabelas utilizadas para construção do script:

deparatamento
empregado
emp_venc
vencimento
*/


select 
	departamento.nome as departamento, 				/*Seleciona o nome do departamento da tabela departamento e o renomeia para "departamento".*/
	count(distinct empregado.matr) as qtd_empregados, /*Conta o número de matrículas únicas (distintas) da tabela empregado para cada departamento.*/
	round(avg(coalesce(vencimento.valor, 0)),2) as med_salarial,  /*Calcula a média dos valores da coluna "valor" da tabela vencimento para cada departamento e arredonda para duas casas decimais.*/
	max(vencimento.valor) as maior_salario,    	 /*Encontra o maior valor da coluna "valor" da tabela vencimento para cada departamento.*/
	min(vencimento.valor) as menor_salario         /*Encontra o menor valor da coluna "valor" da tabela vencimento para cada departamento.*/
	         

from empregado 														  /*Especificando as tabelas envolvidas e a relação entre elas*/
inner join departamento on departamento.cod_dep = empregado.lotacao /*Realiza uma junção entre as tabelas "empregado" e "departamento" com base na correspondência entre as colunas "cod_dep (departamento)"  e "lotacao (empregado)"*/
left join emp_venc on emp_venc.matr = empregado.matr 				/*Realiza uma junção entre as tabelas "empregado e emp_venc com" base na correspondência das matrículas. Isso permite incluir todos os funcionários, mesmo que não tenham registros correspondentes em emp_venc.*/
left join vencimento on vencimento.cod_venc = emp_venc.cod_venc   /*Realiza outra junção entre as tabelas "emp_venc e vencimento" com base nos códigos de vencimento. Isso garante que todos os registros de emp_venc sejam incluídos, mesmo que não haja registros correspondentes em vencimento.*/
group by departamento.nome                                       /*Agrupa os resultados pelo nome do departamento, permitindo que as funções agregadas (COUNT, AVG, MIN, MAX) sejam aplicadas a cada departamento individualmente.*/
order by med_salarial desc;                                     /*Ordena o resultado pela maior média salarial*/


