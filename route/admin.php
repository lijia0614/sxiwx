<?php	
 Route::rule('admin', function(){return '404 not found!';});
Route::rule('system/:c/:a', 'admin/:c/:a');
Route::rule('system', 'admin/index/index');

?>