//
//  HFTableView.h
//  Project1
//
//  Created by helfy on 16/1/19.
//  Copyright © 2016年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTableCellObj.h"
#import "HFTableSectionObj.h"
#import "HFTableViewCell.h"
#import "HFFormTableCellObj.h"
#import "HFCustomTableCellObj.h"
#import "HFCustomTableViewCell.h"
@protocol HFTableViewDelegate <NSObject>

//如果用户需要对cell进行配置
- (void)tableView:(UITableView *)sender configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end

@interface HFTableView : UITableView
@property(nonatomic,strong)  NSMutableArray *dataSourceObjs;
// push 使用
@property (assign,nonatomic) UIViewController *viewController;




/**
 *  把数据转化成符合格式的cellObj。
 *  如果数据中对应多种cell 样式，需按需求设置对应的cellClassName 再使用setCellObjsForObjs: isAddmore:
 *  @param dataSource  数据原型
 *  @param className  cell 的className
 *  @param addMore    yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)setCellObjsForDataSource:(NSArray *)dataSource cellClassName:(NSString *)className  isAddmore:(BOOL)addMore;
/**
 *  自己转换成cellObj后进行设置
 *
 *  @param cellObj cellObj
 *  @param addMore yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)setCellObjsForObjs:(NSArray *)cellObjs  isAddmore:(BOOL)addMore;



-(HFTableCellObj *)cellObjForIndexPath:(NSIndexPath *)indexPath;
//HFFormTableCellObj 才会有key
-(HFFormTableCellObj *)cellObjForObjKey:(NSString *)objKey;



#pragma mark -- 事件监听
-(void)openKeyboardObserver;
-(void)closeKeyboardObserver;




@end
