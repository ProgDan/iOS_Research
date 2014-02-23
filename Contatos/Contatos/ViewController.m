//
//  ViewController.m
//  Contatos
//
//  Created by Daniel Arndt Alves on 2/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UILabel *lblSobrenome;
@property (weak, nonatomic) IBOutlet UILabel *lblTelefone;

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

- (IBAction)adicionaContato:(UIButton *)sender {
    ABNewPersonViewController *contato = [ABNewPersonViewController new];
    
    contato.newPersonViewDelegate = self;
    
    // Documentação diz que temos que iniciar uma ABNewPersonViewController usando uma Navigation Controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:contato];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)buscaContato:(UIButton *)sender {
    ABPeoplePickerNavigationController *selecionadorDeContato = [ABPeoplePickerNavigationController new];
    
    selecionadorDeContato.peoplePickerDelegate = self;
    
    [self presentViewController:selecionadorDeContato animated:YES completion:nil];
}

- (IBAction)adicionaIai:(UIButton *)sender {
    ABAddressBookRef *addressBook = ABAddressBookCreateWithOptions(nil, nil);
    NSArray *arrPeople = CFBridgingRelease(ABAddressBookCopyPeopleWithName(addressBook, CFBridgingRetain(@"iai")));
    if (arrPeople.count == 0) {
        ABRecordRef contato = ABPersonCreate();
        ABRecordSetValue(contato, kABPersonFirstNameProperty, @"iai", nil);
        ABRecordSetValue(contato, kABPersonLastNameProperty, @"Brasil", nil);
        ABMutableMultiValueRef telefones = ABMultiValueCreateMutable(kABPersonPhoneProperty);
        ABMultiValueAddValueAndLabel(telefones, @"(11) 3322-4455", kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(contato, kABPersonPhoneProperty, telefones, nil);
        
        ABAddressBookAddRecord(addressBook, contato, nil);
        ABAddressBookSave(addressBook, nil);
        
    }
    
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (person) {
        NSString *nome = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        
        [[[UIAlertView alloc] initWithTitle:@"Adicionado" message:nome delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
    }
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{

    NSString *nome, *sobrenome, *telefone;
    
    // pega o nome
    nome = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    self.lblNome.text = nome;
    
    // pega o sobrenome
    sobrenome = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    self.lblSobrenome.text = sobrenome;
    
    // como o telefone tem vários, eu pego a coleção completa
    ABMultiValueRef telefoneRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    // converto os telefones em um array de telefones
    if (ABMultiValueGetCount(telefoneRef)>0) {
        telefone = CFBridgingRelease(ABMultiValueCopyValueAtIndex(telefoneRef, 0));
        self.lblTelefone.text = telefone;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    

    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}

@end
