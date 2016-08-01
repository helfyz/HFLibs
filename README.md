# HFLibs  
 主要收录了一些 在自己项目中(主要是外包用得较多)的东西，目前包括对UIView 的一些简化设置&扩展
 ps：自己搞来玩的东西，只是为了方便，优化什么的还没搞。。要使用什么的最好还是下载源码，方便改
 
  pod 'HFLibs' ,'~> 1.0.0'


UITableView 是常规app中使用比较频繁的控件，但是我个人始终觉得UITableView 的设置太过繁琐了。每次写个tableView，需要去实现一堆代理
而且需求改动的话，修改也很跳跃，稍不注意就是坑。
HF采用的manger 管理tablView 的常用代理。并用cellModel的方式来设置cell

 UIButton 也是比较常用的，对于我来说，button有几点很不爽
    1，很多基本设置离不开state & events ，但是对于常用app开发来说，基本就是使用UIControlEventTouchUpInside & UIControlStateNormal ，每次设置title 或者 color 都要去写这个state，是比较烦的
    2，image和title 布局， 图片和标题的排版一直是我的痛点。。图在上、图片在下、以及图片在左或者在右，这些设置起来都比较麻烦。常规的做法便是去调整offset。调整半天，size一变。。。。
    3，点击背景高亮。。这功能UIButton 是没有的，常规的做法便是用图来代替。。

    HFButton *commitButton = [HFButton new];
    [commitButton setTitile:@"提交" textColor:[UIColor whiteColor]];
    [commitButton addTarget:self action:@selector(commit:)];
    [commitButton setNormalBgColor:[UIColor orangeColor] highlightedBgColor:[UIColor grayColor]];
  
 
