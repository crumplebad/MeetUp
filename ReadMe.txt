This iOS application uses VIPER architecture, making unit testing easier using dependency injection. I have written few sample unit test cases, it’s not exhaustive but demonstrative of ease of testing with VIPER. 


The app loads with default search string “10012_New York”

To use the search bar enter search string in the following format:
ZIPCODE_search text
E.g. 
	10012_hiking
	08876_Somerville

The app supports pull to refresh or start new search using string in the search box.
If no string is found in the search bar, default search string is used for search and the search bar is populated with default search string to let the users know, what the search results are for.  
 