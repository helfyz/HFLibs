//
//  HFDCustomInputTableViewCell.h
//  HFKitDemo
//
//  Created by helfy on 16/3/21.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTableViewCellFormModel.h"
@interface HFDCustomInputTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (strong, nonatomic) HFTableViewCellFormModel *cellModel;


@property (weak, nonatomic) IBOutlet UILabel *titleLbale;

@property (weak, nonatomic) IBOutlet UITextField *inputTextFiled;
@end
