//
//  NovaTelaViewController.m
//  Modal
//
//  Created by Daniel Arndt Alves on 2/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "NovaTelaViewController.h"

@interface NovaTelaViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTexto;

@end

@implementation NovaTelaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.lblTexto.text = self.strTexto;
}

- (IBAction)voltar:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
