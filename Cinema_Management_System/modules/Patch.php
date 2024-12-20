<?php

class Patch {

    protected $pdo;

    public function __construct(\PDO $pdo){
        $this->pdo = $pdo;
    }


    public function patchMovies($body, $id){
        $values = [];
        $errmsg = "";
        $code = 0;

        foreach($body as $value){
            array_push($values, $value);
        }

        array_push($values, $id);

        try{
            $sqlString = "UPDATE movies_tbl SET name=?, genre=?, classification=?, description=? WHERE id = ?";
            $sql = $this->pdo->prepare($sqlString);
            $sql->execute($values);

            $code = 200;
            $data = null;

            return array("payload"=>$data, "remarks"=>"success", "message"=>"Successfully updated a movie.", "code"=>$code);

        }
        catch(\PDOException $e){
            $errmsg = $e->getMessage();
            $code = 400;
        }

       
        return array("payload"=>null, "remarks"=>"failed", "message"=>$errmsg, "code"=>$code);
    }

    public function archiveMovies($id){
        $errmsg = "";
        $code = 0;

        try{
            $sqlString = "UPDATE movies_tbl SET isdeleted=1 WHERE id = ?";
            $sql = $this->pdo->prepare($sqlString);
            $sql->execute([$id]);

            $code = 200;
            $data = null;

            return array("payload"=>$data, "remarks"=>"success", "message"=>"Successfully deleted a Movie.", "code"=>$code);

        }
        catch(\PDOException $e){
            $errmsg = $e->getMessage();
            $code = 400;
        }
        
        return array("payload"=>null, "remarks"=>"failed", "message"=>$errmsg, "code"=>$code);
    }


}
?>