<?php
namespace app\Admin\validate;

use think\Validate;

class Uploads extends Validate
{
    protected $rule = [
		'fileExt'=>'jpg,png,gif',
		'fileSize'=>15678
    ];

}
