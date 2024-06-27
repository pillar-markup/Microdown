Class {
	#name : 'MicAbstractBlogCreator',
	#superclass : 'Object',
	#instVars : [
		'targetDirectory'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'as yet unclassified' }
MicAbstractBlogCreator >> createGenericMetadata [

	| metadata |

	metadata := MicMetaDataBlock new.
	metadata body: Dictionary new.
	self setValidDateTo: metadata.
	
	^ metadata
]

{ #category : 'make' }
MicAbstractBlogCreator >> makeALink: aText to: aLink [

	| text link |
	text := aText.
	text isNil
		ifTrue: [ text := 'Undefined' ]
		ifFalse: [ text isEmpty ifTrue: [ text := 'Undefined' ]].

	link := aLink.
	link isNil
		ifTrue: [ link := 'Undefined' ]
		ifFalse: [ link isEmpty ifTrue: [ link := 'Undefined' ]].
		
	^ (MicInlineParser parse: '[' , text , '](' , link , ')') first
]

{ #category : 'as yet unclassified' }
MicAbstractBlogCreator >> replacementDate [

	^ '1970/12/25'
]

{ #category : 'verifying' }
MicAbstractBlogCreator >> setValidDateTo: metadata [

	metadata atKey: #date put: self replacementDate
]

{ #category : 'accessing' }
MicAbstractBlogCreator >> targetDirectory [ 
	
	^ targetDirectory 
]

{ #category : 'accessing' }
MicAbstractBlogCreator >> targetDirectory: target [

	targetDirectory := target
]

{ #category : 'as yet unclassified' }
MicAbstractBlogCreator >> verifyDateMetadata: aMicRootBlock [

	| newMicRootBlock metadata |
	newMicRootBlock := MicRootBlock new.

	aMicRootBlock children isEmpty
		ifTrue: [
			metadata := self createGenericMetadata ]
		ifFalse: [
			(aMicRootBlock children first isKindOf: MicMetaDataBlock)
				ifFalse: [
					metadata := self createGenericMetadata  ]
				ifTrue: [
					metadata := aMicRootBlock children first.
					(metadata includesKey: #date)
						ifFalse: [ self setValidDateTo: metadata ]
						ifTrue: [
							[ Date readFrom: (metadata atKey: #date) pattern: 'y/m/d' ]
								on: DateError
								do: [ :ex | self setValidDateTo: metadata ] ] ] ].
	metadata parent: newMicRootBlock.

	aMicRootBlock children
		do: [ :each | newMicRootBlock addChild: each ]
		without: metadata.
	^ newMicRootBlock
]
