<?php

namespace app\install\controller;

use think\Controller;
use think\facade\Config;
use think\facade\Request;
use think\Db;
use Pages\Page;

class Index extends Controller {
	
    public function __construct() {
		parent::__construct();
		if (file_exists(WEB_PATH. "/config/install.lock")) {
			exit('<h1>System has been installed.</h1>');
		}
		$sys_path=config("admin.adminPath");
		if($sys_path){
			define("SYS_PATH",config("admin.adminPath"));
		}else{
			define("SYS_PATH","sys");
		}
    }	

    public function index() {
		
        define("VERSION", 'ZmCMS 2.0');
        $steps = array(
            '1' => '安装许可协议',
            '2' => '运行环境检测',
            '3' => '安装参数设置',
            '4' => '安装详细过程',
            '5' => '安装完成',
        );
        $step = isset($_GET['step']) ? $_GET['step'] : 1;
        $scriptName = !empty($_SERVER["REQUEST_URI"]) ? $scriptName = $_SERVER["REQUEST_URI"] : $scriptName = $_SERVER["PHP_SELF"];
        $rootpath = @preg_replace("/\/(I|i)nstall\/index\.php(.*)$/", "", $scriptName);
        $domain = empty($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : $_SERVER['SERVER_NAME'];
        if ((int) $_SERVER['SERVER_PORT'] != 80) {
            $domain .= ":" . $_SERVER['SERVER_PORT'];
        }
        $domain = $domain . $rootpath;
        switch ($step) {
            case '1':
                return view('index');
                exit();
            case '2':
                self::EnvCheck();
                return view("envcheck");
                exit();
            case '3':
                $this->pwdcheck(); //输入了数据库信息则检测
                return view("input");
                exit();
            case '4':
                $this->installSql();
                return view("install");
                exit();
            case '5':
                @touch(WEB_PATH . '/config/install.lock');
                return view("success");
                exit();
        }
        return view();
    }

    public function EnvCheck() {
        $Envarry = array();
        $Envarry['phpv'] = @ phpversion(); //php版本
        $os = PHP_OS; //运行环境
        $Envarry['os'] = php_uname();
        $Envarry['tmp'] = function_exists('gd_info') ? gd_info() : array();
        $Envarry['server'] = $_SERVER["SERVER_SOFTWARE"];
        $Envarry['host'] = (empty($_SERVER["SERVER_ADDR"]) ? $_SERVER["SERVER_HOST"] : $_SERVER["SERVER_ADDR"]);
        $Envarry['name'] = $_SERVER["SERVER_NAME"];
        $Envarry['max_execution_time'] = ini_get('max_execution_time');
        $Envarry['allow_reference'] = (ini_get('allow_call_time_pass_reference') ? '<font color=green>[√]On</font>' : '<font color=red>[×]Off</font>');
        $Envarry['allow_url_fopen'] = (ini_get('allow_url_fopen') ? '<font color=green>[√]On</font>' : '<font color=red>[×]Off</font>');
        $Envarry['safe_mode'] = (ini_get('safe_mode') ? '<font color=red>[×]On</font>' : '<font color=green>[√]Off</font>');
        $err = 0;
        if (empty($Envarry['tmp']['GD Version'])) {
            $Envarry['gd'] = '<font color=red>[×]Off</font>';
            $err++;
        } else {
            $Envarry['gd'] = '<font color=green>[√]On</font> ' . $Envarry['tmp']['GD Version'];
        }
        if (function_exists('mysqli_connect')) {
            $Envarry['mysql'] = '<span class="correct_span">&radic;</span> 已安装';
        } else {
            $Envarry['mysql'] = '<span class="correct_span error_span">&radic;</span> 出现错误';
            $err++;
        }
        if (ini_get('file_uploads')) {
            $Envarry['uploadSize'] = '<span class="correct_span">&radic;</span> ' . ini_get('upload_max_filesize');
        } else {
            $Envarry['uploadSize'] = '<span class="correct_span error_span">&radic;</span>禁止上传';
        }
        if (function_exists('session_start')) {
            $Envarry['session'] = '<span class="correct_span">&radic;</span> 支持';
        } else {
            $Envarry['session'] = '<span class="correct_span error_span">&radic;</span> 不支持';
            $err++;
        }
        $folder = array('/', 'config');
        $folderCheck = $this->folderCheck($folder);
        $this->assign("folderCheck", $folderCheck);
        $this->assign($Envarry);
    }

    /**
     * 如果输入了数据库链接则检查
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function pwdcheck() {
        if ($_GET['testdbpwd']) {
            $dbHost = $_POST['dbHost'] . ':' . $_POST['dbPort'];
            $link = @mysqli_connect($_POST['dbHost'], $_POST['dbUser'], $_POST['dbPwd'], '', $_POST['dbPort']);
            $data = array('host' => $dbHost, "dbUser" => $_POST['dbUser'], "dbPwd" => $_POST['dbPwd']);
            if ($link) {
                die("true");
            } else {
                die("false");
            }
        }
    }

    /**
     * 检查定义的目录是否有可写权限
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function folderCheck($folder) {
        foreach ($folder as $dir) {
            $Testdir = WEB_PATH ."/". $dir;
            $this->dir_create($Testdir);
            if ($this->TestWrite($Testdir)) {
                $w = '<span class="correct_span">&radic;</span>可写 ';
            } else {
                $w = '<span class="correct_span error_span">&radic;</span>不可写 ';
                $err++;
            }
            if (is_readable($Testdir)) {
                $r = '<span class="correct_span">&radic;</span>可读';
            } else {
                $r = '<span class="correct_span error_span">&radic;</span>不可读';
                $err++;
            }
            $folderCheck .= "<tr><td>" . $dir . "</td><td>" . $w . "</td><td>" . $r . "</td></tr>";
        }
        return $folderCheck;
    }

    /**
     * 检查安装Sql文件是否存在
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    static function sqlFileCheck() {
        $sqlFile = 'install.sql';
        if (!file_exists(WEB_PATH . '/zmapp/' . $sqlFile)) {
            echo '缺少数据库文件!';
            exit;
        }
    }

    /**
     * 测试是否有可写权限 
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function testwrite($d) {
        $tfile = "_test.txt";
        $fp = @fopen($d . "/" . $tfile, "w");
        if (!$fp) {
            return false;
        }
        fclose($fp);
        $rs = @unlink($d . "/" . $tfile);
        if ($rs) {
            return true;
        }
        return false;
    }

    /**
     * 执行sql语句
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function sql_execute($sql, $tablepre) {
        $sqls = $this->sql_split($sql, $tablepre);
        if (is_array($sqls)) {
            foreach ($sqls as $sql) {
                if (trim($sql) != '') {
                    mysql_query($sql);
                }
            }
        } else {
            mysql_query($sqls);
        }
        return true;
    }

    /**
     * 分割sql文件
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function sql_split($sql, $tablepre) {
        $tablepre = strtolower($tablepre); //转换前缀为小写
        if ($tablepre != "zhimeng_") {
            $sql = str_replace("zhimeng_", $tablepre, $sql);
        }
        $sql = preg_replace("/TYPE=(InnoDB|MyISAM|MEMORY)( DEFAULT CHARSET=[^; ]+)?/", "ENGINE=\\1 DEFAULT CHARSET=utf8", $sql);
        if ($r_tablepre != $s_tablepre) {
            $sql = str_replace($s_tablepre, $r_tablepre, $sql);
        }
        $sql = str_replace("\r", "\n", $sql);
        $ret = array();
        $num = 0;
        $queriesarray = explode(";\n", trim($sql));
        unset($sql);
        foreach ($queriesarray as $query) {
            $ret[$num] = '';
            $queries = explode("\n", trim($query));
            $queries = array_filter($queries);
            foreach ($queries as $query) {
                $str1 = substr($query, 0, 1);
                if ($str1 != '#' && $str1 != '-')
                    $ret[$num] .= $query;
            }
            $num++;
        }
        return $ret;
    }

    /**
     * 处理目录
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function _dir_path($path) {
        $path = str_replace('\\', '/', $path);
        if (substr($path, -1) != '/')
            $path = $path . '/';
        return $path;
    }

    /**
     * 检测目录是否有可写权限 
     * @author 四川挚梦科技有限公司
     * @date 2018-03-17
     */
    public function dir_create($path, $mode = 0777) {
        if (is_dir($path))
            return TRUE;

        $ftp_enable = 0;
        $path = $this->dir_path($path);
        $temp = explode('/', $path);
        $cur_dir = '';
        $max = count($temp) - 1;
        for ($i = 0; $i < $max; $i++) {
            $cur_dir .= $temp[$i] . '/';
            if (@is_dir($cur_dir))
                continue;

            @mkdir($cur_dir, 0777, true);
            @chmod($cur_dir, 0777);
        }
        return is_dir($path);
    }

    public function dir_path($path) {
        $path = str_replace('\\', '/', $path);
        if (substr($path, -1) != '/')
            $path = $path . '/';
        return $path;
    }

    public function installSql() {
        $postdata = json_encode($_POST);
        $this->assign('postdata', $postdata);
        if (intval($_GET['install'])) {
            $n = intval($_GET['n']);
            $arr = array();
            $dbHost = trim($_POST['dbhost']);
            $dbPort = trim($_POST['dbport']);
            $dbName = trim($_POST['dbname']);
            //$dbHost = empty($dbPort) || $dbPort == 3306 ? $dbHost : $dbHost . ':' . $dbPort;
            $dbUser = trim($_POST['dbuser']);
            $dbPwd = trim($_POST['dbpw']);
            $dbPrefix = empty($_POST['dbprefix']) ? 'think_' : trim($_POST['dbprefix']);
            $email = trim($_POST['manager_email']);
            $password = md5(trim($_POST['manager_pwd']));
            $config = array();
            $config = array(
                'type' => 'mysql', // 数据库类型
                'hostname' => $dbHost, // 服务器地址
                'database' => $dbName, // 数据库名
                'username' => $dbUser, // 用户名
                'password' => $dbPwd, // 密码
                'hostport' => $dbPort, // 端口
                'dsn' => '', // 连接dsn
                'params' => array(), // 数据库连接参数
                'charset' => 'utf8', // 数据库编码默认采用utf8
                'prefix' => $dbPrefix, // 数据库表前缀
                'debug' => true, // 数据库调试模式
                'deploy' => 0, // 数据库部署方式:0 集中式(单一服务器),1 分布式(主从服务器)
                'rw_separate' => false, // 数据库读写是否分离 主从式有效
                'master_num' => 1, // 读写分离后 主服务器数量
                'slave_no' => '', // 指定从服务器序号
                'fields_strict' => true, // 是否严格检查字段是否存在
                'resultset_type' => 'array', // 数据集返回类型 array 数组 collection Collection对象
                'auto_timestamp' => false, // 是否自动写入时间戳字段
                'datetime_format' => 'Y-m-d H:i:s', // 时间字段取出后的默认时间格式
                'sql_explain' => false, // 是否需要进行SQL性能分析
                'query' => '\\think\\db\\Query'
            );
            $conn = @mysqli_connect($dbHost, $dbUser, $dbPwd, '', $dbPort);
            if (!$conn) {
                $arr['msg'] = "连接数据库失败!" . $dbPort;
                die(json_encode($arr));
            }
            mysqli_query($conn, "SET NAMES 'utf8'");
            $version = mysqli_get_server_info($conn);
            if ($version < 4.1) {
                $arr['msg'] = '数据库版本太低!';
                die(json_encode($arr));
            }
            $result = @mysqli_query($conn, "CREATE DATABASE IF NOT EXISTS `" . $dbName . "` DEFAULT CHARACTER SET utf8;");
            if (!$result) {
                $arr['msg'] = '<li><span class="correct_span error_span">&radic;</span>数据库 ' . $dbName . ' 不存在，也没权限创建新的数据库！</li>';
                die(json_encode($arr));
            }
            if (empty($n)) {
                $arr['n'] = 1;
                $arr['msg'] = "<li><span class='correct_span'>&radic;</span>成功创建数据库:{$dbName}<br></li>";
                die(json_encode($arr));
            }
            @mysqli_select_db($conn, $dbName);
            //读取数据文件
            $sqldata = file_get_contents(WEB_PATH . '/zmapp/install.sql');
            $sqlFormat = $this->sql_split($sqldata, $dbPrefix);
            /**
              执行SQL语句

             */
            $counts = count($sqlFormat);
            for ($i = $n; $i < $counts; $i++) {
                $sql = trim($sqlFormat[$i]);
                if (strstr($sql, 'CREATE TABLE')) {
                    preg_match('/CREATE TABLE `([^ ]*)`/', $sql, $matches);
                    mysqli_query($conn, "DROP TABLE IF EXISTS `$matches[1]");
                    $ret = mysqli_query($conn, $sql);
                    if ($ret) {
                        $message = '<li><span class="correct_span">&radic;</span>创建数据表: ' . $matches[1] . '--完成</li> ';
                    } else {
                        $message = '<li><span class="correct_span error_span">&radic;</span>创建数据表: ' . $matches[1] . '--失败</li>';
                    }
                    $i++;
                    $arr = array('n' => $i, 'msg' => $message);
                    die(json_encode($arr));
                } else {
                    $ret = mysqli_query($conn, $sql);
                    $message = '';
                    $arr = array('n' => $i, 'msg' => $message);
                }
            }
            if ($i == 999999) {
                exit;
            }
            $message = '<li><span class="correct_span">&radic;</span>成功添加管理员</li>';
			$message.='<li><span class="correct_span">&radic;</span>成功写入配置文件．</li>';
			$message.='<li><span class="correct_span success">&radic;</span>安装完成．</li>';
            file_put_contents(WEB_PATH . "/config/database.php", ("<?php\t\nreturn " . var_export($config, true) . ";\n?>"));
            $arr = array('n' => 999999, 'msg' => $message);
            die(json_encode($arr));
        }
    }

}
