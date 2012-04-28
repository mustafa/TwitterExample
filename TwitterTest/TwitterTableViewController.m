//
//  TwitterTableViewController.m
//  TwitterTest
//
//  Created by Mustafa Furniturewala on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Twitter/Twitter.h"
#import "TwitterTableViewController.h"


@interface TwitterTableViewController ()

@end

@implementation TwitterTableViewController

@synthesize tableData = _tableData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"Loading..."];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"manilla" forKey:@"screen_name"];
    [params setObject:@"200" forKey:@"count"];
    [params setObject:@"1" forKey:@"include_entities"];
    [params setObject:@"1" forKey:@"include_rts"];
    
    //  Next, we create an URL that points to the target endpoint
    NSURL *url = 
    [NSURL URLWithString:@"http://api.twitter.com/1/statuses/user_timeline.json"];
    
    //  Now we can create our request.  Note that we are performing a GET request.
    TWRequest *request = [[TWRequest alloc] initWithURL:url 
                                             parameters:params 
                                          requestMethod:TWRequestMethodGET];
    [request performRequestWithHandler:
     ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
         
         if (responseData) {
             //  Use the NSJSONSerialization class to parse the returned JSON
             NSError *jsonError;
             NSArray *timeline = 
             [NSJSONSerialization JSONObjectWithData:responseData 
                                             options:NSJSONReadingMutableLeaves 
                                               error:&jsonError];
             
             if (timeline) {
                 // We have an object that we can parse
                 [self setTableData:timeline];
                 [self reloadInputViews];
                 [[self tableView] reloadData];
                 [[self navigationItem] setTitle:@"Manilla tweets"];
             } 
             else { 
                 // Inspect the contents of jsonError
                 NSLog(@"%@", jsonError);
             }
         }
     }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TwitterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if([self tableData] != nil)
    {
        NSDictionary * item = [[self tableData] objectAtIndex:[indexPath row]];
        NSLog(@"%@",[item valueForKey:@"text"]);
        [[cell textLabel] setText:[item valueForKey:@"text"]];
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
