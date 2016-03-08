//
//  UIViewController+HFCollectionView.h
//  Project1
//
//  Created by helfy on 16/1/6.
//  Copyright © 2016年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HFCollectionCellObj;
@interface UIViewController(HFCollectionView)


@property (nonatomic, strong) UICollectionView *hfc_collectionView;
@property(nonatomic,strong)  NSMutableArray *hfc_dataSourceObjs;


@property(nonatomic,assign)  CGSize hft_itemSize;   //整体设置item 的size。。如cell的size不同。则设置每个cellObj的size


-(void)hfc_reloadData;
-(void)hfc_setupData;
/**
 *  把数据转化成符合格式的cellObj。
 *  如果数据中对应多种cell 样式，需按需求设置对应的cellClassName 再使用setCellObjsForObjs: isAddmore:
 *  @param dataSource  数据原型
 *  @param className  cell 的className
 *  @param addMore    yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)hfc_setCellObjsForDataSource:(NSArray *)dataSource cellClassName:(NSString *)className  isAddmore:(BOOL)addMore;
/**
 *  自己转换成cellObj后进行设置
 *
 *  @param cellObj cellObj
 *  @param addMore yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)hfc_setCellObjsForObjs:(NSArray *)cellObjs  isAddmore:(BOOL)addMore;
-(void)hfc_setupCollectionForViewLayout:(UICollectionViewFlowLayout *)flowLayout;
-(void)hfc_setupCollectionView;

-(HFCollectionCellObj *)hfc_cellObjForIndexPath:(NSIndexPath *)indexPath;
@end
