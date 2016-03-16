//
//  HFTableView.m
//  Project1
//
//  Created by helfy on 16/1/19.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "HFTableView.h"
#import "HFTableViewCellModel.h"
#import "HFTableViewSectionModel.h"
#import "HFTableViewCell.h"
#import "HFTableViewFormCellModel.h"
#import "HFTableViewCustomCellModel.h"
#import "HFTableViewCustomCell.h"
#import "UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h"

@interface HFTableView()
@property (nonatomic,strong) id<UITableViewDelegate,HFTableViewDelegate> customDelegate;
@property (nonatomic,strong) id<UITableViewDataSource> customDataSource;

@end

@implementation HFTableView

-(id)init
{
    self = [super init];
    if(self)
    {
        [self setupView];
    }
    return self;
    
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if(self)
    {
        [self setupView];
    }
    return self;
}
-(void)setupView
{
    [super setDelegate:(id)self];
    [super setDataSource:(id)self];
}

#pragma setupData
-(void)setupData
{
    self.dataSourceModels = [NSMutableArray array];
}

-(void)reloadData
{
    //    [self tablViewWillReload];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if([self.delegate respondsToSelector:@selector(tablViewWillReload)])
    {
        [self.delegate performSelector:@selector(tablViewWillReload) withObject:nil];
    }
#pragma clang diagnostic pop
    
    [super reloadData];
}

//设置完成之后需要对Cell的Model提取设置一些东西
-(void) registerCellClassForcellModels
{
    if (self.isSectionData) {
        for (HFTableViewSectionModel *sectionModel in self.dataSourceModels) {
            for (HFTableViewCellModel *cellModel in sectionModel.cellModels) {
                [self registercellModel:cellModel];
            }
        }
    }
    else{
        for (HFTableViewCellModel *cellModel in self.dataSourceModels) {
            [self registercellModel:cellModel];
        }
    }
    
}

-(void)registercellModel:(HFTableViewCellModel *)cellModel
{
    
    if(cellModel.useXib)
    {
        UINib *nib = [UINib nibWithNibName:cellModel.tablViewCellClassName bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:cellModel.cellIdentifier];
    }
    else
    {
        [self registerClass:NSClassFromString(cellModel.tablViewCellClassName) forCellReuseIdentifier:cellModel.cellIdentifier];
    }
}

-(void)setDelegate:(id<UITableViewDelegate>)delegate
{
     self.customDelegate = (id)delegate;
}

-(void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    self.customDataSource = dataSource;
}


