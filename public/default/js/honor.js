/**
 * Created by Administrator on 2018/3/5.
 */
var $a=$(".buttons a");
var $s=$(".buttons span");
var cArr=["p4","p3","p2","p1"];
var index=2;
$(".next").click(
    function(){
        nextimg();
    }
)
$(".prev").click(
    function(){
        previmg();
    }
)
//上一张
function previmg(){
    cArr.unshift(cArr[3]);
    cArr.pop();
    //i是元素的索引，从0开始
    //e为当前处理的元素
    //each循环，当前处理的元素移除所有的class，然后添加数组索引i的class
    $(".list>ul>li").each(function(i,e){
        $(e).removeClass().addClass(cArr[i]);
    })
    index--;
    if (index<0) {
        index=3;
    }
    // $('.list ul li').eq(index).addClass('active').siblings().removeClass('active');
    var divs= $('.list ul li.p3');
    var tils= divs.find('p.titlsd').html();
    var tildesc= divs.find('p.titlsd').html();
    var bookLink= divs.find('a').attr('href');

    $('.blsk').attr('href',bookLink);
    $('.read').attr('href',bookLink);
    $('.blsk span').html(tils);
    $('.desc_flol').html(tildesc);

}

//下一张
function nextimg(){
    cArr.push(cArr[0]);
    cArr.shift();
    $(".list>ul>li").each(function(i,e){
        $(e).removeClass().addClass(cArr[i]);

    })
    index++;

    if (index>3) {
        index=0;
    }
    // $('.list ul li').eq(index).addClass('active').siblings().removeClass('active');

    var divs= $('.list ul li.p3');
    var tils= divs.find('p.titlsd').text();
    var tildesc= divs.find('p.titlsd2').text();
    var bookLink= divs.find('a').attr('href');

    $('.blsk').attr('href',bookLink);
    $('.read').attr('href',bookLink);
    $('.blsk span').html(tils);
    $('.desc_flol').html(tildesc);
}


//通过底下按钮点击切换
$a.each(function(){
    $(this).click(function(){
        var myindex=$(this).index();
        var b=myindex-index;
        if(b==0){
            return;
        }
        else if(b>0) {
            /*
             * splice(0,b)的意思是从索引0开始,取出数量为b的数组
             * 因为每次点击之后数组都被改变了,所以当前显示的这个照片的索引才是0
             * 所以取出从索引0到b的数组,就是从原本的这个照片到需要点击的照片的数组
             * 这时候原本的数组也将这部分数组进行移除了
             * 再把移除的数组添加的原本的数组的后面
             */
            var newarr=cArr.splice(0,b);
            cArr=$.merge(cArr,newarr);
            $(".list>ul>li").each(function(i,e){
                $(e).removeClass().addClass(cArr[i]);
            })
            index=myindex;
            show();
        }
        else if(b<0){
            /*
             * 因为b<0,所以取数组的时候是倒序来取的,也就是说我们可以先把数组的顺序颠倒一下
             * 而b现在是负值,所以取出索引0到-b即为需要取出的数组
             * 也就是从原本的照片到需要点击的照片的数组
             * 然后将原本的数组跟取出的数组进行拼接
             * 再次倒序,使原本的倒序变为正序
             */
            cArr.reverse();
            var oldarr=cArr.splice(0,-b)
            cArr=$.merge(cArr,oldarr);
            cArr.reverse();
            $(".list>ul>li").each(function(i,e){
                $(e).removeClass().addClass(cArr[i]);
                console.log(e)
            })
            index=myindex;
            show();
        }
    })
})

//改变底下按钮的背景色


//点击class为p2的元素触发上一张照片的函数
$(document).on("click",".p2",function(){
    previmg();
    return false;//返回一个false值，让a标签不跳转
});

//点击class为p4的元素触发下一张照片的函数
$(document).on("click",".p4",function(){
    nextimg();

    return false;
});

//			鼠标移入box时清除定时器
$(".box").mouseover(function(){
    clearInterval(timer);
})

//			鼠标移出box时开始定时器
$(".box").mouseleave(function(){
    timer=setInterval(nextimg,4000);
})

//			进入页面自动开始定时器
timer=setInterval(nextimg,4000);

