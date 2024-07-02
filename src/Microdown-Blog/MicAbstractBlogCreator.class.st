Class {
	#name : 'MicAbstractBlogCreator',
	#superclass : 'Object',
	#instVars : [
		'targetDirectory'
	],
	#category : 'Microdown-Blog',
	#package : 'Microdown-Blog'
}

{ #category : 'creating' }
MicAbstractBlogCreator >> createGenericMetadata [

	| metadata |

	metadata := MicMetaDataBlock new.
	metadata body: Dictionary new.
	self setValidDateTo: metadata.
	
	^ metadata
]

{ #category : 'make' }
MicAbstractBlogCreator >> makeALink: aText to: aFileReference [

"Create a MicLinkBlock with a Text and a FileReference"

	| text link ref |
	text := 'Undefined'.
	aText ifNotNil: [ aText ifNotEmpty: [ text := aText ] ].

	link := 'Undefined'.
	aFileReference ifNotNil: [
		ref := aFileReference asFileReference.
		ref path isEmpty ifFalse: [ link := ref path fullName ] ].

	^ (MicInlineParser parse: '[' , text , '](' , link , ')') first
]

{ #category : 'accessing' }
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
MicAbstractBlogCreator >> targetDirectory: aFileReference [

	targetDirectory := aFileReference asFileReference
]

{ #category : 'verifying' }
MicAbstractBlogCreator >> verifyDateMetadata: aMicRootBlock [

"Verify if Metadata exist, the date in metadata exist and if the date are correct. Otherwise, we create a MicMetadataBlock with a date having the value in replacementDate method "

	| newMicRootBlock metadata |
	newMicRootBlock := MicRootBlock new.

	aMicRootBlock children
		ifEmpty: [ metadata := self createGenericMetadata ]
		ifNotEmpty: [
			(aMicRootBlock children first isKindOf: MicMetaDataBlock)
				ifFalse: [ metadata := self createGenericMetadata ]
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
