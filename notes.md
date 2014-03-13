<!-- Image resources -->
[image_double_localize_string]:images/double_localized_string.png "Dobule Localized String size"
[image_run_application_language]:images/run_application_language.png "Running Application in different languages"
#Blocks
###Declaring Blocks

Blocks use a modified function syntax. Like functions, blocks can take arguments and return values. This is the basic format of a declaration:

	<ReturnType>(^<BlockName>)<(Arguments)>

<b><i>ReturnType</i></b> is the variable type returned by a block, if any.<br>
<b><i>BlockName</i></b> is the symbol used for calling the block. The caret (^) is the system-wide indicator preceding the declaration of a block.<br>
<b><i>Arguments</i></b> is an optional list of arguments.<br>

Here are a few examples of block declarations:

	void (^simpleBlock)(void);
	This is a simple block with no return value and no arguments.


	NSString* (^returnsAStringBlock)(void);
	This block returns a string and takes no arguments.

	BOOL (^returnsABoolAndTakesTwoInts) (int first, int second);
	This more complex block takes two integer arguments and returns a Boolean.

These declarations are used for blocks as variables or properties. You use a slightly different form for arguments to methods:

	- (void)method1:(void (^) (void)) aSimpleBlock;
	- (void)method2:(NSString* (^) (void))aBlockReturningAString;
	- (void)method3:(BOOL (^)
           (int first, int second))blockTakesTwoIntsAndReturnsABool;
           
###Using Blocks

You call blocks in much the same way you call functions. For a named block, this works just as you would expect:

	<ReturnVariable> = <BlockName>(<Arguments>);

<b><i>ReturnVariable</i></b> is an optional variable for holding the value returned by a block. If the block has no return value, you omit both ReturnVariable and the equals sign.<br>
<b><i>BlockName</i></b> is the symbol used for calling the block.<br>
<b><i>Arguments</i></b> is an optional list of arguments.<br>

Note that a caret is not used for calling a block. It is used only for declaring and writing.

here is an example of a call:

	simpleBlock();
	NSString* returnString = returnsAStringBlock();
	BOOL isEqual = returnsABoolAndTakesTwoInts(1,2);
	
###Writing Blocks

Writing really has two parts: the return type and argument definitions, and the code for implementing its behavior. This is the definition format:

	^(<ReturnType>)(<Arguments>){<Statements>};

<b><i>ReturnType</i></b> is the variable type returned by a block, if any.<br>
<b><i>Arguments</i></b> is an optional list of arguments.<br>
<b><i>Statements</i></b> is the code implementing the behavior and can be anything you would normally write in Objective-C.

There is no block name in the implementation. Usually, you declare a block and assign it by using the definition. Here are the previous declarations, with sample block definitions:

	void(^simpleBlock)(void) = ^void(void){NSLog(@"simpleBlock called");};

	NSString*(^returnsAStringBlock)(void) = ^(NSString*)(void){return @"Here is a string";};

	BOOL(^returnsABoolAndTakesTwoInts) (int first, int second) = 
	^BOOL(int first, int second){return (first == second);};

Some of the definitions seem a bit verbose, especially all the voids. There are two space savers you can use for defining blocks. <br><i>First</i>, you can omit arguments if there are none. That cuts out a little from the first two block examples.<br><i>Second</i>, the compiler figures out the return type by using the definition. Therefore, the definitions can change to this:

	void(^simpleBlock)(void) = ^{NSLog(@"simpleBlock called");};

	NSString*(^returnsAStringBlock)(void) = ^({return @"Here is a string";};

	BOOL(^returnsABoolAndTakesTwoInts) (int first, int second)=
	^(int first, int second){return first == second};};

Although the examples define and assign a block at the same time, the definition and assignment can happen in different places, even in different objects. This enables you to use blocks as arguments to methods or even class properties, providing lots of power and flexibility.
If you are the user of a class or method, you are not defining or using the block but are writing it:
	
	[anObject aBlockBaseMethod:^{<your code goes here>}];

###Modifable varibale in the block

use 

	__block <varaibe type> <variable name>

###Localisation

In order to generate Base.lproj for localized strings use the following command from within the CarValet folder where all the *.m & *.h file exist


	genstrings -o Base.lproj *.m
	
In order to skip generating string for ome of the tables you could enter the following command:

	getstring -skipTable <table>
	
###Testing the text sizes

In order to double the text sizes so we can test the UI when the localization changes we do the follwoing from xcode:

1. Choose Edit Scheme... from the scheme dropdown. You access the dropdown by clicking the right side of the scheme for the area. You should see the scheme editing pane.
	
2. Make sure the Debug is selected in the left list and then choose the Arguments tab in the left area.

3. Click the + button under the Arguments Passed on Launch list in the top part of the tab. It should be above the Environment Variables area.

4. Enter the following text in the editing field that appears. (Make sure to include the initial dash character.) The pannel should look like this:

![Dobule Localized String size][image_double_localize_string]

5. Make sure the box is checked and click OK to dismiss the pane.

###Creating a localized file using ibtool

1. From the terminal go to the Base.lproj directory
2. Enter the following command from a terminal

		ibtool MainStoryboard_iPhone.storyboard --generate-strings-file Main_iPhone.strings


###Multiline Label on iOS 6.1

In order to have a multiline labe the following code seem to be necessary


	- (void)viewWillLayoutSubviews
	{
    	[super viewWillLayoutSubviews];
    	self.totalCarLabel.preferredMaxLayoutWidth = 0.0;
	}

	- (void)viewDidLayoutSubviews
	{
    	[super viewDidLayoutSubviews];
    	self.totalCarLabel.preferredMaxLayoutWidth = addCarView.frame.size.width;
    }

###Scheme to run the aplication in a particular language
Click on edit scheme and add the following aruguments. Similar to the image below:

	-AppleLanguages "(German)"
	-AppleLanguages "(Arabic)"
	
![image_run_application_language]

### Scheme to run the application with texts being doubled
Click on edit scheme and add the following aruguments. Similar to the image below:

	-NSDoubleLocalizedStrings YES
	
###ScrollView issue when rotating to landscape
Uncheck the Auto resize subviews in IB of scrollView:
	



### Seeing the vieew structure exception

Enter the following command
	
		po [[UIWindow keyWindow] _autolayoutTrace]
	

### Checking if the device is an iPAD or an iPhone

Use an if statement with the following condition
	
	UI_USER_INTERFACE_IDIOM() == <UIUserInterfaceIdiomPhone or UIUserInterfaceIdiomPad>
