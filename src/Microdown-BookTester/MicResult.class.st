"
I represent an error result raised by MicReferenceChecker.

I am composed of:
- an explanation (of my error)
- a specification (the name of concerned file or reference)

All recognized error explanation are in allResult dictionary.

Use my constructor to instantiate me.

"
Class {
	#name : 'MicResult',
	#superclass : 'Object',
	#instVars : [
		'message',
		'anchorLabel',
		'status',
		'source',
		'explanation'
	],
	#classInstVars : [
		'allMessages'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicResult class >> allMessages [
   	^ allMessages ifNil: [ 
		allMessages := Dictionary new.
		allMessages
		  
	     	at: #referenceIsFine put: 'the reference defined correctly and point to a defined anchor';
		   at: #false put: 'Failed' ;
		   at: #true put: 'Passed' ;
			at: #anchorIsFine put: 'the anchor is defined correctly and not duplicated elsewhere ';
			at: #anchorIsMissing put: 'i represent A reference that refers to a missing anchor';
			at: #twoAnchorsSameName put: '2 anchors are declared with the same name'.
		^ allMessages ]
]

{ #category : 'accessing' }
MicResult class >> message: aMethodSymbol anchorLabel: aAnchorLabel [
	^ self new message: (self allMessages at: aMethodSymbol); anchorLabel: aAnchorLabel asString; yourself.
]

{ #category : 'initialization' }
MicResult class >> reset [
	<script>
	allMessages := nil
]

{ #category : 'accessing' }
MicResult >> anchorLabel [

	^ anchorLabel
]

{ #category : 'accessing' }
MicResult >> anchorLabel: anObject [

	anchorLabel := anObject
]

{ #category : 'accessing' }
MicResult >> explanation [

	^ 'test status: ',
	  (self class allMessages at: self status asString) asString ,
     String cr , 
     'Description of the test result : ' ,
	 self message asString ,
	 String cr ,
	 'the concerned element :  ',
	 self anchorLabel asString , 
	 String cr , 
	'from the source file:  ' ,
   	self source asString 
	
]

{ #category : 'accessing' }
MicResult >> explanation: anObject [

	explanation := anObject
]

{ #category : 'accessing' }
MicResult >> message [

	^ message
]

{ #category : 'accessing' }
MicResult >> message: anObject [

	message := anObject
]

{ #category : 'accessing' }
MicResult >> source [

	^ source
]

{ #category : 'accessing' }
MicResult >> source: anObject [

	source := anObject
]

{ #category : 'accessing' }
MicResult >> status [

	^ status
]

{ #category : 'accessing' }
MicResult >> status: anObject [

	status := anObject
]
