Class {
	#name : 'FileParser',
	#superclass : 'TestCase',
	#category : 'microdown-fileParser',
	#package : 'microdown-fileParser'
}

{ #category : 'as yet unclassified' }
FileParser >> testCreatingFileAndParsingtheContent [

	| file root |
	file := (FileSystem workingDirectory / 'myFile.txt') asFileReference.
   file ensureCreateFile.


	
	file writeStreamDo: [ :stream | stream nextPutAll: '
	### title 
	@first 
	
	just talking about somthing @*first*@ ' ] .
	
	root := Microdown parseFile: file contents .

	self assert: (root isKindOf: MicRootBlock ) .
   self assert: root fromFile equals: file contents .
	file ensureDelete .

	
]
