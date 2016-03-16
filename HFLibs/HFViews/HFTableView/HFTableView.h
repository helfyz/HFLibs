//
//  HFTableView.h
//  Project1
//
//  Created by helfy on 16/1/19.
//  Copyright © 2016年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTableViewCellModel.h"
#import "HFTableViewSectionModel.h"
#import "HFTableViewCell.h"
#import "HFTableViewFormCellModel.h"
#import "HFTableViewCustomCellModel.h"
#import "HFTableViewCustomCell.h"
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
 *  如果数据中对应多种cell 样式，需按需求设置对应的cellClassName 再使用setcellModelsForModels: isAddmore:
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
-(void)setCellModelsForModels:(NSArray *)cellModels  isAddmore:(BOOL)addMore;

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
-(void)replaceSection:(HFTableViewSectionModel *)sectionObj sectionIndex:(NSUInteger)sectionIndex withRowAnimation:(UITableViewRowAnimation)animation;
-(void)replaceSection:(HFTableViewSectionModel *)sectionObj sectionKey:(NSString *)sectionKey withRowAnimation:(UITableViewRowAnimation)animation;



-(void)reloadCellForSectionIndex:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
-(void)reloadCellForSectionKey:(NSString *)cellModelKey withRowAnimation:(UITableViewRowAnimation)animation;
-(void)replaceCellModel:(HFTableViewCellModel *)cellModel cellIndex:(NSIndexPath *)indexpath withRowAnimation:(UITableViewRowAnimation)animation;
-(void)replaceCellModel:(HFTableViewCellModel *)cellModel cellModelKey:(NSString *)cellModelKey withRowAnimation:(UITableViewRowAnimation)animation;



-(HFTableViewCellModel *)cellModelForIndexPath:(NSIndexPath *)indexPath;
-(HFTableViewFormCellModel *)cellModelForModelKey:(NSString *)modelKey;
-(HFTableViewSectionModel *)sectionModelForKey:(NSString *)sectionKey;
-(NSIndexPath *)cellIndexForModelKey:(NSString *)modelKey;
-(NSInteger)sectionIndexForModelKey:(NSString *)sectionKey;
#pragma mark -- 事件监听
-(void)openKeyboardObserver;
-(void)closeKeyboardObserver;




@end
