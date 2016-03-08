//
//  HFTableView.m
//  Project1
//
//  Created by helfy on 16/1/19.
//  Copyright © 2016年 charles. All rights reserved.
//

#import "HFTableView.h"
#import "HFTableCellObj.h"
#import "HFTableSectionObj.h"
#import "HFTableViewCell.h"
#import "HFFormTableCellObj.h"
#import "HFCustomTableCellObj.h"
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

//设置完成之后需要对Cell的Obj提取设置一些东西
-(void) registerCellClassForCellObjs
{
    if (self.isSectionData) {
        for (HFTableSectionObj *sectionObj in self.dataSourceObjs) {
            for (HFTableCellObj *cellObj in sectionObj.cellObjs) {
                
                if(cellObj.useXib)
                {
                    UINib *nib = [UINib nibWithNibName:cellObj.tablViewCellClassName bundle:nil];
                    [self registerNib:nib forCellReuseIdentifier:cellObj.cellIdentifier];
                }
                else{
                    [self registerClass:NSClassFromString(cellObj.tablViewCellClassName) forCellReuseIdentifier:cellObj.cellIdentifier];
                }
            }
        }
    }
    else{
        for (HFTableCellObj *cellObj in self.dataSourceObjs) {
            
            if(cellObj.useXib)
            {
                UINib *nib = [UINib nibWithNibName:cellObj.tablViewCellClassName bundle:nil];
                [self registerNib:nib forCellReuseIdentifier:cellObj.cellIdentifier];
                
            }
            else
            {
                [self registerClass:NSClassFromString(cellObj.tablViewCellClassName) forCellReuseIdentifier:cellObj.cellIdentifier];
            }
        }
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
 *  把数据转化成符合格式的cellObj。
 *  如果数据中对应多种cell 样式，需按需求设置对应的cellClassName 再使用setCellObjsForObjs: isAddmore:
 *  @param dataSource  数据原型
 *  @param className  cell 的className
 *  @param addMore    yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void) setCellObjsForDataSource:(NSArray *)dataSource cellClassName:(NSString *)className  isAddmore:(BOOL)addMore
{
    NSMutableArray *cellObjs = [NSMutableArray array];
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
            HFCustomTableCellObj *cellObj = [[HFCustomTableCellObj alloc] init];
            cellObj.valueData = subObj;
            cellObj.tablViewCellClassName = className;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            cellObj.cellAction = @selector(tableViewDidSelectCellObj:);
#pragma clang diagnostic pop
            [cellObjs addObject:cellObj];
        }
        
    }
    else{
        for (NSArray *sectionArray in dataSource) {
            HFTableSectionObj *sectionObj = [[HFTableSectionObj alloc] init];
            NSMutableArray *subCellObjs = [NSMutableArray array];
            
            for (id subObj in sectionArray) {
                HFCustomTableCellObj *cellObj = [[HFCustomTableCellObj alloc] init];
                cellObj.valueData = subObj;
                cellObj.tablViewCellClassName = className;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                cellObj.cellAction = @selector(tableViewDidSelectCellObj:);
#pragma clang diagnostic pop
                [subCellObjs addObject:cellObj];
                
            }
            sectionObj.cellObjs = subCellObjs;
            [cellObjs addObject:sectionObj];
        }
        
    }
    if(addMore)
    {
        if(self.dataSourceObjs == nil)
        {
            [self setupData];
        }
        [self.dataSourceObjs addObjectsFromArray:cellObjs];
    }
    else
    {
        self.dataSourceObjs = cellObjs;
    }
    //
    //这种设置方式不需要再提取注册cell
    [self reloadData];
    
}

/**
 *  自己转换成cellObj后进行设置
 *
 *  @param cellObj cellObj
 *  @param addMore yes 数据直接添加到已有数据之后。NO 覆盖
 */
-(void) setCellObjsForObjs:(NSArray *)cellObjs  isAddmore:(BOOL)addMore
{
    if(addMore)
    {
        if(self.dataSourceObjs == nil)
        {
            [self setupData];
        }
        [self.dataSourceObjs addObjectsFromArray:cellObjs];
    }
    else
    {
        self.dataSourceObjs = [cellObjs mutableCopy];
    }
    
    [self  registerCellClassForCellObjs];
    [self reloadData];
}

