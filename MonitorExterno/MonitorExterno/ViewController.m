//
//  ViewController.m
//  MonitorExterno
//
//  Created by Eduardo Lima on 3/29/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)exibirFotoClicado:(id)sender;

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

- (IBAction)exibirFotoClicado:(id)sender {
    
    UIImagePickerController *selecaoImagem = [[UIImagePickerController alloc] init];
    
    selecaoImagem.delegate = self;
    
    [self presentViewController:selecaoImagem animated:YES completion:nil];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *imagemSelecionada = info[UIImagePickerControllerOriginalImage];
    
    //Recuperar uma referencia ao appDelegate
    AppDelegate *delegateDaAplicacao = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    delegateDaAplicacao.foto.image = imagemSelecionada;
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}








@end
