# HFKit
基于UIKit   希望能简化UIKit 的设置 快速开发
pod 'HFLibs' ,'~> 0.8.3'


tableView 是常规app中使用比较频繁的控件，但是我个人始终觉得tableView 的设置太过繁琐了。每次写个tableView，需要去实现一堆代理
而且需求改动的话，修改也很跳跃，稍不注意就是坑。
HFDNormalSettingViewController  采用原始的方式(switch) 来做的。 大家可以和 HFDSettingViewController 对比一下


