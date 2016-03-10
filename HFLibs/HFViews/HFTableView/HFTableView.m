//
//  HFTableView.m
//  Project1
//
//  Created by helfy on 16/1/19.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "HFTableView.h"
#import "HFTableCellModel.h"
#import "HFTableSectionModel.h"
#import "HFTableViewCell.h"
#import "HFFormTableCellModel.h"
#import "HFCustomTableCellModel.h"
#import "HFCustomTableViewCell.h"
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
    self.dataSourceObjs = [NSMutableArray array];
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
        for (HFTableSectionModel *sectionObj in self.dataSourceObjs) {
            for (HFTableCellModel *cellModel in sectionObj.cellModels) {
                [self registercellModel:cellModel];
            }
        }
    }
    else{
        for (HFTableCellModel *cellModel in self.dataSourceObjs) {
            [self registercellModel:cellModel];
        }
    }
    
}

-(void)registercellModel:(HFTableCellModel *)cellModel
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
        for (id subObj in dataSource) {
            HFCustomTableCellModel *cellModel = [[HFCustomTableCellModel alloc] init];
            cellModel.valueData = subObj;
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
            HFTableSectionModel *sectionObj = [[HFTableSectionModel alloc] init];
            NSMutableArray *subcellModels = [NSMutableArray array];
            
            for (id subObj in sectionArray) {
                HFCustomTableCellModel *cellModel = [[HFCustomTableCellModel alloc] init];
                cellModel.valueData = subObj;
                cellModel.tablViewCellClassName = className;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                cellModel.cellAction = @selector(tableViewDidSelectCellModel:);
#pragma clang diagnostic pop
                [subcellModels addObject:cellModel];
                
            }
            sectionObj.cellModels = subcellModels;
            [cellModels addObject:sectionObj];
        }
        
    }
    if(addMore)
    {
        if(self.dataSourceObjs == nil)
        {
            [self setupData];
        }
        [self.dataSourceObjs addObjectsFromArray:cellModels];
    }
    else
    {
        self.dataSourceObjs = cellModels;
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
-(void) setCellModelsForObjs:(NSArray *)cellModels  isAddmore:(BOOL)addMore
{
    if(addMore)
    {
        if(self.dataSourceObjs == nil)
        {
            [self setupData];
        }
        [self.dataSourceObjs addObjectsFromArray:cellModels];
    }
    else
    {
        self.dataSourceObjs = [cellModels mutableCopy];
    }
    
    [self  registerCellClassForcellModels];
    [self reloadData];
}

#pragma mark UITableViwDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self. isSectionData) {
        HFTableSectionModel *sectionObj = self.dataSourceObjs[section];
        return sectionObj.headHeigth;
    }
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (self. isSectionData) {
        HFTableSectionModel *sectionObj = self.dataSourceObjs[section];
        return sectionObj.footerHeigth;
    }
    
    return 0.1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self. isSectionData) {
        HFTableSectionModel *sectionObj = self.dataSourceObjs[section];
        return sectionObj.headTitle;
    }
    
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self. isSectionData) {
        HFTableSectionModel *sectionObj = self.dataSourceObjs[section];
        return sectionObj.headView;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self. isSectionData) {
        return self.dataSourceObjs.count;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self. isSectionData) {
        HFTableSectionModel *sectionObj = self.dataSourceObjs[section];
        return [sectionObj.cellModels count];
    }
    else{
        return self.dataSourceObjs.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HFTableCellModel *cellModel = [self  cellModelForIndexPath:indexPath];
    
    if([[cellModel class] isSubclassOfClass:[HFCustomTableCellModel class]])
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
    else if([cellModel isKindOfClass:[HFFormTableCellModel class]])
    {
        return cellModel.cellHeigth;
    }
    
    
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFTableCellModel *cellModel = [self cellModelForIndexPath:indexPath];
    HFTableViewCell *cell = [sender dequeueReusableCellWithIdentifier:cellModel.cellIdentifier forIndexPath:indexPath];
    [cell bindData:cellModel];
    
    if([self.customDelegate respondsToSelector:@selector(tableView:configCell:indexPath:)])
    {
        [self.customDelegate tableView:sender configCell:cell indexPath:indexPath];
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
    
    HFTableCellModel *cellModel = [self cellModelForIndexPath:indexPath];
    if(((HFFormTableCellModel *)cellModel).cellAction){
        if([self.customDelegate respondsToSelector:((HFFormTableCellModel *)cellModel).cellAction])
        {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.customDelegate performSelector:((HFFormTableCellModel *)cellModel).cellAction withObject:cellModel];
        }
    }
    else if(((HFFormTableCellModel *)cellModel).pushToClass)
    {
        UIViewController *controller = [[[((HFFormTableCellModel *)cellModel) pushToClass] alloc] init];
        [self.viewController.navigationController pushViewController:controller animated:YES];
    }
  
    
    
}


