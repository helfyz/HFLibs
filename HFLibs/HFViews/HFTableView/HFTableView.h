//
//  HFTableView.h
//  Project1
//
//  Created by helfy on 16/1/19.
//  Copyright © 2016年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTableCellModel.h"
#import "HFTableSectionModel.h"
#import "HFTableViewCell.h"
#import "HFFormTableCellModel.h"
#import "HFCustomTableCellModel.h"
#import "HFCustomTableViewCell.h"
@protocol HFTableViewDelegate <NSObject>

//如果用户需要对cell进行配置
- (void)tableView:(UITableView *)sender configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end

@interface HFTableView : UITableView <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)  NSMutableArray *dataSourceModels;
// push 使用
@property (assign,nonatomic) UIViewController *viewController;




/**
 *  把数据转化成符合格式的cellObj。
 *  如果数据中对应多种cell 样式，需按需求设置对应的cellClassName 再使用setCellObjsForObjs: isAddmore:
 *  @param dataSource  数据原型
 *  @param className  cell 的className
 *  @param addMore    yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)setCellModelsForDataSource:(NSArray *)dataSource cellClassName:(NSString *)className  isAddmore:(BOOL)addMore;
/**
 *  自己转换成cellObj后进行设置
 *
 *  @param cellObj cellObj
 *  @param addMore yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)setCellModelsForObjs:(NSArray *)cellObjs  isAddmore:(BOOL)addMore;

/**
 *  重新加载一个section
 *
 *  @param section 的序号 或者 key
 */
-(void)reloadSectionForSectionIndex:(NSUInteger )sectionIndex withRowAnimation:(UITableViewRowAnimation)animation;
-(void)reloadSectionForSectionKey:(NSString *)sectionKey withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  替换一个section
 *
 *  @param sectionObj   新的sectionObj
 *  @param sectionIndex section 的序号
 *   @param sectionKey section的Key
 */
-(void)replaceSection:(HFTableSectionModel *)sectionObj sectionIndex:(NSUInteger)sectionIndex withRowAnimation:(UITableViewRowAnimation)animation;
-(void)replaceSection:(HFTableSectionModel *)sectionObj sectionKey:(NSString *)sectionKey withRowAnimation:(UITableViewRowAnimation)animation;

-(HFTableCellModel *)cellModelForIndexPath:(NSIndexPath *)indexPath;
//HFFormTableCellObj 才会有key
-(HFFormTableCellModel *)cellModelForObjKey:(NSString *)objKey;
-(HFTableSectionModel *)sectionModelForKey:(NSString *)sectionKey;

#pragma mark -- 事件监听
-(void)openKeyboardObserver;
-(void)closeKeyboardObserver;




@end
