//
//  RemoteHostsAction.m
//  RemoteHosts
//
//  Created by Rob McBroom on 12/24/09.
//

#import "RemoteHostsAction.h"

@implementation QSRemoteHostsAction

- (int *)launchConnection:(NSString *)SSHinetloc
{
    /*
     This is a convenience method for the three actions below.
     The process of connecting is identical for all three, once the location
     string has ben sorted out.
    */
    NSURL *url = [NSURL URLWithString:SSHinetloc];
    if (url)
        [[NSWorkspace sharedWorkspace] openURL:url];
    else
        NSLog(@"error with url: %@", SSHinetloc);
    
    return nil;
}

- (QSObject *)connectAsDefault:(QSObject *)dObject
{
    // launch SSH with system defaults
    // equivalent to running `ssh hostname` on the command-line
    QSObject *result;
    NSString *dWithSSH;
    
    dWithSSH = [NSString stringWithFormat:@"ssh://%@",[dObject stringValue]];
    
    [self launchConnection:dWithSSH];
    
    return nil;
}

- (QSObject *)connectAsRoot:(QSObject *)dObject
{
    // launch SSH with a username of "root"
    // equivalent to running `ssh -l root hostname` on the command-line
    QSObject *result;
    NSString *dWithSSH;
    
    dWithSSH = [NSString stringWithFormat:@"ssh://root@%@",[dObject stringValue]];
    
    [self launchConnection:dWithSSH];
    
    return nil;
}

- (QSObject *)connectAsUser:(QSObject *)dObject withUserName:(QSObject *)userName
{
    // launch SSH with a user provided username
    // equivalent to running `ssh -l username hostname` on the command-line
    QSObject *result;
    NSString *dWithSSH;
    
    dWithSSH = [NSString stringWithFormat:@"ssh://%@@%@",[userName stringValue],[dObject stringValue]];
    
    [self launchConnection:dWithSSH];
    
    return nil;
}

@end
