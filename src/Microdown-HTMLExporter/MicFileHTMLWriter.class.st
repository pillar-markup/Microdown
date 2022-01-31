"
Just a little class to test file conversion.
The functionality could be move in the default visitor by extending it with FileReference visit methods. 
"
Class {
	#name : #MicFileHTMLWriter,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicFileHTMLWriter >> convertFile: aFile [

	| doc write fileref |
	fileref := aFile asFileReference.
	doc := Microdown parse: fileref contents.

	write := MicHTMLWriter new.
	write visit: doc.

	(fileref parent / (fileref basenameWithoutExtension: 'md'), 'html') asFileReference 
		writeStreamDo: [ :st | st nextPutAll: write contents ]


]
