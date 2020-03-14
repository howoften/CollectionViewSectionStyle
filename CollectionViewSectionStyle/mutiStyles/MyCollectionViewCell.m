//
//  CollectionViewCell.m
//  JJCollectionViewRoundFlowLayout
//
//  Created by jiajie on 2019/10/30.
//  
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell()

@property (strong, nonatomic,readwrite) UILabel *myLabel;

@end

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    _myLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.translatesAutoresizingMaskIntoConstraints = NO;

        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        
        label;
    });
    
    [self initLayout];
    
    [self setBackgroundColor:[UIColor colorWithRed:250/255.0 green:185/255.0 blue:105/255.0 alpha:1.0]];
}


- (void)initLayout{
    
    UIView *view = _myLabel;
    
    UIView *superview = self;
    [superview addConstraints:@[

       //tableview constraints
       [NSLayoutConstraint constraintWithItem:view
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:superview
                                    attribute:NSLayoutAttributeTop
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:view
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:superview
                                    attribute:NSLayoutAttributeLeft
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:view
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:superview
                                    attribute:NSLayoutAttributeBottom
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:view
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:superview
                                    attribute:NSLayoutAttributeRight
                                   multiplier:1
                                     constant:0],

    ]];
}

@end
