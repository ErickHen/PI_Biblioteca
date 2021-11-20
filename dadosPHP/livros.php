<?php
   $cn = pg_connect("host=localhost port=5432 dbname=teste_db user=postgres password=emf110410");


   $action = $_POST["acao"];
   header('Access-Control-Allow-Origin: *');



   if("GET_ALL" == $action){
	   $db_data = array();
	   $result = pg_query("SELECT id, codigo, livro, autor, localizacao, disponibilidade FROM livros;");
	   
	   if(pg_num_rows($result) > 0){
		   while($row = pg_fetch_assoc($result)){
               $db_data[] = $row;
           }
           echo json_encode($db_data);

	   }
	    pg_close($cn);
		return;

   }

    if("ADD_PESSOA" == $action){

	   $codigo = $_POST["codigo"];
	   $livro = $_POST["livro"];
	   $autor = $_POST["autor"];
	   $localizacao = $_POST["localizacao"];
       $disponibilidade = $_POST["disponibilidade"];
	   $result = pg_query("INSERT INTO livros (codigo, livro, autor, localizacao, disponibilidade) VALUES ('$codigo', '$livro', '$autor', '$localizacao', '$disponibilidade')");
	   echo"sucesso";

	    pg_close($cn);
		return;

   }

   if("DELETE_PESSOA" == $action){
	   $pessoa_id = $_POST['pessoa_id'];
	   $result = pg_query("DELETE FROM livros WHERE id = $pessoa_id");
	   echo"sucesso";
	   pg_close($cn);
	   return;

   }


?>