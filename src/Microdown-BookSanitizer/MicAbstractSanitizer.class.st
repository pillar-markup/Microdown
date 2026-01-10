Class {
	#name : 'MicAbstractSanitizer',
	#superclass : 'Object',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
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
