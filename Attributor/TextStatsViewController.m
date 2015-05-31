//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Kiba on 5/30/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

/* Testing Code
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.textToAnalyze = [[NSAttributedString alloc] initWithString: @"Test"
                                                         attributes: @{NSForegroundColorAttributeName: [UIColor greenColor],
                                                                       NSStrokeWidthAttributeName: @-3}];
}
*/
-(void)setTextToAnalyze: (NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];
    [self updateUI];
}

-(void)updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat: @"Colorful Characters: %lu",
        (unsigned long)[[self charactersWithAttibute: NSForegroundColorAttributeName] length]];
    
    self.outlinedCharactersLabel.text = [NSString stringWithFormat: @"Outlined Characters: %lu",
        (unsigned long)[[self charactersWithAttibute: NSStrokeWidthAttributeName] length]];
}

-(NSAttributedString *)charactersWithAttibute: (NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length])
    {
        NSRange range;
        id value = [self.textToAnalyze attribute: attributeName
                                         atIndex: index
                                  effectiveRange: &range];
        
        if (value)
        {
            [characters appendAttributedString: [self.textToAnalyze attributedSubstringFromRange: range]];
            index = (int)range.location + (int)range.length;
        }
        else
        {
            index++;
        }
    }
    
    return characters;
}

@end