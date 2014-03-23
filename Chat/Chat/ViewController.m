//
//  ViewController.m
//  Chat
//
//  Created by Daniel Arndt Alves on 3/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *campoApelido;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Chamado antes da transição acontecer
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ChatViewController *telaDestino = segue.destinationViewController;
    telaDestino.apelido = self.campoApelido.text;
    
    self.campoApelido.text = nil;
    [self.campoApelido resignFirstResponder];
}

@end
