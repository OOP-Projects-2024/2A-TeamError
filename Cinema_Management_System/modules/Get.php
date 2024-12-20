<?php

include_once "Common.php";

class Get extends Common{

    protected $pdo;

    public function __construct(\PDO $pdo){
        $this->pdo = $pdo;
    }

    //GET LOGS
    public function getLogs (){
        $filename =  "./logs/" . date("Y-m-d") . ".log";
        // $file = file_get_contents("./logs/$filename");
        // $logs = explode(PHP_EOL, $file);
        $logs = array();
        try{
            $file = new SplFileObject($filename);
            while(!$file->eof()){
                array_push($logs, $file->fgets());
            }
            $remarks = "success";
            $message = "Successfully retrieved logs.";
        }
        catch(Exception $e){
            $remarks = "failed";
            $message = $e->getMessage();
        }
        return $this->generateResponse(array("logs"=>$logs), $remarks, $message, 200);
    }

    
    // GET MOVIES (RETRIEVE RECORD FROM DATABASE)
    public function getMovies($id = null){
        $condition = "isdeleted = 0";
        if($id != null){
            $condition .= " And id =" . $id;
        }
        
        $result = $this->getDataByTable("movies_tbl", $condition, $this->pdo);
        if($result['code']==200){
            return $this->generateResponse($result['data'],"success" ,"Successfully retrieved movies.", $result['code']);
        }
        return $this->generateResponse(null, "failed", $result['errmsg'], $result['code']);
    }

    //GET ACCOUNTS
    public function getAccounts($id = null){
        $condition = null;
        if($id != null){
            $condition = "id = " . $id;
        }
        
        $result = $this->getDataByTable("accounts_tbl", $condition, $this->pdo);
        if($result['code']==200){
            return $this->generateResponse($result['data'],"success" ,"Successfully retrieved accounts.", $result['code']);
        }
        return $this->generateResponse(null, "failed", $result['errmsg'], $result['code']);
    }


    //GET prices
    public function getPrices($id = null){
        $condition = "isdeleted = 0";
        if($id != null){
            $condition .= " AND id = $id";
        }
        $result = $this->getDataByTable("prices_tbl", $condition, $this->pdo);
        if($result['code']==200){
            return $this->generateResponse($result['data'], "Successfully retrieve prices.", "success", $result['code']);
        }
        return $this->generateResponse(null, $result['errmsg'], "failed", $result['code']);
    }
 
    //GET RECEIPT
    public function getPayment($id = null){
        $condition = null;
        if($id != null){
            $condition = "payment_id = $id";
        }
        $result = $this->getDataByTable("payments_tbl", $condition, $this->pdo);
        if($result['code']==200){
            return $this->generateResponse($result['data'], "Successfully retrieve your receipt.", "success", $result['code']);
        }
        return $this->generateResponse(null, $result['errmsg'], "failed", $result['code']);
    }
    


}
?>