#pragma
/**
 *  把数据转化成符合格式的cellModel。
 *  如果数据中对应多种cell 样式，需按需求设置对应的cellClassName 再使用setCellModelsForObjs: isAddmore:
 *  @param dataSource  数据原型
 *  @param className  cell 的className
 *  @param addMore    yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void) setCellModelsForDataSource:(NSArray *)dataSource cellClassName:(NSString *)className  isAddmore:(BOOL)addMore
{
    NSMutableArray *cellModels = [NSMutableArray array];
    [self registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
    
    
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
        for (id subModel in dataSource) {
            HFTableViewCustomCellModel*cellModel = [[HFTableViewCustomCellModel alloc] init];
            cellModel.valueData = subModel;
            cellModel.tablViewCellClassName = className;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            cellModel.cellAction = @selector(tableViewDidSelectCellModel:);
#pragma clang diagnostic pop
            [cellModels addObject:cellModel];
        }
        
    }
    else{
        for (NSArray *sectionArray in dataSource) {
            HFTableViewSectionModel *sectionModel = [[HFTableViewSectionModel alloc] init];
            NSMutableArray *subcellModels = [NSMutableArray array];
            
            for (id subModel in sectionArray) {
                HFTableViewCustomCellModel*cellModel = [[HFTableViewCustomCellModel alloc] init];
                cellModel.valueData = subModel;
                cellModel.tablViewCellClassName = className;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                cellModel.cellAction = @selector(tableViewDidSelectCellModel:);
#pragma clang diagnostic pop
                [subcellModels addObject:cellModel];
                
            }
            sectionModel.cellModels = subcellModels;
            [cellModels addObject:sectionModel];
        }
        
    }
    if(addMore)
    {
        if(self.dataSourceModels == nil)
        {
            [self setupData];
        }
        [self.dataSourceModels addObjectsFromArray:cellModels];
    }
    else
    {
        self.dataSourceModels = cellModels;
    }
    //
    //这种设置方式不需要再提取注册cell
    [self reloadData];
    
}

/**
 *  自己转换成cellModel后进行设置
 *
 *  @param cellModel cellModel
 *  @param addMore yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void) setCellModelsForModels:(NSArray *)cellModels  isAddmore:(BOOL)addMore
{
    if(addMore)
    {
        if(self.dataSourceModels == nil)
        {
            [self setupData];
        }
        [self.dataSourceModels addObjectsFromArray:cellModels];
    }
    else
    {
        self.dataSourceModels = [cellModels mutableCopy];
    }
    
    [self  registerCellClassForcellModels];
    [self reloadData];
}

#pragma mark UITableViwDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self. isSectionData) {
        HFTableViewSectionModel *sectionModel = self.dataSourceModels[section];
        return sectionModel.headHeigth;
    }
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (self. isSectionData) {
        HFTableViewSectionModel *sectionModel = self.dataSourceModels[section];
        return sectionModel.footerHeigth;
    }
    
    return 0.1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self. isSectionData) {
        HFTableViewSectionModel *sectionModel = self.dataSourceModels[section];
        return sectionModel.headTitle;
    }
    
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self. isSectionData) {
        HFTableViewSectionModel *sectionModel = self.dataSourceModels[section];
        return sectionModel.headView;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self. isSectionData) {
        return self.dataSourceModels.count;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self. isSectionData) {
        HFTableViewSectionModel *sectionModel = self.dataSourceModels[section];
        return [sectionModel.cellModels count];
    }
    else{
        return self.dataSourceModels.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HFTableViewCellModel *cellModel = [self  cellModelForIndexPath:indexPath];
    
    if([[cellModel class] isSubclassOfClass:[HFTableViewCustomCellModel class]])
    {
        
        if(cellModel.cellHeigth  > 0)
        {
            return cellModel.cellHeigth;
        }
        else {
        return [tableView fd_heightForCellWithIdentifier:cellModel.cellIdentifier
                                            cacheByIndexPath:indexPath
                                               configuration:^(id cell) {
                                                   [cell bindData:cellModel];
                                               }];
        }
        

    }
    else if([cellModel isKindOfClass:[HFTableViewFormCellModel class]])
    {
        return cellModel.cellHeigth;
    }
    
    
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFTableViewCellModel *cellModel = [self cellModelForIndexPath:indexPath];
    HFTableViewCell *cell = [sender dequeueReusableCellWithIdentifier:cellModel.cellIdentifier forIndexPath:indexPath];
    [cell bindData:cellModel];
  
    if([self.customDelegate respondsToSelector:@selector(tableView:configCell:indexPath:)])
    {
        [self.customDelegate tableView:sender configCell:cell indexPath:indexPath];
    }
    
    if(cellModel.configCellBlock)
    {
        cellModel.configCellBlock(cell);
    }
    return cell;
}

- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [sender deselectRowAtIndexPath:indexPath animated:YES];
    
    //delegate 需要自行处理
    if([self.customDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
    {
        [self.customDelegate tableView:sender didSelectRowAtIndexPath:indexPath];
        
        return;
    }
    
    HFTableViewCellModel *cellModel = [self cellModelForIndexPath:indexPath];
    if(((HFTableViewFormCellModel *)cellModel).cellAction){
        if([self.customDelegate respondsToSelector:((HFTableViewFormCellModel *)cellModel).cellAction])
        {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.customDelegate performSelector:((HFTableViewFormCellModel *)cellModel).cellAction withObject:cellModel];
        }
    }
    else if(((HFTableViewFormCellModel *)cellModel).pushToClass)
    {
        UIViewController *controller = [[[((HFTableViewFormCellModel *)cellModel) pushToClass] alloc] init];
        [self.viewController.navigationController pushViewController:controller animated:YES];
    }

}


#pragma mark -- reload
-(void)reloadSectionForSectionIndex:(NSUInteger )sectionIndex withRowAnimation:(UITableViewRowAnimation)animation
{
    if(self.isSectionData && sectionIndex < self.dataSourceModels.count)
    {
        HFTableViewSectionModel *sectionModel = self.dataSourceModels[sectionIndex];
        for (HFTableViewCellModel *cellModel in sectionModel.cellModels) {
            [self registercellModel:cellModel];
        }
        [self reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];

    }
}
-(void)reloadSectionForSectionKey:(NSString *)sectionKey withRowAnimation:(UITableViewRowAnimation)animation
{
    if(self.isSectionData && sectionKey.length > 0)
    {
        HFTableViewSectionModel *sectionModel = [self sectionModelForKey:sectionKey];
        for (HFTableViewCellModel *cellModel in sectionModel.cellModels) {
            [self registercellModel:cellModel];
        }
        [self reloadSections:[NSIndexSet indexSetWithIndex:[self.dataSourceModels indexOfObject:sectionModel]] withRowAnimation:animation];
  
    }
}

-(void)replaceSection:(HFTableViewSectionModel *)sectionModel sectionIndex:(NSUInteger)sectionIndex withRowAnimation:(UITableViewRowAnimation)animation
{
    if(self.isSectionData && sectionIndex < self.dataSourceModels.count)
    {
        HFTableViewSectionModel *oldsectionModel = self.dataSourceModels[sectionIndex];
        if(oldsectionModel)
        {
            NSInteger sectionIndex = [self.dataSourceModels indexOfObject:oldsectionModel];
            [self.dataSourceModels replaceObjectAtIndex:sectionIndex withObject:sectionModel];
            [self reloadSectionForSectionIndex:sectionIndex withRowAnimation:animation];
        }
    }
}
-(void)replaceSection:(HFTableViewSectionModel *)sectionModel sectionKey:(NSString *)sectionKey withRowAnimation:(UITableViewRowAnimation)animation
{
    if(self.isSectionData && sectionKey.length > 0)
    {
        HFTableViewSectionModel *oldsectionModel = [self sectionModelForKey:sectionKey];
        if(oldsectionModel)
        {
            NSInteger sectionIndex = [self.dataSourceModels indexOfObject:oldsectionModel];
            [self.dataSourceModels replaceObjectAtIndex:sectionIndex withObject:sectionModel];
            [self reloadSectionForSectionIndex:sectionIndex withRowAnimation:animation];
        }
    }
}

-(void)reloadCellForSectionIndex:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation
{
     if(indexPath)
     {
         HFTableViewCellModel *cellModel = [self cellModelForIndexPath:indexPath];
         if(cellModel)
         {
             [self registercellModel:cellModel];
         }
         [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
     }

}
-(void)reloadCellForSectionKey:(NSString *)cellModelKey withRowAnimation:(UITableViewRowAnimation)animation
{
    if(cellModelKey.length > 0)
    {
        NSIndexPath *indexPath = [self cellIndexForModelKey:cellModelKey];
        [self reloadCellForSectionIndex:indexPath withRowAnimation:animation];
    }
}

-(void)replaceCellModel:(HFTableViewCellModel *)cellModel cellIndex:(NSIndexPath *)indexpath withRowAnimation:(UITableViewRowAnimation)animation
{
    if(cellModel && indexpath && indexpath.section < self.dataSourceModels.count)
    {
        HFTableViewSectionModel *section = self.dataSourceModels[indexpath.section];
        [section.cellModels replaceObjectAtIndex:indexpath.row withObject:cellModel];
        
        [self registercellModel:cellModel];
        [self reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:animation];
        
    }
}
-(void)replaceCellModel:(HFTableViewCellModel *)cellModel cellModelKey:(NSString *)cellModelKey withRowAnimation:(UITableViewRowAnimation)animation
{
    if(cellModel && cellModelKey.length > 0)
    {
        NSIndexPath *indexPath = [self cellIndexForModelKey:cellModelKey];
        
        HFTableViewSectionModel *section = self.dataSourceModels[indexPath.section];
        [section.cellModels replaceObjectAtIndex:indexPath.row withObject:cellModel];
        
        [self registercellModel:cellModel];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    
    }
}



#pragma mark 数据提取
//设置的数据是否是Section模式
-(BOOL)isSectionData
{
    if(self.dataSourceModels.count >0)
    {
        if([[self.dataSourceModels firstObject] isKindOfClass:[HFTableViewSectionModel class]])
        {
            return YES;
        }
    }
    return NO;
}
-(HFTableViewCellModel *)cellModelForIndexPath:(NSIndexPath *)indexPath
{
    HFTableViewCellModel *cellModel = nil;
    if (self.isSectionData) {
        cellModel = ((HFTableViewSectionModel *)self.dataSourceModels[indexPath.section]).cellModels[indexPath.row];
    }
    else{
        cellModel =self.dataSourceModels[indexPath.row];
    }
    return cellModel;
}

-(HFTableViewCellModel *)cellModelForModelKey:(NSString *)modelKey
{
    HFTableViewCellModel *cellModel = nil;
    
    if(self.isSectionData)
    {
        for (HFTableViewSectionModel *sectionModel in self.dataSourceModels) {
            for (HFTableViewCellModel *subModel  in sectionModel.cellModels) {
                    if([subModel.modelKey isEqualToString:modelKey])
                    {
                        return subModel;
                    }
            }
        }
    }
    else
    {
        for (HFTableViewCellModel *subModel  in self.dataSourceModels) {
        
                if([subModel.modelKey isEqualToString:modelKey])
                {
                    return subModel;
                }
        }
    }
    return cellModel;
}

-(HFTableViewSectionModel *)sectionModelForKey:(NSString *)sectionKey
{
    
    if(self.isSectionData && sectionKey.length > 0)
    {
        for (HFTableViewSectionModel *sectionModel in self.dataSourceModels) {
            
            if([sectionModel.sectionKey isEqualToString:sectionKey])
            {
                return sectionModel;
            }
            
        }
    }
    
    return nil;
}

-(NSIndexPath *)cellIndexForModelKey:(NSString *)modelKey
{
    NSIndexPath *indexpath = nil;
    int sectionIndex = 0;
    int rowIndex = 0;
    if(self.isSectionData)
    {
        for (HFTableViewSectionModel *sectionModel in self.dataSourceModels) {
            rowIndex = 0;
            for (HFTableViewCellModel *subModel  in sectionModel.cellModels) {
                    if([subModel.modelKey isEqualToString:modelKey])
                    {
                        indexpath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
                    }
                rowIndex ++;
            }
            
            sectionIndex ++;
        }
        
    }
    else
    {
        for (HFTableViewCellModel *subModel  in self.dataSourceModels) {
                if([subModel.modelKey isEqualToString:modelKey])
                {
                    indexpath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
                }
            rowIndex++;
        }
    }
    
    return indexpath;
}
-(NSInteger)sectionIndexForModelKey:(NSString *)sectionKey
{
    HFTableViewSectionModel *sectionModel = [self sectionModelForKey:sectionKey];
    if(sectionModel)
    {
        return [self.dataSourceModels indexOfObject:sectionModel];
    }
    return NSNotFound;
}

#pragma mark -- 事件监听
-(void)openKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)closeKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark -- 键盘弹起 & 收起
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float height = rect.size.height;
    
    [self setContentInset:UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, height, self.contentInset.right)];
    [self scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    int section = 0;
    int row =0;
    BOOL find = NO;
    if(self.isSectionData)
    {
        
        for (section =0 ;section<self.dataSourceModels.count;section++) {
            HFTableViewSectionModel *sectionModel =self.dataSourceModels[section];
            for (row =0 ;row < sectionModel.cellModels.count;row++) {
                HFTableViewCell *obj = sectionModel.cellModels[row];
                if([obj isFirstResponder])
                {
                    find = YES;
                    break;
                }
            }
            if(find)break;
        }
        
    }
    else{
        for (row =0 ;row<self.dataSourceModels.count;row++) {
            HFTableViewCell *obj = self.dataSourceModels[row];
            if([obj isFirstResponder])
            {
                find = YES;
                break;
            }
        }
        
    }
    
    if(find)
    {
        
        float duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [UIView commitAnimations];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification{

    [self setContentInset:UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, 0, self.contentInset.right)];
}


@end
