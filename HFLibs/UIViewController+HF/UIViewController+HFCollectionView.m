//
//  UIViewController+HFCollectionView.m
//  Project1
//
//  Created by helfy on 16/1/6.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "UIViewController+HFCollectionView.h"
#import "HFLibs.h"
#import <objc/runtime.h>
@implementation UIViewController(HFCollectionView)
static char HFCollectionView;
static char HFDataSourceObjs;
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

-(void)setHfc_dataSourceObjs:(NSMutableArray *)hfc_dataSourceObjs
{
    [self willChangeValueForKey:@"dataSourceObjs"];
    objc_setAssociatedObject(self, &HFDataSourceObjs,
                             hfc_dataSourceObjs,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"dataSourceObjs"];
 
}
-(NSMutableArray *)hfc_dataSourceObjs
{
    return objc_getAssociatedObject(self, &HFDataSourceObjs);
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
    self.hfc_dataSourceObjs = [NSMutableArray array];
}
//设置完成之后需要对Cell的Obj提取设置一些东西
-(void)hfc_registerCellClassForCellObjs
{
    if (self.hfc_isSectionData) {
        for (HFCollectionSectionObj *sectionObj in self.hfc_dataSourceObjs) {
            
            
            [self.hfc_collectionView registerClass:NSClassFromString(sectionObj.reusableClassName) forSupplementaryViewOfKind:sectionObj.kind withReuseIdentifier:sectionObj.reuseIdentifier];
            
            for (HFCollectionCellObj *cellObj in sectionObj.cellObjs) {
                [self.hfc_collectionView registerClass:NSClassFromString(cellObj.cellClassName) forCellWithReuseIdentifier:cellObj.reuseIdentifier];
            }
        }
    }
    else{
        for (HFCollectionCellObj *cellObj in self.hfc_dataSourceObjs) {
            [self.hfc_collectionView registerClass:NSClassFromString(cellObj.cellClassName) forCellWithReuseIdentifier:cellObj.reuseIdentifier];
        }
    }
    
    
}

/**
 *  把数据转化成符合格式的cellObj。
 *  如果数据中对应多种cell 样式，需按需求设置对应的cellClassName 再使用setCellObjsForObjs: isAddmore:
 *  @param dataSource  数据原型
 *  @param className  cell 的className
 *  @param addMore    yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)hfc_setCellObjsForDataSource:(NSArray *)dataSource cellClassName:(NSString *)className  isAddmore:(BOOL)addMore
{
    NSMutableArray *cellObjs = [NSMutableArray array];
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
            HFCollectionCellObj *cellObj = [[HFCollectionCellObj alloc] init];
            cellObj.valueData = subObj;
            cellObj.reuseIdentifier = className;
//            cellObj.cellAction = @selector(tableViewDidSelectCellObj:);
            [cellObjs addObject:cellObj];
        }
        
    }
    else{
        for (NSArray *sectionArray in dataSource) {
            HFCollectionSectionObj *sectionObj = [[HFCollectionSectionObj alloc] init];
            NSMutableArray *subCellObjs = [NSMutableArray array];
            
            for (id subObj in sectionArray) {
                HFCollectionCellObj *cellObj = [[HFCollectionCellObj alloc] init];
                cellObj.valueData = subObj;
                cellObj.reuseIdentifier = className;
//                cellObj.cellAction = @selector(tableViewDidSelectCellObj:);
                [subCellObjs addObject:cellObj];
                
            }
            sectionObj.cellObjs = subCellObjs;
            [cellObjs addObject:sectionObj];
        }
        
    }
    if(addMore)
    {
        if(self.hfc_dataSourceObjs == nil)
        {
            [self hfc_setupData];
        }
        [self.hfc_dataSourceObjs addObjectsFromArray:cellObjs];
    }
    else
    {
        self.hfc_dataSourceObjs = cellObjs;
    }
    //
    //这种设置方式不需要再提取注册cell
    [self hfc_reloadData];
    
}

/**
 *  自己转换成cellObj后进行设置
 *
 *  @param cellObj cellObj
 *  @param addMore yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void)hfc_setCellObjsForObjs:(NSMutableArray *)cellObjs  isAddmore:(BOOL)addMore
{
    if(addMore)
    {
        if(self.hfc_dataSourceObjs == nil)
        {
            [self hfc_setupData];
        }
        [self.hfc_dataSourceObjs addObjectsFromArray:cellObjs];
    }
    else
    {
        self.hfc_dataSourceObjs = cellObjs;
    }
    
    [self hfc_registerCellClassForCellObjs];
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
    if(self.hfc_dataSourceObjs.count >0)
    {
        if([[self.hfc_dataSourceObjs firstObject] isKindOfClass:[HFCollectionSectionObj class]])
        {
            return YES;
        }
    }
    return NO;
}
-(HFCollectionCellObj *)hfc_cellObjForIndexPath:(NSIndexPath *)indexPath
{
    HFCollectionCellObj *cellObj = nil;
    if (self.hfc_isSectionData) {
        cellObj = ((HFCollectionSectionObj *)self.hfc_dataSourceObjs[indexPath.section]).cellObjs[indexPath.row];
    }
    else{
        cellObj =self.hfc_dataSourceObjs[indexPath.row];
    }
    return cellObj;
}
#pragma mark - UICollectionViewDelegate
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//
  
    HFCollectionCellObj *cellObj = [self hfc_cellObjForIndexPath:indexPath];
    
    if(CGSizeEqualToSize(cellObj.itemSize, CGSizeZero))
    {
        return self.hft_itemSize;
    }
    
    return cellObj.itemSize;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if([self hfc_isSectionData])
    {
        HFCollectionSectionObj *sectionObj = self.hfc_dataSourceObjs[section];
        return sectionObj.edgeInsets;
    }
    return UIEdgeInsetsZero;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
     if([self hfc_isSectionData])
     {
         return self.hfc_dataSourceObjs.count;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([self hfc_isSectionData])
    {
        return  ((HFCollectionSectionObj *)self.hfc_dataSourceObjs[section]).cellObjs.count;
    }
    else{
        return self.hfc_dataSourceObjs.count;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if([self hfc_isSectionData])
    {
        HFCollectionSectionObj *sectionObj = self.hfc_dataSourceObjs[section];
        return  sectionObj.headerSize;
    }
    return CGSizeZero;
}
//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)sender cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    HFCollectionCellObj *cellObj = [self hfc_cellObjForIndexPath:indexPath];

    HFCollectionViewCell *cell = [sender dequeueReusableCellWithReuseIdentifier:cellObj.reuseIdentifier forIndexPath:indexPath];
    
    [cell bindData:cellObj];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)sender viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
 
    if([self hfc_isSectionData])
    {
        HFCollectionSectionObj *sectionObj = self.hfc_dataSourceObjs[indexPath.section];
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
