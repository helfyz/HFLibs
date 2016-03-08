//
//  HFCollectionViewCell.h
//  Project1
//
//  Created by helfy on 16/1/7.
//  Copyright © 2016年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFCollectionCellObj.h"
@interface HFCollectionViewCell : UICollectionViewCell
@property (nonatomic,readonly) HFCollectionCellObj*cellObj;


//重载该函数来设置你的UI
-(void)setupView;

-(void)bindData:(HFCollectionCellObj *)cellObj;

@end
