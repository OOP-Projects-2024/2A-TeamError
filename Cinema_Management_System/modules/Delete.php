<?php

class Delete {

    protected $pdo;

    public function __construct(\PDO $pdo){
        $this->pdo = $pdo;
    }
//DELETE MOVIES
    public function deleteMovies($id){
        $errmsg = "";
        $code = 0;

        try{
            $sqlString = "DELETE FROM movies_tbl WHERE id = ?";
            $sql = $this->pdo->prepare($sqlString);
            $sql->execute([$id]);

            $code = 200;
            $data = null;

            return array("data"=>$data, "code"=>$code);

        }
        catch(\PDOException $e){
            $errmsg = $e->getMessage();
            $code = 400;
        }

       
        return array("errmsg"=>$errmsg, "code"=>$code);
    }

//CANCEL PAYMENT
    public function deletePayment($id){
        $errmsg = "";
        $code = 0;

        try{
            $sqlString = "DELETE FROM payments_tbl WHERE payment_id = ?";
            $sql = $this->pdo->prepare($sqlString);
            $sql->execute([$id]);

            $code = 200;
            $data = null;

            return array("data"=>$data, "code"=>$code);

        }
        catch(\PDOException $e){
            $errmsg = $e->getMessage();
            $code = 400;
        }

       
        return array("errmsg"=>$errmsg, "code"=>$code);
    }


}
?>