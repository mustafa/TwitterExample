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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"manilla" forKey:@"screen_name"];
    [params setObject:@"10" forKey:@"count"];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TwitterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSDictionary * item = [[self tableData] objectAtIndex:[indexPath row]];
    NSLog(@"%@",[item valueForKey:@"text"]);
    [[cell textLabel] setText:[item valueForKey:@"text"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
