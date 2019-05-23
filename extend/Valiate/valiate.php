<?php

use cart/cart;
use 
class valiate{
	
	function checkMobile($mobile,$table=null,$ba=null,$nss=null){
		if(!Validate::isMobile($mobile)){
			return false;	
		}
		
		$members=new Members();
		if($members->getErrors()){
			
		}
		db($table)->where("mobile",$mobile)->count();
		
		
	}	
	
	function add($good_id,$num,$option=array()){
		try{

		}catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
	}
	
	function formatData($data){
		$dta=input("request.");	
		$arr=array('uid'=>$data['id']);
		return $arr;
	}
	
	function update(){
		if(1--1){
			$this->check1();	
		}
		switch($){
			
		}
	}
	
	function orderSubmit(){
		
		$this->check();
		$this->check();
		$this->check();
		$data=array();
		$
		
		$this->sumPrice();
		
	}
	
	function sumFields($){
		
	}


}

?>