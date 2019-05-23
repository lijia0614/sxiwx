<?php

namespace app\admin\controller;
use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use app\common\controller\AppCommon;
use app\admin\model\RoleNav;
use app\admin\model\OperationLog;
use Auths\Auth;
use Pages\Page;
use Tree\Tree;

class Other extends Common
{

    public function __construct()
    {
        parent::__construct();
        $modules = $this->getModule(CONTROLLER); //获取模型配置 
        $this->assign("modules", $modules);
        $this->modelFields($modules['table']);
    }
    const GETBOOKIDS_URL = 'http://store.zhewenit.com/api/qm/bookids?cpid=6'; // 获取所有授权作品 ID


    public function index(){
        $url = $this::GETBOOKIDS_URL;
        $res = httpPost($url);
        if ($res['code'] == 0){
            $bookIds = object_array($res['data']);
            Db::startTrans();
            try{
                foreach ($bookIds['books'] as $k=>$v){
                    $check = Db::name('bookids')->where('bookid',$v['bookId'])->find();
                    if (!$check){
                        // 没有该bookid,存入数据库
                        $dataId = [
                            'bookid' => $v['bookId'],
                            'create_time' => date('Y-m-d H:i:s')
                        ];
                        Db::name('bookids')->insert($dataId);
                        $getInfoUrl = 'http://store.zhewenit.com/api/qm/info?bookId='.$v['bookId'];
                        $bookInfo = httpPost($getInfoUrl);
                        $data = object_array($bookInfo['data']);

                        foreach ($data as $key=>$val){
                            // 将书籍信息存入book表中
                            $ary = [
                                'type' => 3,
                                'u_id' => 2, //超级用户
                                'words_num' => $val['words'],
                                'other_bookid' => $val['bookId'],
                                'image' => $val['cover'],
                                'name' => $val['name'],
                                'info' => $val['intro'],
                                'author' => $val['authorName'],
                                'is_end' => $val['isEnd']
                            ];
                            if ($val['typeid'] == '1017'){
                                $ary['cid'] = 5;
                            }elseif ($val['typeid'] == '1018'){
                                $ary['cid'] = 18;
                            }elseif ($val['typeid'] == '1019'){
                                $ary['cid'] = 13;
                            }elseif ($val['typeid'] == '1020'){
                                $ary['cid'] = 11;
                            }elseif ($val['typeid'] == '1021'){
                                $ary['cid'] = 12;
                            }elseif ($val['typeid'] == '1022'){
                                $ary['cid'] = 6;
                            }elseif ($val['typeid'] == '1023'){
                                $ary['cid'] = 19;
                            }elseif ($val['typeid'] == '1024'){
                                $ary['cid'] = 20;
                            }elseif ($val['typeid'] == '1025'){
                                $ary['cid'] = 7;
                            }
                            Db::name('book')->insert($ary);
                        }
                    }
                }
                // 提交事务
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
            }
        }
    }

    public function other(){
        $list = Db::name('book')
            ->where('is_del',0)
            ->where('type',3)
            ->select();
        c_print($list);
    }

}
