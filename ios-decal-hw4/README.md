<h1> Radius : ONLY WORKS ON IPHONE 6S </h1>
<h2> Authors: </h2>
- Cesar Villalobos
- Kelly Hong
- Naga Alluri

<h2> Purpose:  </h2>
ONLY WORKS ON IPHONE 6S
Radius is an application that aims to connect friends in a fun new way. Type a message, select friends, and drop! They will “pick up” the note when they are nearby the place you left it!

More concisely, Radius allows users to send a message to a friend based on their current location. The recepient can then receive the message once they are within ~20 feet from the place where the message was "dropped". If a user has not seen a message for longer than a week, the recepient receives a "soft notification" which lets the user know they have a message for them waiting in location X. 

<h2> Features:  </h2>
ONLY WORKS ON IPHONE 6S
- Ability to sign up and log in
- Ability to add, look up, and delete friends
- Ability to send and receive messages
- Ability to view one's current location
- Ability to view and delete past messages
- "Soft notifications" that notify the user that they have a message they have not yet seen 
- Bonus: Ability for users to send a message to a specific location remotely

<h2> Control Flow:   </h2>
* ONLY WORKS ON IPHONE 6S
* Users are initially presented with an initial screen where they can either log in or sign up. Once they have made an account or logged in, they are presented with a home page. 
* In the center of the home page, there is a map with the user's current location. On the bottom and top of the screen, there are various buttons that, from here, allow users to access various screens that allow them to do different things. 
* There is an "Archive" button, which displays received messages.
* There is also a "Send Message" option that allows the user to compose and send a new Radius message. 
* Another thing the users can access is a screen that displays a map with pins pointing to the places where messages have been received/opened. 
* From the home screen the user can also access a "Friends", "Sent Messages", and "Settings" tab which take the users to new views that display the aforementioned Views.
* At the bottom-middle of the screen is a "Home" button which will take the user back to the "Home" page regardless of which View the user is currently on. 

<h2> Implementation </h2>

<h3> Model  </h3>
* MessageDefinition.swift
* UserDefinition.swift
* UserMessageArchive.swift
* UserSettingsAndDetails.swift
<h3> View  </h3>
* ArchiveTableView
* SentMessagesView
* MKMapView
* ComposeNewMessageView
* FriendsTableView
* SettingsTableView
* HomeView
<h3> Controller  </3>
* ArchiveTableViewController
* SentMessagesViewController
* MKMapViewController
* ComposeNewMessageViewController
* FriendsTableViewController
* SettingsTableViewController
* HomeViewController




