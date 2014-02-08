//
//  ViewController.m
//  Galeria
//
//  Created by Daniel Arndt Alves on 2/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *page;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arrImages = [NSArray arrayWithObjects:@"foto1",@"foto2",@"foto3.jpg", nil];
    
    for (int i=0; i<arrImages.count; i++) {
        CGRect frame = CGRectMake(self.scroll.frame.size.width * i, 0, self.scroll.frame.size.width, self.scroll.frame.size.height);
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:frame];
        imgv.image = [UIImage imageNamed:[arrImages objectAtIndex:i]];
        
        imgv.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.scroll addSubview:imgv];
    }
    
    self.scroll.ContentSize = CGSizeMake(self.scroll.frame.size.width * arrImages.count, self.scroll.frame.size.height);
    
    self.page.numberOfPages = [arrImages count];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (IBAction)mudouPagina:(UIPageControl *)sender {
    [self.scroll setContentOffset:CGPointMake(sender.currentPage * self.scroll.frame.size.width, 0) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
