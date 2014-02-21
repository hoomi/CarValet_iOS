<!-- Image resources -->
[image_double_localize_string]:images/double_localized_string.png "Dobule Localized String size"
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
   
   
	
