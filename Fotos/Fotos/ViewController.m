//
//  ViewController.m
//  Fotos
//
//  Created by Daniel Arndt Alves on 3/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *fotoOriginal;
@property (weak, nonatomic) IBOutlet UIImageView *fotoRecortada;

// Tela de seleção de fotos
@property (strong, nonatomic) UIImagePickerController *telaFotos;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.telaFotos = [UIImagePickerController new];
    self.telaFotos.allowsEditing = YES;
    self.telaFotos.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)abrirAlbum:(UIButton *)sender {
    self.telaFotos.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.telaFotos animated:YES completion:nil];
}

- (IBAction)abrirCamera:(UIButton *)sender {
    // Existe camera?
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.telaFotos.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.telaFotos animated:YES completion:nil];
    }
    else {
        [[[UIAlertView alloc]initWithTitle:@"Ops..." message:@"Seu device não tem câmera..." delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles:nil] show];
    }
}

// Metodo invocado quando o usuário seleciona uma das fotos
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // Voltar para a tela anterior
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Recuperando a foto original selecionada que veio pelo dicionário info
    self.fotoOriginal.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // Recuperando a foto recortada selecionada que veio pelo dicionário info
    self.fotoRecortada.image = [info objectForKey:UIImagePickerControllerEditedImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    // Voltar para a tela anterior
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)salvarFoto:(UIButton *)sender {
    UIActionSheet *menuInferior = [[UIActionSheet alloc] initWithTitle:@"Qual foto deseja salvar?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Nenhuma foto" otherButtonTitles:@"Foto Original", @"Foto Recortada", nil];
    [menuInferior showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"Index 0");
            // Destructive
            break;
        case 1:
            NSLog(@"Index 1");
            UIImageWriteToSavedPhotosAlbum(self.fotoOriginal.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            break;
        case 2:
            NSLog(@"Index 2");
             UIImageWriteToSavedPhotosAlbum(self.fotoRecortada.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            break;
            
        default:
            break;
    }
}

- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    if (error) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Erro ao salvar foto..." delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Foto salva com sucesso" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
    
    
}

@end
