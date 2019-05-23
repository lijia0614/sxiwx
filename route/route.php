<?php
// +----------------------------------------------------------------------
// 注意长规则匹配在前，短规则在后
// +----------------------------------------------------------------------

//新闻资讯匹配
Route::get('news/category/:cid-[:p]-[:pid]-[:keyword]','home/article/category');
Route::get('news/:id','home/article/show');
//产品匹配
Route::get('product/category/:cid-[:p]','home/product/category');
Route::get('product/:id','home/product/show');

//商品匹配
Route::get('goods/category/:cid-[:p]','home/goods/category');
Route::get('goods/:id','home/goods/show');


