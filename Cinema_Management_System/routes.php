<?php

//import get and post files
require_once "./config/database.php";
require_once "./modules/Get.php";
require_once "./modules/Post.php";
require_once "./modules/Patch.php";
require_once "./modules/Delete.php";
require_once "./modules/Auth.php";


$db = new Connection();
$pdo = $db->connect();

//instantiate post, get class
$post = new Post($pdo);
$get = new Get($pdo);
$patch = new Patch($pdo);
$delete = new Delete($pdo);
$auth = new Authentication($pdo);

//retrieved and endpoints and split
if(isset($_REQUEST['request'])){
    $request = explode("/", $_REQUEST['request']);
}
else{
    echo "URL does not exist.";
}

//get post put patch delete etc
//Request method - http request methods you will be using

switch($_SERVER['REQUEST_METHOD']){

    case "GET":
            if($auth->isAuthorized()){

            switch($request[0]){
    
                case "movies":
                    if (count ($request) > 1){
                        echo json_encode($get->getMovies($request[1]));
                    }
                    else{
                        echo json_encode($get->getMovies());
                    }
                break;


                case "prices":
                    if (count ($request) > 1){
                        echo json_encode($get->getPrices($request[1]));
                    }
                    else{
                        echo json_encode($get->getPrices());
                    }
                break;

                case "log":
                    echo json_encode($get->getLogs());
                
                break;

                case "payments":
                    if (count ($request) > 1){
                        echo json_encode($get->getPayment($request[1]));
                    }
                    else{
                        echo json_encode($get->getPayment());
                    }
                break;
                
                case "accounts":
                    if (count ($request) > 1){
                        echo json_encode($get->getAccounts($request[1]));
                    }
                    else{
                        echo json_encode($get->getAccounts());
                    }
                break;


                default:
                    http_response_code(401);
                    echo "This is invalid endpoint";
                break;
           
            }
        }
        else{
            echo "Unauthorized";
        }
        break;
    }

switch($_SERVER['REQUEST_METHOD']){

    case "POST":
        $body = json_decode (file_get_contents("php://input"));
        switch($request[0]){
            case "register":
                echo json_encode($auth->addAccount($body));
            break;
            
            case "login":
                echo json_encode($auth->login($body));
            break;

            case "movies":
                echo json_encode ($post->postMovies($body));
            break;

            case "prices":
                echo json_encode ($post->postPrices($body));
            break;
//PAYMENT
            case "payment":
                echo json_encode ($post->postPayment($body,$request[1]));
            break;

            default:
                    http_response_code(401);
                    echo "This is invalid endpoint";
            break;

            }
        break;
    
    case "PATCH":
        $body = json_decode (file_get_contents("php://input"));
        switch($request[0]){
            case "movies":
                echo json_encode($patch->patchMovies($body, $request[1]));
                break;
        }
        break;

    case "DELETE":
        switch($request[0]){
            case "movies":
                echo json_encode($patch->archiveMovies($request[1]));
             break;
        
            case "destroymovies":
            echo json_encode($delete->deleteMovies($request[1]));
            break;

            case "cancelpayment":
                echo json_encode($delete->deletePayment($request[1]));
                break;
        }
        break;
     }
?>