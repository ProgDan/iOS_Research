//
//  ViewController.m
//  MonitorExterno
//
//  Created by Daniel Arndt Alves on 3/29/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)exibirFotoClicado:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)exibirFotoClicado:(UIButton *)sender {
    UIImagePickerController *selecaoImagem = [UIImagePickerController new];
    selecaoImagem.delegate = self;
    
    [self presentViewController:selecaoImagem animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *imagemSelecionada = info[UIImagePickerControllerOriginalImage];
    
    // Recuperar uma referência ao AppDelegate
    AppDelegate *delegateDaAplicacao = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegateDaAplicacao.foto.image = imagemSelecionada;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
