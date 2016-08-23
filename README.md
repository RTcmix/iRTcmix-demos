# iRTcmix-demos
demo Xcode projects for iRTcmix

There are five sub-directories here:

1.  iRTcmix-3.00-basic1
	This is a very bare-bones RTcmix example.  A button plays a single tone.

2.  iRTcmix-3.00-basic2
	A slightly (very slightly) more complex example.  A script schedules
	several random notes, and can be re-triggered by a MAXBANG (if enabled
	by a switch on the interface)

3.  iRTcmix-3.00-basic3
	A very bare-bones example of live audio processing.  A button starts
	a simple PANECHO script.  A 'flush' button is also provided to stop
	the script.

4.  iRTcmix-3.00-demo
	Written by Damon Holzborn, this shows nearlyt all the features of
	iRTcmix-3.00.  Use this as a resource for seeing how to do particular
	things (like play a soundfile or an internal audio buffer, see error
	messages, etc.).

5.  RTcmix
	This is the folder that needs to be included in any Xcode iRTcmix project.


Here is how to create an iRTcmix project:

1.  Start up Xcode, and under File->New select "Project..."

2.  Select a "Single-View Application" (unless you are planning something
	different and you know what you're doing) and hit "Next".

3.  Enter your project name and any other relevant information.  You don't
	need to have "Use Core Data" or the "Tests" selected.  Hit "Next".

4.  Create the project (hit "Create" on the next screen) where you want it
	in your filesystem.

5.  Copy the "RTcmix" folder from the directory with this README.txt file
	somewhere in your new project (I like to put mine in the same folder
	as the "AppDelegate" and "ViewController" files).

6.  Add the "RTcmix" folder to your project by dragging it from your Finder
	to your Xcode project file-listing on the left in the XCcode project
	(I like to put mine under the "Supporting Files" entry).

7.  Copy items if needed, add to groups, etc. and hit "OK".

8.  Select the project in the top left, and click on the "Build Settings"
	tab so you can see all the things Xcode is set to do.  Scroll down
	to the "Linking" section, and find the "Other Linker Flags" entry.

9.  In the second column (under your project name), double-click the
	intersection of that column with the "Other Linker Flags" row and
	add "-lstdc++".

10.  In the "ViewController.h" file, change this:

			#import <UIKit/UIKit.h>

			@interface ViewController : UIViewController

	to this:

			#import <UIKit/UIKit.h>
			#import "RTcmixPlayer.h"

			@interface ViewController : UIViewController <RTcmixPlayerDelegate>

11.  In the "ViewController.m" file, change this:

			@interface ViewController ()

			@end

	to this:

			@interface ViewController ()
			@property (nonatomic, strong)       RTcmixPlayer		*rtcmixManager;
			@end

	and this:

			- (void)viewDidLoad {
			    [super viewDidLoad];
			    // Do any additional setup after loading the view, typically from a nib.
			}
			
	to this:

			- (void)viewDidLoad {
			    [super viewDidLoad];
			    
			    self.rtcmixManager = [RTcmixPlayer sharedManager];
			    self.rtcmixManager.delegate = self;
			    [self.rtcmixManager startAudio];
			}


Now you should be all set to add interface elements and RTcmix stuff!
Do good things!

brad


