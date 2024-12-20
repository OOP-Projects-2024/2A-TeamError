<?php

include_once "Common.php";
class Post extends Common{

    protected $pdo;

    public function __construct(\PDO $pdo){
        $this->pdo = $pdo;
    }


    public function postMovies($body){

        $price = $body->price;
        unset($body->price);
        $result = $this->postData("movies_tbl", $body, $this->pdo);
        
        if($result['code'] == 200){
            unset($body->genre);
            unset($body->classification);
            unset($body->description);
            $body->price = $price;
            $this->postPrices($body);
            $this->logger("testrich", "POST", "Created a new Record");
            return $this->generateResponse($result['data'],"success" ,"Successfully created a record.", $result['code']);
        }
            $this->logger("testrich", "POST", $result['errmsg']);
            return $this->generateResponse(null,"failed" , $result['errmsg'], $result['code']);
    }

    public function postPrices($body){
       $result = $this->postData("prices_tbl", $body, $this->pdo);
       if($result['code'] == 200){
        $this->logger("testrich", "POST", "Created a new Price");
        return $this->generateResponse($result['data'],"success" ,"Successfully created a record.", $result['code']);
    }
        return $this->generateResponse(null,"failed" , $result['errmsg'], $result['code']);
    }

    //POSTPAYMENT
    public function postPayment($body,$id) {
        if (isset($body->amount_due) && isset($body->amount_paid)){
            $amount_due = $body->amount_due;
            $amount_paid = $body->amount_paid;
            $available_seats = $this->getAvailableSeats($id, $this->pdo);

            if ($amount_paid == $amount_due && $available_seats > 0){

                $seat_number = $body->seat_number;

                $condition = "seat_number = $seat_number";
                $isavailable = $this->getDataByTable("seats_tbl", $condition, $this->pdo);
                
                if ($isavailable['data'][0]['isbooked'] === 1){
                    return $this->generateResponse(null, "seat not available", "failed", 400);
                }

                

                $result = $this->postData("payments_tbl", $body, $this->pdo);

                
                if ($result['code'] == 200) {
                    $available_seats -= 1;
                    $sqlString = "UPDATE prices_tbl SET available_seats=$available_seats WHERE id = ?";
                    $sql = $this->pdo->prepare($sqlString);
                    $sql->execute([$id]);

                    $sqlString1 = "UPDATE seats_tbl SET isbooked=1 WHERE seat_number = $seat_number";
                    $sql1 = $this->pdo->prepare($sqlString1);
                    $sql1->execute();

                    $this->logger("testrich", "payments_tbl", "POST", "Created a new payment record");
                    return $this->generateResponse($result['data'], "success", "Successfully created a payment record.", $result['code']);
                } else {
                    return $this->generateResponse(null, "failed to pay", $result['errmsg'], $result['code']);
                }
    
            }
        }

        $errmsg = "";
        $code = 400;
        return $this->generateResponse(null, "failed to pay", $errmsg, $code = 400);

        
        
    }   
}
?>