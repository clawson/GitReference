//
//  GRViewController.m
//  GitReference
//
//  Created by Dan Clawson on 4/1/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GRViewController.h"

static CGFloat heightForLabel = 20;
static CGFloat margin = 10;
static NSString * const Command = @"command";
static NSString * const Reference = @"reference";

@interface GRViewController ()

@end

@implementation GRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        // customize here...
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create and add a scroll view which consumes the full screen minus the status bar
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:
            CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    [self.view addSubview:scrollView];

    CGFloat topMargin = 20;
    CGFloat widthMinusMargin = self.view.frame.size.width - 2 * margin;
    
    // create the title and set its properties
    UILabel *title = [[UILabel alloc] initWithFrame:
            CGRectMake(margin, topMargin, widthMinusMargin, heightForLabel)];
    title.font = [UIFont boldSystemFontOfSize:20];
    title.text = @"GitReference";
    [scrollView addSubview:title];
    
    CGFloat top = topMargin + heightForLabel + margin * 2;
    
    // loop through the commands and set labels for each command and reference
    for (NSDictionary *gitCommand in [self gitCommands]) {
        
        NSString *command = gitCommand[Command];
        NSString *reference = gitCommand[Reference];
        
        UILabel *gitCommand = [[UILabel alloc] initWithFrame:
                CGRectMake(margin, top, widthMinusMargin, heightForLabel)];
        gitCommand.font = [UIFont boldSystemFontOfSize:17];
        gitCommand.text = command;
        [scrollView addSubview:gitCommand];
        
        top += (heightForLabel + margin);
        
        CGFloat heightForReference = [self heightOfReferenceString:reference];
        
        UILabel *gitReference = [[UILabel alloc] initWithFrame:
                CGRectMake(margin, top, widthMinusMargin, heightForReference)];
        gitReference.numberOfLines = 0;
        gitReference.font = [UIFont systemFontOfSize:15];
        gitReference.text = reference;
        [scrollView addSubview:gitReference];
        
        top += (heightForReference + margin * 2);
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, top);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Copied from the given Gist
- (NSArray *)gitCommands {
    
    return @[@{Command: @"git status", Reference: @": shows changed files"},
             @{Command: @"git diff", Reference: @": shows actual changes"},
             @{Command: @"git add .", Reference: @": adds changed files to the commit"},
             @{Command: @"git commit -m \"notes\"", Reference: @": commits the changes"},
             @{Command: @"git push origin _branch_", Reference: @": pushes commits to branch named _branch_"},
             @{Command: @"git log", Reference: @": displays progress log"},
             @{Command: @"git comment --amend", Reference: @": re-enter last commit message"}
             ];
    
}

// Copied from the given Gist
- (CGFloat)heightOfReferenceString:(NSString *)reference {
    
    CGRect bounding = [reference boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                              context:nil];
    
    return bounding.size.height;
    
}

@end
