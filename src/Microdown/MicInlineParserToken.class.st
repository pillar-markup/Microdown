Class {
	#name : #MicInlineParserToken,
	#superclass : #Object,
	#instVars : [
		'string',
		'delimiter'
	],
	#pools : [
		'MicMicrodownSharedPool'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'instance creation' }
MicInlineParserToken class >> on: aString [ 
	^ self new
		string: aString;
		delimiter: 88
]

{ #category : #accessing }
MicInlineParserToken >> delimiter [

	^ delimiter
]

{ #category : #accessing }
MicInlineParserToken >> delimiter: anObject [

	delimiter := anObject
]

{ #category : #'instance creation' }
MicInlineParserToken >> on: aString [
	
]

{ #category : #accessing }
MicInlineParserToken >> string [

	^ string
]

{ #category : #accessing }
MicInlineParserToken >> string: anObject [

	string := anObject
]
