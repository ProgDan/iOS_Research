//
//  DetailViewController.m
//  AgendaCompleta
//
//  Created by Daniel Arndt Alves on 2/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UILabel *lblSobrenome;
@property (weak, nonatomic) IBOutlet UILabel *lblTelefone;

- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDictionary *)dicItem
{
    if (_dicItem != dicItem) {
        _dicItem = dicItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.dicItem)
    {
        self.lblNome.text = [self.dicItem valueForKey:@"Nome"];
        self.lblSobrenome.text = [self.dicItem valueForKey:@"Sobrenome"];
        self.lblTelefone.text = [self.dicItem valueForKey:@"Telefone"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
