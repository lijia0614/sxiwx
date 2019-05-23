<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use think\Validate;
use Auths\Auth;
use Pages\Page;
use Dir\Dir;
use Oss\aliyun;
use Oss\qiniu;

class Uploads extends Common {

    private $ossStatus = false;
    private $ossType = 'local';
    private $ossConfig = array();
	private $imgSet=false;  //裁剪状态
	private $imgWidth=100;  //裁剪宽度
	private $imgHeight=100; //裁剪高度
	private $water=false;	//水印状态
	private $waterSrc='';		//水印路径
	private $waterPosition='';//水印位置	
	private $water_op=50; //水印透明度

    public function initialize() {
        parent::initialize();
		$this->ossStatus();//检测oss状态，如果oss开启则读取配置
		$this->imgSet();//读取图片剪裁及水印设置

    }

    /**
     * 检测云存储状态
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	public function ossStatus(){
        $oss = Db("oss")->where("status", 1)->find();
        if ($oss['alias'] != 'local') {
            $this->ossStatus = true;
            $this->ossType = $oss['alias'];
            $this->ossConfig = json_decode($oss['value'], true);
        }
	}
	
	
	/**
     * 单图上传
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
    public function uploadfile() {
        $id = input("request.id", 0, "trim");
        if (!$id) {
            JsonDie(0, '非法提交', 'no');
        }
        $save_path = '/uploads/img/'; //上传路径
        try {
            $files = request()->file($id);
            $data=array();
            foreach($files as $file){
                $info = $file->validate(array('size' => 2048000, 'ext' => 'jpg,png,gif'))->move(WEB_PATH . $save_path); // 根目录/uploads下
                if ($info) {
                    $filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径
					$this->cropImage($filePath);//裁剪图片
					$this->waterImage($filePath);//加水印											
                    $fileurl = $this->yunQss(WEB_PATH . $filePath, substr($filePath, 1));
                    if ($fileurl) {
                        $filePath = $fileurl;
                    }
                    $data=array('error'=>0,'ext'=>$info->getExtension(),'url'=>$filePath,'filename'=>$info->getFilename());
                } else {
                    $data=array('error'=>1,'msg'=>$file->getError(),'file_name'=>'error');
                }
            }
            die(json_encode($data));
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 多图上传
     * @date 2017-04-13
     */
    public function multupload() {
        $id = input("request.id", 0, "trim");
        if (!$id) {
            JsonDie(0, '非法提交', 'no');
        }
        $save_path = '/uploads/img/'; //上传路径
        try {
            $files = request()->file($id);
            $data=array();
            foreach($files as $file){
                $info = $file->validate(array('size' => 2048000, 'ext' => 'jpg,png,gif'))->move(WEB_PATH . $save_path); // 根目录/uploads下
                if ($info) {
                    $filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径
					$this->cropImage($filePath);//裁剪图片
					$this->waterImage($filePath);//加水印				
                    $fileurl = $this->yunQss(WEB_PATH . $filePath, substr($filePath, 1));
                    if ($fileurl) {
                        $filePath = $fileurl;
                    }
                    $data[]=array('error'=>0,'ext'=>$info->getExtension(),'url'=>$filePath,'filename'=>$info->getFilename());
                } else {
                    $data[]=array('error'=>1,'msg'=>$file->getError(),'file_name'=>'error');
                }
            }
            die(json_encode($data));
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }
	
    /**
     * 文件上传
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	public function fileupload(){
        $id = input("request.id", 0, "trim");
        if (!$id) {
            JsonDie(0, '非法提交', 'no');
        }
        $save_path = '/uploads/file/'; //上传路径
        try {
            $files = request()->file($id);
            $data=array();
            foreach($files as $file){
                $info = $file->validate(array('size' => 4096000, 'ext' => 'htm,html,txt,zip,rar,gz,bz2'))->move(WEB_PATH . $save_path); // 根目录/uploads下
                if ($info) {
                    $filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径										
                    $fileurl = $this->yunQss(WEB_PATH . $filePath, substr($filePath, 1));
                    if ($fileurl) {
                        $filePath = $fileurl;
                    }
                    $data=array('error'=>0,'ext'=>$info->getExtension(),'url'=>$filePath,'filename'=>$info->getFilename());
                } else {
                    $data=array('error'=>1,'msg'=>$file->getError(),'file_name'=>'error');
                }
            }
            die(json_encode($data));
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }		
	}	
	
	
	
	
    /**
     * 编缉器上传
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	public function editUpload(){
		try {
			$save_path = '/uploads/img/'; //上传路径
			$files = request()->file("imgFile");
			$info = $files->validate(array('size' => 1024000, 'ext' => 'jpg,png,gif'))->move(WEB_PATH . $save_path); // 根目录/uploads下
			if ($info) {
				$filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径			
				$fileurl = $this->yunQss(WEB_PATH . $filePath, substr($filePath, 1));
				if ($fileurl) {
							$filePath = $fileurl;
				}
				$data=array('error'=>0,'ext'=>$info->getExtension(),'url'=>$filePath,'file_name'=>$info->getFilename());
			} else {
				$data=array('error'=>1,'message'=>$files->getError());
			}
			die(json_encode($data));
		} catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
	}
	

	
    /**
     * office文档文件上传
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	public function officeUpload(){
        $id = input("request.id", 0, "trim");
        if (!$id) {
            JsonDie(0, '非法提交', 'no');
        }
        $save_path = '/uploads/office/'; //上传路径
        try {
            $files = request()->file($id);
            $data=array();
            foreach($files as $file){
                $info = $file->validate(array('size' => 4096000, 'ext' => 'doc,docx,xls,xlsx,ppt'))->move(WEB_PATH . $save_path); // 根目录/uploads下
                if ($info) {
                    $filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径										
                    $fileurl = $this->yunQss(WEB_PATH . $filePath, substr($filePath, 1));
                    if ($fileurl) {
                        $filePath = $fileurl;
                    }
                    $data=array('error'=>0,'ext'=>$info->getExtension(),'url'=>$filePath,'filename'=>$info->getFilename());
                } else {
                    $data=array('error'=>1,'msg'=>$file->getError(),'file_name'=>'error');
                }
            }
            die(json_encode($data));
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }		
	}		
	
	
    /**
     * 视频上传
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	public function mediaUpload(){
		try {
			$save_path = '/uploads/media/'; //上传路径
			$files = request()->file("imgFile");
			$info = $files->validate(array('size' => 409600, 'ext' => 'swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb'))->move(WEB_PATH . $save_path); // 根目录/uploads下
			if ($info) {
				$filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径
				$fileurl = $this->yunQss(WEB_PATH . $filePath, substr($filePath, 1));
				if ($fileurl) {
							$filePath = $fileurl;
				}
				$data=array('error'=>0,'ext'=>$info->getExtension(),'url'=>$filePath,'file_name'=>$info->getFilename());
			} else {
				$data=array('error'=>1,'message'=>$files->getError(),'file_name'=>'error');
			}
			die(json_encode($data));
		} catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
	}
	
    /**
     * kindeditor 编缉器上传函数
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	 public function kindupload() {
			try {
				$files = request()->file("imgFile");
				$type=input("get.type",0);
				if(!$type){
					$data=array('error'=>1,'message'=>"文件类型错误",'file_name'=>'error');
					die(json_encode($data));
				}
				$save_path = '/uploads/editor/'.$type."/"; //上传路径
				$ext=$this->fileExt($type);
				$info = $files->validate(array('size' => 4096000, 'ext' => $ext))->move(WEB_PATH . $save_path); // 根目录/uploads下
				if ($info) {
					$filePath = $save_path . str_replace("\\", "/", $info->getSaveName()); //服务器上相对路径
					$fileurl = $this->yunQss(WEB_PATH . $filePath, substr($filePath, 1));
					if ($fileurl) {
						$filePath = $fileurl;
					}
					$data=array('error'=>0,'ext'=>$info->getExtension(),'url'=>$filePath,'file_name'=>$info->getFilename());
				} else {
					$data=array('error'=>1,'message'=>$files->getError(),'file_name'=>'error');
				}
				die(json_encode($data));
			} catch (\Exception $e) {
				JsonDie(0, '操作失败' . $e, 'no');
			}
	 }
	 
    /**
     * 返回要检测的文件类型
     * $localPath 本地存储的绝对路径
     * $yunpath 上传到云存储的相对路径
     * @date 2017-04-13
     */
	public function fileExt($type){
	
		//定义允许上传的文件扩展名
		$ext_arr = array(
					'image' => array('gif', 'jpg', 'jpeg', 'png', 'bmp'),
					'images' => array('gif', 'jpg', 'jpeg', 'png', 'bmp'),
					'flash' => array('swf', 'flv'),
					'media' => array('swf', 'flv', 'mp3', 'wav', 'wma', 'wmv', 'mid', 'avi', 'mpg', 'asf', 'rm', 'rmvb'),
					'file' => array('doc', 'docx', 'xls', 'xlsx', 'ppt', 'htm', 'html', 'txt', 'zip', 'rar', 'gz', 'bz2'),
		);	
		if(isset($ext_arr[$type])){
			return 	implode(",",$ext_arr[$type]);
		}
		return false;
		
	}
		

    

    /**
     * 检查图片是否开启了云存储，并保证相对路径和本地一致
     * $localPath 本地存储的绝对路径
     * $yunpath 上传到云存储的相对路径
     * @date 2017-04-13
     */
    private function yunQss($localPath, $yunpath) {
        try {
            if ($this->ossStatus) {
                if ($this->ossType == 'aliyun') {
                    $aliyun = new aliyun(); //初始化阿里云存储           
                    $fileurl = $aliyun->uploadFile($yunpath, $localPath);
                    $this->LocalFileRemove($localPath); //检测是否保留本地文件
                    return $fileurl;
                } else if ($this->ossType == 'qiniu') {
                    $qiniu = new qiniu(); //初始化七牛云存储
                    $fileurl = $qiniu->qnUpload($yunpath, $localPath);
                    $this->LocalFileRemove($localPath); //检测是否保留本地文件
                    return $fileurl;
                } else {
                    return false;
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 检查是否保留本地服务器文件
     * $config 云配置
     * $localPath 本地存储的绝对路径
     * @date 2017-04-13
     */
    private function LocalFileRemove($localPath) {
        try {
            if ($this->ossConfig['local_file_save'] == 0) {
                unlink($localPath);
            }
        } catch (\Exception $e) {
            JsonDie(0, '删除本地文件失败' . $e, 'no');
        }
    }
	
    /**
     * 裁剪图片
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	 
	public function cropImage($path){
		if(!$this->imgSet) return;
		
		$image = \think\Image::open(WEB_PATH.$path);
		$image->thumb($this->imgWidth,$this->imgHeight,\think\Image::THUMB_CENTER)->save(WEB_PATH.$path);
	}
	
    /**
     * 图片加水印
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	 
	public function waterImage($path){
		if(!$this->water) return;
		$image = \think\Image::open(WEB_PATH.$path);
		$image->water(WEB_PATH."/".$this->waterSrc,$this->waterPosition,$this->water_op)->save(WEB_PATH."/".$path);
	}		
	
    /**
     * 配置图片处理
     * @author 四川挚梦科技有限公司
     * @date 2018-04-21
     */
	public function imgSet(){
		$moduleName=input("request.moduleName",0,'trim');
		$fieldsName=input("request.fieldsName",0,'trim');
		if(!$moduleName||!$fieldsName) return;
		$ckey="IMG_".strtoupper($moduleName)."_".strtoupper($fieldsName);
        $config = Db("config")->where("c_key", $ckey)->find();
		$value=json_decode($config['c_value'],true);
        if ($config['status'] == 1) {
            $this->imgSet = true;
            $this->imgWidth = $value['width'];
            $this->imgHeight = $value['height'];
        }
		if($value['water_status']){
				$this->water = true;
				$this->waterSrc = $value['waterImage'];
				$this->waterPosition = $value['water_position'];
				$this->water_op=$value['water_op'];
		}		
	}	
	

}
