"
Sometimes resources cannot be accessed, their URI can be misspelled, the http server can be down, etc.
I am signalled when one tries to access a resource that cannot be accessed for any reason.

In particular, the methods `loadImage` and `loadMicrodown` in (subclasses of) `MicAbsoluteResourceReference` can signal me.
"
Class {
	#name : 'MicResourceReferenceError',
	#superclass : 'Error',
	#category : 'Microdown-Core',
	#package : 'Microdown',
	#tag : 'Core'
}
