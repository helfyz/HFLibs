//
//  UIViewController+HFCollectionView.m
//  Project1
//
//  Created by helfy on 16/1/6.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "UIViewController+HFCollectionView.h"
#import "HFCollectionSectionModel.h"
#import "HFCollectionCellModel.h"
#import "HFCollectionViewCell.h"
#import "HFCollectionReusableView.h"
#import <objc/runtime.h>
@implementation UIViewController(HFCollectionView)
static char HFCollectionView;
static char HFDataSourceModels;
static char HFItemSize;

#pragma getter & setter

- (void)setHfc_collectionView:(UICollectionView *)hfc_collectionView{
    [self willChangeValueForKey:@"collectionView"];
    objc_setAssociatedObject(self, &HFCollectionView,
                             hfc_collectionView,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"collectionView"];
}

-(UICollectionView *)hfc_collectionView
{
    return  objc_getAssociatedObject(self, &HFCollectionView);
}

-(void)sethfc_dataSourceModels:(NSMutableArray *)hfc_dataSourceModels
{
    [self willChangeValueForKey:@"dataSourceModels"];
    objc_setAssociatedObject(self, &HFDataSourceModels,
                             hfc_dataSourceModels,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"dataSourceModels"];
 
}
-(NSMutableArray *)hfc_dataSourceModels
{
    return objc_getAssociatedObject(self, &HFDataSourceModels);
}


-(void)setHft_itemSize:(CGSize)itemSize
{
    [self willChangeValueForKey:@"itemSize"];
    
    objc_setAssociatedObject(self, &HFItemSize,
                             [NSValue valueWithCGSize:itemSize],
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"itemSize"];
    
}
-(CGSize)hft_itemSize
{
    NSValue *value = objc_getAssociatedObject(self, &HFItemSize);
    return [value CGSizeValue];
}



#pragma

-(void)hfc_reloadData
{
    [self.hfc_collectionView reloadData];
}
-(void)hfc_setupData
{
    self.hfc_dataSourceModels = [NSMutableArray array];
}
//设置完成之后需要对Cell的Obj提取设置一些东西
-(void)hfc_registerCellClassForcellModels
{
    if (self.hfc_isSectionData) {
        for (HFCollectionSectionModel *sectionObj in self.hfc_dataSourceModels) {
            
            
            [self.hfc_collectionView registerClass:NSClassFromString(sectionObj.reusableClassName) forSupplementaryViewOfKind:sectionObj.kind withReuseIdentifier:sectionObj.reuseIdentifier];
            
            for (HFCollectionCellModel *cellModel in sectionObj.cellModels) {
                [self.hfc_collectionView registerClass:NSClassFromString(cellModel.cellClassName) forCellWithReuseIdentifier:cellModel.reuseIdentifier];
            }
        }
    }
    else{
        for (HFCollectionCellModel *cellModel in self.hfc_dataSourceModels) {
            [self.hfc_collectionView registerClass:NSClassFromString(cellModel.cellClassName) forCellWithReuseIdentifier:cellModel.reuseIdentifier];
        }
    }
    
    
}

