//
//  ViewController.m
//  Calendario
//
//  Created by Daniel Arndt Alves on 2/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtfDataInicio;
@property (weak, nonatomic) IBOutlet UITextField *txtfDataFim;
@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property(strong, nonatomic) NSArray *arrEventos;

@property(assign, nonatomic) BOOL dataInicio;

@property(strong, nonatomic) NSDate *inicio, *fim;


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

- (IBAction)addEvento:(UIBarButtonItem *)sender {
    // Banco de dados do calendário
    EKEventStore *dbEventos = [EKEventStore new];
    
    [dbEventos requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        EKEvent *evento = [EKEvent eventWithEventStore:dbEventos];
        
        evento.calendar = dbEventos.defaultCalendarForNewEvents;
        
        evento.startDate = [NSDate dateWithTimeIntervalSinceNow:60*3];
        evento.endDate = [NSDate dateWithTimeInterval:60*5 sinceDate:evento.startDate];
        
        evento.allDay = NO;
        
        evento.title = @"Aula no Iai?";
        
        evento.notes = @"Depois do carnaval";
        
        evento.location = @"Alameda Praia de Guaratuba, 503, Salvador, Bahia";
        
        EKAlarm *alarme = [EKAlarm alarmWithRelativeOffset:-60];
        [evento addAlarm:alarme];
        
        [dbEventos saveEvent:evento span:EKSpanThisEvent commit:YES error:nil];

    }];
    
}

- (IBAction)buscarEvento:(UIButton *)sender {
    EKEventStore *dbCalendario = [EKEventStore new];
    
    // cria a consulta
    NSPredicate *consulta = [dbCalendario predicateForEventsWithStartDate:self.inicio endDate:self.fim calendars:[dbCalendario calendarsForEntityType:EKEntityTypeEvent]];
    
    // executa a consulta e guarda os resultados
    self.arrEventos = [dbCalendario eventsMatchingPredicate:consulta];
    
    // carrega os dados da tabela
    [self.tabela reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrEventos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    EKEvent *evento = [self.arrEventos objectAtIndex:indexPath.row];
    cell.textLabel.text = evento.title;
    
    return cell;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.datePicker.backgroundColor = [UIColor grayColor];
    
    if ([textField isEqual:self.txtfDataInicio]) {
        self.dataInicio = YES;
    }
    else {
        self.dataInicio = NO;
    }

    self.datePicker.hidden = NO;

    return NO;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // só fazer alguma coisa se estiver mostrando o date picker
    if (self.datePicker.hidden == NO) {
        // pega um toque
        UITouch *touch = [touches anyObject];
        
        // a localização desse dedo na tela
        CGPoint point = [touch locationInView:self.view];
        
        // verifica se o toque foi realizado na área do picker
        if (!CGRectContainsPoint(self.datePicker.frame, point)) {
            // editando o campo de início
            if (self.dataInicio) {
                self.inicio = self.datePicker.date;
                self.txtfDataInicio.text = [[self.datePicker date] description];
            }
            else {
                self.fim = self.datePicker.date;
                self.txtfDataFim.text = [[self.datePicker date] description];
            }
            
            self.datePicker.hidden = YES;
        }
    }
}

@end
