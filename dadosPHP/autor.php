<?php
   $cn = pg_connect("host=localhost port=5432 dbname=teste_db user=postgres password=emf110410");


   $action = $_POST["acao"];
   header('Access-Control-Allow-Origin: *');



   if("GET_ALL" == $action){
	   $db_data = array();
	   $result = pg_query("SELECT id, nome, datas FROM autor;");
	   
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

	   $nome = $_POST["nome"];
	   $datas = $_POST["datas"];
	   $result = pg_query("INSERT INTO autor (nome, datas) VALUES ('$nome', '$datas')");
	   echo"sucesso";

	    pg_close($cn);
		return;

   }

   if("DELETE_PESSOA" == $action){
	   $pessoa_id = $_POST['pessoa_id'];
	   $result = pg_query("DELETE FROM autor WHERE id = $pessoa_id");
	   echo"sucesso";
	   pg_close($cn);
	   return;

   }


?>