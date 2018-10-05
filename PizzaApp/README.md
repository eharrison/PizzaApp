#  Nenno's Pizza

## Features
- Shows List of pizzas available
- Allows Customizing pizza
- Allows Editing pizza before checking out
- Cart Management
- Lazy loading with Skeleton content
- Shimmering effect when loading images
- Empty data notification

## Structure

App is divided in 4 base folders:
- Modules: Where all parts of the app would be located. Perhaps including their respective Storyboards and Xibs.
- Library: All the logic of the app is located here.
- Assets: For all assets.
- Supporting Files: App delegate and other supporting files.

## Design Patterns

I'm using the following Design patterns:
- MVVM: to serve as model for the view controller. (*ViewControllerModel)
- Delegates: Being used to send information from ViewModel to ViewController
- Facade: Separating the network layer

## Tests

Added basic unit tests for model parsing and checking if URL is correct. They are part of the module as it makes it easier to find them. Feel free to run CMD+U.

## Limitations

- **Not possible to choose Drinks.** I added the services for Drinks, but didn't build the UI for it. Currently all I'm presenting is a message.
- **Order POST doesn't work**, seems like the service is not existent. In this case, I'm taking it as successful anyways for demonstration purposes.
- **Not persisting data accross launches.** This could be easily accomplished with local storage. Either UserDefaults or CoreData. Quick approach would be using UserDefaults by saving parsed Data.
