<?php

namespace app\admin\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\facade\Session;
use think\Db;
use Auths\Auth;
use Pages\Page;
use Dir\Dir;
use app\common\controller\AppCommon;
use app\admin\model\Config as configModel;
use app\admin\model\OperationLog;
use app\admin\model\MessageTpl;
use Smtp\SendMail;

class Smtp extends Common {

    public function __construct() {
        parent::__construct();
    }

    public function setting() {
        if ($_POST) {
            $this->doSave();
        }
        $configModel = new configModel();
        $webConfig = $configModel->getCfgByModule('SMTP_CONFIG');
        $config = json_decode($webConfig['SMTP_CONFIG'], true);
        if (!defined('PKCS7_TEXT')) {
            $this->assign("openssl", false);
        } else {
            $this->assign("openssl", true);
        }

        $this->assign("config", $config);
        return view();
    }

    /**
     * 邮件模板列表
     * @author 四川挚梦科技有限公司 
     * @date 2018-04-05
     */
    public function templates() {
        $keyword = input('request.keyword');
        $this->assign('keyword', $keyword);
        $pagesize = input('request.pagesize', 6, 'intval');
        $count = Db('message_tpl')->where("type", 'email')->count();
        $obj_page = $this->_Page($count, $pagesize);
        $obj_page->setConfig("header", "条");
        $obj_page->setConfig('theme', '&nbsp;%first%&nbsp;%upPage%&nbsp;%prePage%&nbsp;%linkPage%&nbsp;%nextPage%&nbsp;%downPage%&nbsp;%end%');
        $page = $obj_page->newshow();
        $this->assign('count', $count);
        $RoleNode = Db("message_tpl")->limit($obj_page->firstRow, $obj_page->listRows)->order('id','desc')->where("type", "email")->select();
        $this->assign("filter", $pagesize);
        $this->assign("list", $RoleNode);
        $this->assign("page", $page);
        return view();
    }

    /**
     * 添加邮件模板
     * @author 四川挚梦科技有限公司 
     * @date 2018-04-05
     */
    public function templatesAdd() {
        if ($_POST) {
            $MessageTpl = new MessageTpl();
            $data = input("request.");
            $id = input("request.id", 0, "intval");
            $result = $MessageTpl->templatesSave($id, $data);
            if ($result) {
                JsonDie(1, "操作成功", '');
            }
            JsonDie(0, "操作失败", '');
        }
        return view("templates_edit");
    }

    /**
     * 编缉邮件模板
     * @author 四川挚梦科技有限公司 
     * @date 2018-04-05
     */
    public function templatesEdit() {

        if ($_POST) {
            $MessageTpl = new MessageTpl();
            $data = input("request.");
            $id = input("request.id", 0, "intval");
            $result = $MessageTpl->templatesSave($id, $data);
            if ($result) {
                JsonDie(1, "操作成功", '');
            }
            JsonDie(0, "操作失败", '');
        }

        $id = input('request.id', 0, 'intval');
        if (!$id) {
            JsonDie(0, "参数错误", '');
        }
        $vo = Db('message_tpl')->getById($id);
        $this->assign("data", $vo);
        return view("templates_edit");
    }

    /**
     * 更改邮件模板状态
     * @author 四川挚梦科技有限公司 
     * @date 2018-04-05
     */
    public function doMsgTplStatus() {
        try {
            $id = input("request.id", 0, "intval");
            $value = input("request.value", 0, "intval");
            if (!$id) {
                JsonDie('0', "参数错误", 'yes');
            }
            if ($value == 0) {
                $data = array('status' => 1);
            } else {
                $data = array('status' => 0);
            }
            $ary_result = Db("messageTpl")->data($data)->where("id", $id)->update();
            if ($ary_result) {
                JsonDie('1', "操作成功", 'yes');
            } else {
                JsonDie('0', "操作失败", 'no');
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 删除邮件模板
     * @author四川挚梦科技有限公司
     * @date 2018-04-05
     */
    public function delMsgTpl() {
        $id = input("request.id", 0, 'intval');
        if (isset($id)) {
            $system = model("messageTpl");
            $ary_result = $system->where(array('id' => $id))->delete();
            if (FALSE !== $ary_result) {
                JsonDie(1, '操作成功', 'yes');
            } else {
                JsonDie(0, '操作失败', 'no');
            }
        } else {
            JsonDie(0, '非法参数', 'no');
        }
    }

    /**
     * 保存邮件SMTP配置 
     * @author 四川挚梦科技有限公司 
     * @date 2018-04-05
     */
    public function doSave() {
        try {
            if ($_POST) {
                $data = input("request.");
                $data['mail_address'] = $data['smtp_user'];
                $value = json_encode($data);
                $result = model("Config")->setConfig('SMTP_CONFIG', $value, 'SMTP邮件配置');
                if ($result) {
                    JsonDie("1", "保存成功", "yes");
                } else {
                    JsonDie("0", "保存失败", "no");
                }
            }
        } catch (\Exception $e) {
            JsonDie(0, '操作失败' . $e, 'no');
        }
    }

    /**
     * 测试邮件发送
     * @author 四川挚梦科技有限公司
     * @date 2018-04-05
     */
    public function testSendMail() {
        $ary_get = input("request.");
        $configModel = new configModel();
        $webConfig = $configModel->getCfgByModule('SMTP_CONFIG');
        $config = json_decode($webConfig['SMTP_CONFIG'], true);
        $smtp = new SendMail();
        if ($error = $smtp->getError()) {
            $str = json_encode($ary_get);
            JsonDie(0, $error, 'no');
        } else {
            if (!empty($ary_get['test_address'])) {
                $title = '邮件测试--成都艾威尔网络科技有限公司';
                $content = '<h1>这是一封测试邮件</h1><br>您看到这封邮件说明配置正确!';
                if ($smtp->send($config['test_address'], $title, $content)) {
                    JsonDie(1, '发送成功!', 'no');
                } else {
                    JsonDie(0, '请确认用户名和密码正确', 'no');
                }
            } else {
                JsonDie(0, '测试邮件地址不能为空', 'no');
            }
        }
    }

}
