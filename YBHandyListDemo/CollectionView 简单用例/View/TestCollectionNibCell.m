//
//  TestCollectionNibCell.m
//  YBHandyListDemo
//
//  Created by 迎博 on 2019/6/19.
//  Copyright © 2019 迎博. All rights reserved.
//

#import "TestCollectionNibCell.h"
#import "TestCollectionModel.h"
#import "YBHandyList.h"

@interface TestCollectionNibCell () <YBHCollectionCellProtocol>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation TestCollectionNibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = UIColor.orangeColor;
    self.contentView.layer.cornerRadius = 10;
}

#pragma mark - <YBHCollectionCellProtocol>

- (void)ybhc_setCellConfig:(id<YBHCollectionCellConfig>)config {
    TestCollectionModel *model = config.ybhc_model;
    self.textLabel.text = model.text;
}

+ (CGSize)ybhc_sizeForCellWithConfig:(id<YBHCollectionCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath sectionPack:(nonnull YBHCollectionSection *)sectionPack commonInfo:(nonnull YBHCCommonInfo *)commonInfo {
    // 一排三个
    CGFloat width = commonInfo.maxWidth - sectionPack.minimumInteritemSpacing * 2 - sectionPack.inset.left - sectionPack.inset.right;
    width = floor(width / 3.0);
    return CGSizeMake(width, 80);
}

- (void)ybhc_didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n%@ 被点击了", self.textLabel.text);
}

@end