/**
 *  把数据转化成符合格式的cellModel。
 *  如果数据中对应多种cell 样式，需按需求设置对应的cellClassName 再使用setcellModelsForObjs: isAddmore:
 *  @param dataSource  数据原型
 *  @param className  cell 的className
 *  @param addMore    yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)hfc_setCellModelsForDataSource:(NSArray *)dataSource cellClassName:(NSString *)className  isAddmore:(BOOL)addMore
{
    NSMutableArray *cellModels = [NSMutableArray array];
    [self.hfc_collectionView registerClass:NSClassFromString(className)  forCellWithReuseIdentifier:className];
    
    
    //先判断 dataSource 的obj 是否是NSArray 如果 是array认为是section模式
    BOOL isSection = NO;
    if(dataSource.count >0)
    {
        if([[[dataSource firstObject] class] isSubclassOfClass:[NSArray class]])
        {
            isSection = YES;
        }
    }
#pragma clang diagnostic ignored "-Warc-selector-leaks"
    
    if(isSection == NO)
    {
        for (id subObj in dataSource) {
            HFCollectionCellModel *cellModel = [[HFCollectionCellModel alloc] init];
            cellModel.valueData = subObj;
            cellModel.reuseIdentifier = className;
//            cellModel.cellAction = @selector(tableViewDidSelectcellModel:);
            [cellModels addObject:cellModel];
        }
        
    }
    else{
        for (NSArray *sectionArray in dataSource) {
            HFCollectionSectionModel *sectionObj = [[HFCollectionSectionModel alloc] init];
            NSMutableArray *subcellModels = [NSMutableArray array];
            
            for (id subObj in sectionArray) {
                HFCollectionCellModel *cellModel = [[HFCollectionCellModel alloc] init];
                cellModel.valueData = subObj;
                cellModel.reuseIdentifier = className;
//                cellModel.cellAction = @selector(tableViewDidSelectcellModel:);
                [subcellModels addObject:cellModel];
                
            }
            sectionObj.cellModels = subcellModels;
            [cellModels addObject:sectionObj];
        }
        
    }
    if(addMore)
    {
        if(self.hfc_dataSourceModels == nil)
        {
            [self hfc_setupData];
        }
        [self.hfc_dataSourceModels addObjectsFromArray:cellModels];
    }
    else
    {
        self.hfc_dataSourceModels = cellModels;
    }
    //
    //这种设置方式不需要再提取注册cell
    [self hfc_reloadData];
    
}

/**
 *  自己转换成cellModel后进行设置
 *
 *  @param cellModel cellModel
 *  @param addMore yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)hfc_setCellModelsForObjs:(NSMutableArray *)cellModels  isAddmore:(BOOL)addMore
{
    if(addMore)
    {
        if(self.hfc_dataSourceModels == nil)
        {
            [self hfc_setupData];
        }
        [self.hfc_dataSourceModels addObjectsFromArray:cellModels];
    }
    else
    {
        self.hfc_dataSourceModels = cellModels;
    }
    
    [self hfc_registerCellClassForcellModels];
    [self hfc_reloadData];
}


#pragma setupViews
-(void)hfc_setupCollectionForViewLayout:(UICollectionViewFlowLayout *)flowLayout
{
    self.hfc_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.hfc_collectionView.backgroundColor =[UIColor clearColor];
    self.hfc_collectionView.dataSource = (id)self;
    self.hfc_collectionView.delegate = (id)self;
    self.hfc_collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.hfc_collectionView];
    
}

-(void)hfc_setupCollectionView
{
    UICollectionViewFlowLayout *allFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    allFlowLayout.minimumInteritemSpacing =5;
    allFlowLayout.minimumLineSpacing =10;
    
    [self hfc_setupCollectionForViewLayout:allFlowLayout];

}


-(BOOL)hfc_isSectionData
{
    if(self.hfc_dataSourceModels.count >0)
    {
        if([[self.hfc_dataSourceModels firstObject] isKindOfClass:[HFCollectionSectionModel class]])
        {
            return YES;
        }
    }
    return NO;
}
-(HFCollectionCellModel *)hfc_cellModelForIndexPath:(NSIndexPath *)indexPath
{
    HFCollectionCellModel *cellModel = nil;
    if (self.hfc_isSectionData) {
        cellModel = ((HFCollectionSectionModel *)self.hfc_dataSourceModels[indexPath.section]).cellModels[indexPath.row];
    }
    else{
        cellModel =self.hfc_dataSourceModels[indexPath.row];
    }
    return cellModel;
}
#pragma mark - UICollectionViewDelegate
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//
  
    HFCollectionCellModel *cellModel = [self hfc_cellModelForIndexPath:indexPath];
    
    if(CGSizeEqualToSize(cellModel.itemSize, CGSizeZero))
    {
        return self.hft_itemSize;
    }
    
    return cellModel.itemSize;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if([self hfc_isSectionData])
    {
        HFCollectionSectionModel *sectionObj = self.hfc_dataSourceModels[section];
        return sectionObj.edgeInsets;
    }
    return UIEdgeInsetsZero;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
     if([self hfc_isSectionData])
     {
         return self.hfc_dataSourceModels.count;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([self hfc_isSectionData])
    {
        return  ((HFCollectionSectionModel *)self.hfc_dataSourceModels[section]).cellModels.count;
    }
    else{
        return self.hfc_dataSourceModels.count;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if([self hfc_isSectionData])
    {
        HFCollectionSectionModel *sectionObj = self.hfc_dataSourceModels[section];
        return  sectionObj.headerSize;
    }
    return CGSizeZero;
}
//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)sender cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    HFCollectionCellModel *cellModel = [self hfc_cellModelForIndexPath:indexPath];

    HFCollectionViewCell *cell = [sender dequeueReusableCellWithReuseIdentifier:cellModel.reuseIdentifier forIndexPath:indexPath];
    
    [cell bindData:cellModel];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)sender viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
 
    if([self hfc_isSectionData])
    {
        HFCollectionSectionModel *sectionObj = self.hfc_dataSourceModels[indexPath.section];
        HFCollectionReusableView *reusableView= [sender dequeueReusableSupplementaryViewOfKind:sectionObj.kind withReuseIdentifier:sectionObj.reuseIdentifier forIndexPath:indexPath];
        [reusableView bindData:sectionObj];
        
        reusableview = reusableView;
    }
    return reusableview;
    
}
//
//- (void)collectionView:(UICollectionView *)sender didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    YSLargerImageViewController *larger = [[YSLargerImageViewController alloc] init];
//    larger.photoArray = self.topic.photoinfo;
//    larger.currentIndex = (int)indexPath.row;
//    
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:larger];
//    [navi setNavigationBarHidden:YES];
//    [self.navigationController presentViewController:navi animated:YES completion:^{
//        
//    }];
//}


@end
