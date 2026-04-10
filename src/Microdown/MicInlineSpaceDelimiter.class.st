Class {
	#name : 'MicInlineSpaceDelimiter',
	#superclass : 'MicInlineDelimiter',
	#pools : [
		'MicSharedPool'
	],
	#category : 'Microdown-InlineParser',
	#package : 'Microdown',
	#tag : 'InlineParser'
}

{ #category : 'initialization' }
MicInlineSpaceDelimiter class >> initializeDelimiters [
	
	"line break"
	self new  addMe
	
	
		
]

{ #category : 'accessing' }
MicInlineSpaceDelimiter >> blockClass [

	^ MicInlineSpaceBlock
]

{ #category : 'accessing' }
MicInlineSpaceDelimiter >> isEvaluated [

	^ false
]

{ #category : 'accessing' }
MicInlineSpaceDelimiter >> isOpener [

	^ true
]

{ #category : 'accessing' }
MicInlineSpaceDelimiter >> isRawkind [

	^ false
]

{ #category : 'accessing' }
MicInlineSpaceDelimiter >> markup [ 
	^ InlineSpace 
]

{ #category : 'accessing' }
MicInlineSpaceDelimiter >> markupAsRegex [
	
	^ InlineSpace
]
