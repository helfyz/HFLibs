# HFKit
基于UIKit   希望能简化UIKit 的设置 快速开发
pod 'HFLibs' ,'~> 0.8.3'


UITableView 是常规app中使用比较频繁的控件，但是我个人始终觉得UITableView 的设置太过繁琐了。每次写个tableView，需要去实现一堆代理
而且需求改动的话，修改也很跳跃，稍不注意就是坑。
HFDNormalSettingViewController  采用原始的方式(switch) 来做的。 大家可以和 HFDSettingViewController 对比一下
HFTableView 通过cellModel来配置cell 
 cellModel 主要分成 custom & form 
  form 主要用于表单形式& 小型数据展示（如个人页面 & 设置界面）
  
    cellModel = [[HFTableViewFormCellModel alloc] initWithAccessoryMode:HFFormAccessoryModeTextField];
    cellModel.title = @"手机号";
    cellModel.regex = @"^1\\d{10}";
    cellModel.isRequired = YES;
    cellModel.valuePlaceholder = @"请输入您的手机号";
    ((HFTextField *)cellModel.accessoryView).placeholderColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    cellModel.modelKey = @"phoneNumber";

 custom 也可用作列表展示  也可用于form 的补充（可参考HFDCommitViewController 中的用法），custom 在不设置高度的情况下。会自行调用fd 进行高度计算
 
      cellModel = [[HFTableViewCustomCellModel alloc] init];
      cellModel.valueData = obj;
      cellModel.useXib = YES;
      cellModel.tablViewCellClassName = className;
      

 UIButton 也是比较常用的，对于我来说，button有几点很不爽
    1，很多基本设置离不开state & events ，但是对于常用app开发来说，基本就是使用UIControlEventTouchUpInside & UIControlStateNormal ，每次设置title 或者 color 都要去写这个state，是比较烦的
    2，image和title 布局， 图片和标题的排版一直是我的痛点。。图在上、图片在下、以及图片在左或者在右，这些设置起来都比较麻烦。常规的做法便是去调整offset。调整半天，size一变。。。。
    3，点击背景高亮。。这功能UIButton 是没有的，常规的做法便是用图来代替。。
  
  
    HFButton *commitButton = [HFButton new];
    [commitButton setTitile:@"提交" textColor:[UIColor whiteColor]];
    [commitButton addTarget:self action:@selector(commit:)];
    [commitButton setNormalBgColor:[UIColor orangeColor] highlightedBgColor:[UIColor grayColor]];
  
 
