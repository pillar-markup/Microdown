Class {
	#name : 'MicAbstractSanitizer',
	#superclass : 'Object',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'accessing' }
MicAbstractSanitizer >> constructString: aStream [

	|stream|

	stream := String new writeStream.
	aStream 
		do: [ :w | stream nextPutAll: w ]
		separatedBy: [ stream nextPut: Character space ].
	^ stream contents
]

{ #category : 'private' }
MicAbstractSanitizer >> sanitize: aBook [
	^ self subclassResponsibility.
]