#pragma mark UITableViwDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self. isSectionData) {
        HFTableSectionObj *sectionObj = self.dataSourceObjs[section];
        return sectionObj.headHeigth;
    }
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (self. isSectionData) {
        HFTableSectionObj *sectionObj = self.dataSourceObjs[section];
        return sectionObj.footerHeigth;
    }
    
    return 0.1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self. isSectionData) {
        HFTableSectionObj *sectionObj = self.dataSourceObjs[section];
        return sectionObj.title;
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
        HFTableSectionObj *sectionObj = self.dataSourceObjs[section];
        return [sectionObj.cellObjs count];
    }
    else{
        return self.dataSourceObjs.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HFTableCellObj *cellObj = [self  cellObjForIndexPath:indexPath];
    
    if([[cellObj class] isSubclassOfClass:[HFCustomTableCellObj class]])
    {
        
        if(cellObj.cellHeigth  > 0)
        {
            return cellObj.cellHeigth;
        }
        else {
        return [tableView fd_heightForCellWithIdentifier:cellObj.cellIdentifier
                                            cacheByIndexPath:indexPath
                                               configuration:^(id cell) {
                                                   [cell bindData:cellObj];
                                               }];
        }
        

    }
    else if([cellObj isKindOfClass:[HFFormTableCellObj class]])
    {
        return cellObj.cellHeigth;
    }
    
    
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFTableCellObj *cellObj = [self cellObjForIndexPath:indexPath];
    HFTableViewCell *cell = [sender dequeueReusableCellWithIdentifier:cellObj.cellIdentifier forIndexPath:indexPath];
    [cell bindData:cellObj];
    
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
    
    HFTableCellObj *cellObj = [self cellObjForIndexPath:indexPath];
    if(((HFFormTableCellObj *)cellObj).cellAction){
        if([self.customDelegate respondsToSelector:((HFFormTableCellObj *)cellObj).cellAction])
        {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.customDelegate performSelector:((HFFormTableCellObj *)cellObj).cellAction withObject:cellObj];
        }
    }
    else if(((HFFormTableCellObj *)cellObj).pushToClass)
    {
        UIViewController *controller = [[[((HFFormTableCellObj *)cellObj) pushToClass] alloc] init];
        [self.viewController.navigationController pushViewController:controller animated:YES];
    }
  
    
    
}

#pragma mark 数据提取
//设置的数据是否是Section模式
-(BOOL)isSectionData
{
    if(self.dataSourceObjs.count >0)
    {
        if([[self.dataSourceObjs firstObject] isKindOfClass:[HFTableSectionObj class]])
        {
            return YES;
        }
    }
    return NO;
}
-(HFTableCellObj *)cellObjForIndexPath:(NSIndexPath *)indexPath
{
    HFTableCellObj *cellObj = nil;
    if (self.isSectionData) {
        cellObj = ((HFTableSectionObj *)self.dataSourceObjs[indexPath.section]).cellObjs[indexPath.row];
    }
    else{
        cellObj =self.dataSourceObjs[indexPath.row];
    }
    return cellObj;
}

-(HFFormTableCellObj *)cellObjForObjKey:(NSString *)objKey
{
    HFFormTableCellObj *cellObj = nil;
    
    if(self.isSectionData)
    {
        for (HFTableSectionObj *sectionObj in self.dataSourceObjs) {
            for (HFTableCellObj *subObj  in sectionObj.cellObjs) {
                if([subObj isKindOfClass:[HFFormTableCellObj class]])
                {
                    if([((HFFormTableCellObj *)subObj).objKey isEqualToString:objKey])
                    {
                        return (HFFormTableCellObj *)subObj;
                    }
                }
            }
        }
        
    }
    else
    {
        for (HFTableCellObj *subObj  in self.dataSourceObjs) {
            
            if([subObj isKindOfClass:[HFFormTableCellObj class]])
            {
                if([((HFFormTableCellObj *)subObj).objKey isEqualToString:objKey])
                {
                    return (HFFormTableCellObj *)subObj;
                }
            }
        }
    }
    return cellObj;
}

-(HFTableSectionObj *)sectionObjForKey:(NSString *)sectionKey
{
    
    if(self.isSectionData && sectionKey.length > 0)
    {
        for (HFTableSectionObj *sectionObj in self.dataSourceObjs) {
            
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
