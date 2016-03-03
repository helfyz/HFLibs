# HFKit
基于UIKit   希望能简化UIKit 的设置 快速开发



HFButton 快速设置，不用每次设置都选择Status。 相对UIButton，增加Title、image的排版方式 & 增加高亮背景色的改变

    HFButton *button = [HFButton new];
    [button addTarget:self action:@selector(submit)];
    [button setTitile:@"提交" textColor:[UIColor whiteColor]];
    [button setNormalBgColor:[UIColor redColor] highlightedBgColor:[UIColor grayColor]];
  



TableViewController  这里面的东西很多，不一一阐述了。这里列举了一个填写手机号码的cell数据定义。。可以避免各种switch判断，

    cellObj = [[HFFormTableCellObj alloc] initWithAccessoryMode:HFFormAccessoryModeTextField];
    cellObj.title = @"手机号码:";
    cellObj.objName = @"手机号码";
    cellObj.objKey =  @"phone";
    cellObj.isRequired = YES;
    cellObj.regex = @"1\\d{10}";
    cellObj.valuePlaceholder = @"手机号码";



CocoaPods 方式
   pod 'HFKit', '~> 0.0.5'
   
只需要自定义的View类
     pod 'HFKit/HFViews',  
只需要view的扩展
     pod 'HFKit/UIViewAdditions', 


