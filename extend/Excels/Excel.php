<?php

namespace Excels;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

/*
		$article=Db("article")->field("id,title,FROM_UNIXTIME(create_time,'%Y/%m/%d')")->select();
		$excel=new Excel();
		$title=array("编号","标题","添加时间");
        $excel->save($title,$article);
*/

class Excel {

    public function download($filename,$title,$data) {
		try{
			if(!is_array($title)||count($title)<=0){
				return false;	
			}
			$spreadsheet = new Spreadsheet();
			foreach($title as $key=>$one){//设置标题栏目
					$spreadsheet->setActiveSheetIndex(0)->setCellValueByColumnAndRow($key+1,1,$one);//列，行，值     
			}
			
			foreach($data as $key=>$one){//设置内容
				$i=1;
				foreach($one as $ckey=>$cone){
					$spreadsheet->setActiveSheetIndex(0)->setCellValueByColumnAndRow($i,$key+2,$cone);//列，行，值
					$i++;
				}
			}		
			$writer = new Xlsx($spreadsheet);
			//$filename = WEB_PATH . "/hello_world.xlsx";
			header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');//告诉浏览器输出07Excel文件
			//header('Content-Type:application/vnd.ms-excel');//告诉浏览器将要输出Excel03版本文件
			header('Content-Disposition: attachment;filename="'.$filename.'"');//告诉浏览器输出浏览器名称
			header('Cache-Control: max-age=0');//禁止缓存
			$writer->save('php://output');		
			$spreadsheet->disconnectWorksheets();
			unset($spreadsheet);		
			//$writer->save($filename);
		} catch (\Exception $e) {
            $this->error=$e;
			return 0;
        }
    }
	
	/*
		自动计算列宽
	*/	
	public function autoFitColumnWidthToContent($sheet, $fromCol, $toCol) {
        if (empty($toCol) ) {//not defined the last column, set it the max one
            $toCol = $sheet->getColumnDimension($sheet->getHighestColumn())->getColumnIndex();
        }
        for($i = $fromCol; $i <= $toCol; $i++) {
            $sheet->getColumnDimension($i)->setAutoSize(true);
        }
        $sheet->calculateColumnWidths();
    }	
	
	

}

