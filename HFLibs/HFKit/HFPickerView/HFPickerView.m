//
//  HFPickerView.m
//  HFKitDemo
//
//  Created by helfy on 16/3/18.
//  Copyright © 2016年 helfy. All rights reserved.
//

#import "HFPickerView.h"
#import "Masonry/Masonry.h"

#define kContentHeight 261  //216 + 45

@interface HFPickerView()
@property(nonatomic,strong) UIView *picker;
@property(nonatomic,assign) HFPickerViewType pickerType;
@property(nonatomic,assign) NSInteger chooseIndex;
@end


@implementation HFPickerView

- (id)initWithType:(HFPickerViewType)type {
    self = [super init];
    if(self)
    {
        
        self.pickerType = type;
        _contentView = [UIView new];
        [self addSubview:self.contentView];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(kContentHeight));
            make.bottom.equalTo(self).offset(kContentHeight);
            make.left.right.equalTo(self);
            
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done)];
        tap.delegate = (id)self;
        [self addGestureRecognizer:tap];
        self.contentView.backgroundColor = [UIColor colorWithRed:240 green:242 blue:242 alpha:1];
        _toolBar =[UIToolbar new];
        UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
        [doneBtn setTintColor:[UIColor blueColor]];
        UIBarButtonItem *spaceBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.toolBar.items=@[spaceBtn,doneBtn];
        [self.contentView addSubview:self.toolBar];
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@(45));
            
        }];
        
        
    }
    return self;
}

- (void)setupPickerView {
    
    switch (self.pickerType) {
        case HFPickerViewTypeDate:
        {
            UIDatePicker *pickerView = [[UIDatePicker alloc] init];
            pickerView.datePickerMode = UIDatePickerModeDate;
            if( self.defaultValue)
            {
                pickerView.date = self.defaultValue;
            }
            
            if(self.minimumDate)
            {
                pickerView.minimumDate = self.minimumDate;
            }
            if(self.maximumDate)
            {
                pickerView.maximumDate = self.maximumDate;
            }
            
            self.picker=pickerView;
        }
            break;
        case HFPickerViewTypeTime:
        {
            UIDatePicker *pickerView = [[UIDatePicker alloc] init];
            pickerView.datePickerMode = UIDatePickerModeTime;
            if( self.defaultValue)
            {
                pickerView.date = self.defaultValue;
            }
            if(self.minimumDate)
            {
                pickerView.minimumDate = self.minimumDate;
            }
            if(self.maximumDate)
            {
                pickerView.maximumDate = self.maximumDate;
            }
            self.picker=pickerView;
        }
            break;
        case HFPickerViewTypeDateAndTime:
        {
            UIDatePicker *pickerView = [[UIDatePicker alloc] init];
            pickerView.datePickerMode = UIDatePickerModeDateAndTime;
            if( self.defaultValue)
            {
                pickerView.date = self.defaultValue;
            }
            if(self.minimumDate)
            {
                pickerView.minimumDate = self.minimumDate;
            }
            if(self.maximumDate)
            {
                pickerView.maximumDate = self.maximumDate;
            }
            self.picker=pickerView;
        }
            break;
        case HFPickerViewTypeCustomData:
        {
            UIPickerView *pickerView = [UIPickerView new];
            pickerView.dataSource = (id)self;
            pickerView.delegate = (id)self;
            
            if( self.defaultValue)
            {
                self.chooseIndex =(int)[self.dataSourceArrry indexOfObject:self.defaultValue];
                [pickerView selectRow:self.chooseIndex inComponent:0 animated:NO];
            }
            
            self.picker=pickerView;
        }
            break;
        case HFPickerViewTypeNone:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)done {
    if(self.changeBlock)
    {
        
        id chooseValue=nil;
        switch (self.pickerType)
        {
            case HFPickerViewTypeDate:
            case HFPickerViewTypeTime:
            case HFPickerViewTypeDateAndTime:
            {
                chooseValue = ((UIDatePicker *)self.picker).date;
            }
                break;
            case HFPickerViewTypeCustomData:
            {
                
                
                chooseValue= self.dataSourceArrry[self.chooseIndex];
            }
                break;
            default:
            {
                
            }
        }
        self.changeBlock(chooseValue);
    }
    [self cancel];
}

- (void)cancel {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kContentHeight));
        make.bottom.equalTo(self).offset(kContentHeight);
        make.left.right.equalTo(self);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor clearColor];
        [self.contentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view {
    [self setupPickerView];
    [self.contentView addSubview:self.picker];
    self.picker.backgroundColor = [UIColor clearColor];
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolBar.mas_bottom).priorityLow();
        make.bottom.equalTo(self.contentView).priorityLow();
        make.left.right.equalTo(self.contentView);
        //        make.height.equalTo(200);
    }];
    [view addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [self.contentView layoutIfNeeded];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kContentHeight));
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        
    }];
    [UIView beginAnimations:nil context:nil];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self.contentView layoutIfNeeded];
    [UIView commitAnimations];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (CGRectContainsPoint(self.contentView.frame, [touch locationInView:self.contentView])) {
        return NO;
    }
    return YES;
}

#pragma mark -
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  self.dataSourceArrry.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.dataSourceArrry[row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.chooseIndex = (int)row;
}

@end
