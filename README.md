*Dunelox* is a library of components and utilities to implement Flex applications designed around [Conversation]s. 

Conversation objects are responsible for the flow of interactions between the user, the application context and services. Conversations are started from a View component in response to an user event such as a button click. A Conversation typically reads and writes objects to a shared Application Context, may interact with the user through Dialogs and may call remote Services to get and update Business objects.

Conversations should not dependent on the View that uses them. It is a self-contained (testable!) class that implements the flow by calling Services and Dialogs that in return callback to the Conversation after completion. 

Because of this separation, Conversations be used anywhere in your application, are better reusable and can even be combined (one conversation starting another).

To support the implementation of this pattern, several classes are available in this library that are used to create your own Conversation subclasses, work with Dialogs, access the shared Application Context and use Service clients (or sometimes called Controllers or Delegates).

See below an overview of the architecture in which a sequence of actions is seen.

[http://public.philemonworks.com.s3.amazonaws.com/Dunelox_Conversation.png]

== Features ==
  # Abstract Conversation class for implementing your own Use Cases  
  # ApplicationContext for a cross-component shared [http://philemonworks.wordpress.com/2007/07/17/flex-bindable-hash/ Bindable Hash]
  # National Language Support (NLS) for easy access to globalized !ResourceBundle data
  # Simple Dialogs such as !MessageDialog, !DateSelectionDialog and !ListSelectionDialog
  # !PageNavigationBar for paging support in !DataGrids
  # Authorizer for simple Role-Based-Access-Control
  # Abstract !RemoteService for building !RemoteObject bases !ServiceProxies

=== Related projects ===
 * [https://rubyforge.org/scm/?group_id=4206 Dunelox-Flexgen]  - Code generator for Flex from domain classes in Rails
 * [http://code.google.com/p/pocogese/ Pocogese] - XML-RPC messaging framework for Flex and Rails or Java
 * Dunelox-Tools,Dunelox-Types - Code generator for Flex in !VisualWorks Smalltalk [http://ernestmicklei.com] (blog)
 * [http://glare.googlecode.com Glare] - Flex !DataServices for Smalltalk


== Note: developement of this project has stopped ==