#pragma mark --
-(void)reloadSectionForSectionIndex:(NSUInteger )sectionIndex withRowAnimation:(UITableViewRowAnimation)animation
{
    if(self.isSectionData && sectionIndex < self.dataSourceObjs.count)
    {
        HFTableSectionModel *sectionObj = self.dataSourceObjs[sectionIndex];
        for (HFTableCellModel *cellModel in sectionObj.cellModels) {
            [self registercellModel:cellModel];
        }
        [self reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];

    }
}
-(void)reloadSectionForSectionKey:(NSString *)sectionKey withRowAnimation:(UITableViewRowAnimation)animation
{
    if(self.isSectionData && sectionKey.length > 0)
    {
        HFTableSectionModel *sectionObj = [self sectionObjForKey:sectionKey];
        for (HFTableCellModel *cellModel in sectionObj.cellModels) {
            [self registercellModel:cellModel];
        }
        [self reloadSections:[NSIndexSet indexSetWithIndex:[self.dataSourceObjs indexOfObject:sectionObj]] withRowAnimation:animation];
  
    }
}
-(void)replaceSection:(HFTableSectionModel *)sectionObj sectionIndex:(NSUInteger)sectionIndex withRowAnimation:(UITableViewRowAnimation)animation
{
    if(self.isSectionData && sectionIndex < self.dataSourceObjs.count)
    {
        HFTableSectionModel *oldSectionObj = self.dataSourceObjs[sectionIndex];
        if(oldSectionObj)
        {
            NSInteger sectionIndex = [self.dataSourceObjs indexOfObject:sectionObj];
            [self.dataSourceObjs replaceObjectAtIndex:sectionIndex withObject:sectionObj];
            [self reloadSectionForSectionIndex:sectionIndex withRowAnimation:animation];
        }
    }
}
-(void)replaceSection:(HFTableSectionModel *)sectionObj sectionKey:(NSString *)sectionKey withRowAnimation:(UITableViewRowAnimation)animation
{
    if(self.isSectionData && sectionKey.length > 0)
    {
        HFTableSectionModel *oldSectionObj = [self sectionObjForKey:sectionKey];
        if(oldSectionObj)
        {
            NSInteger sectionIndex = [self.dataSourceObjs indexOfObject:sectionObj];
            [self.dataSourceObjs replaceObjectAtIndex:sectionIndex withObject:sectionObj];
            [self reloadSectionForSectionIndex:sectionIndex withRowAnimation:animation];
        }
    }
}

#pragma mark 数据提取
//设置的数据是否是Section模式
-(BOOL)isSectionData
{
    if(self.dataSourceObjs.count >0)
    {
        if([[self.dataSourceObjs firstObject] isKindOfClass:[HFTableSectionModel class]])
        {
            return YES;
        }
    }
    return NO;
}
-(HFTableCellModel *)cellModelForIndexPath:(NSIndexPath *)indexPath
{
    HFTableCellModel *cellModel = nil;
    if (self.isSectionData) {
        cellModel = ((HFTableSectionModel *)self.dataSourceObjs[indexPath.section]).cellModels[indexPath.row];
    }
    else{
        cellModel =self.dataSourceObjs[indexPath.row];
    }
    return cellModel;
}

-(HFFormTableCellModel *)cellModelForObjKey:(NSString *)objKey
{
    HFFormTableCellModel *cellModel = nil;
    
    if(self.isSectionData)
    {
        for (HFTableSectionModel *sectionObj in self.dataSourceObjs) {
            for (HFTableCellModel *subObj  in sectionObj.cellModels) {
                if([subObj isKindOfClass:[HFFormTableCellModel class]])
                {
                    if([((HFFormTableCellModel *)subObj).modelKey isEqualToString:objKey])
                    {
                        return (HFFormTableCellModel *)subObj;
                    }
                }
            }
        }
        
    }
    else
    {
        for (HFTableCellModel *subObj  in self.dataSourceObjs) {
            
            if([subObj isKindOfClass:[HFFormTableCellModel class]])
            {
                if([((HFFormTableCellModel *)subObj).modelKey isEqualToString:objKey])
                {
                    return (HFFormTableCellModel *)subObj;
                }
            }
        }
    }
    return cellModel;
}

-(HFTableSectionModel *)sectionObjForKey:(NSString *)sectionKey
{
    
    if(self.isSectionData && sectionKey.length > 0)
    {
        for (HFTableSectionModel *sectionObj in self.dataSourceObjs) {
            
            if([sectionObj.sectionKey isEqualToString:sectionKey])
            {
                return sectionObj;
            }
            
        }
    }
    
    return nil;
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
        
        for (section =0 ;section<self.dataSourceObjs.count;section++) {
            NSArray *sectionArray =self.dataSourceObjs[section];
            for (row =0 ;row<sectionArray.count;row++) {
                HFTableViewCell *obj = sectionArray[row];
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
        for (row =0 ;row<self.dataSourceObjs.count;row++) {
            HFTableViewCell *obj = self.dataSourceObjs[row];
            if([obj isFirstResponder])
            {
                find = YES;
                break;
            }
        }
        
    }
    
    if(find)
    {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification{
    [self setContentInset:UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, 0, self.contentInset.right)];
}


@end
