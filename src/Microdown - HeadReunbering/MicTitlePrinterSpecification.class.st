Class {
	#name : #MicTitlePrinterSpecification,
	#superclass : #Object,
	#instVars : [
		'numbering',
		'size',
		'level',
		'autoAnchor',
		'configuration',
		'capitalization',
		'printer',
		'renderAs'
	],
	#category : #'Microdown - HeadReunbering'
}

{ #category : #'accessing - defaults' }
MicTitlePrinterSpecification class >> defaultLevel [
	^ 1
]

{ #category : #'instance creation' }
MicTitlePrinterSpecification class >> new [
	^ self with: Dictionary new
]

{ #category : #'instance creation' }
MicTitlePrinterSpecification class >> with: aDictionary [
	"what a ugly API"
	| inst |
	inst := super new
		numbering: (aDictionary at: 'numbering' ifAbsent: [ true ]);
		autoAnchor: (aDictionary at: 'autoAnchor' ifAbsent: [ false ]);
		capitalization: (aDictionary at: 'capitalization' ifAbsent: [ 'raw' ]);
		yourself.
	inst numbering
		ifTrue: [ inst size: (aDictionary at: 'size' ifAbsent: [ 0 ]) ]
		ifFalse: [ inst size: 0 ].
	^ inst
]

{ #category : #accessing }
MicTitlePrinterSpecification >> autoAnchor [
	^ autoAnchor 
]

{ #category : #accessing }
MicTitlePrinterSpecification >> autoAnchor: anObject [ 

	autoAnchor := anObject 
]

{ #category : #accessing }
MicTitlePrinterSpecification >> capitalization [
	^ capitalization
]

{ #category : #accessing }
MicTitlePrinterSpecification >> capitalization: anObject [
	capitalization := anObject 
]

{ #category : #rendering }
MicTitlePrinterSpecification >> elementSeparator [
	"why hardcoding it?"
	^ $.
]

{ #category : #initialization }
MicTitlePrinterSpecification >> fillFromAnother: another [
	"copy all the field from another instance this is used to convert a configuration specification to an instance of one of the subclasses."
	"the equivalent of a changeClassToThatOf:"
	
	self autoAnchor: another autoAnchor. 
	self capitalization: another capitalization. 
	self level: another level. 
	self numbering: another numbering. 
	self renderAs: another renderAs. 
	self size: another size
]

{ #category : #accessing }
MicTitlePrinterSpecification >> headerSize [
	^ size
]

{ #category : #accessing }
MicTitlePrinterSpecification >> headerSize: anInteger [
	"Pay attention changing the size only makes sense when numbering is true."

	size := numbering
		ifTrue: [ anInteger ]
		ifFalse: [ 0 ]
]

{ #category : #initialization }
MicTitlePrinterSpecification >> initialize [

	super initialize.
	numbering := true. 
	autoAnchor := false.
	capitalization := 'raw'.
	level := 1. 
	renderAs := 'number'
]

{ #category : #accessing }
MicTitlePrinterSpecification >> level [
	^ level ifNil: [ self class defaultLevel ]
]

{ #category : #accessing }
MicTitlePrinterSpecification >> level: anObject [
	level := anObject
]

{ #category : #accessing }
MicTitlePrinterSpecification >> numbering [
	^ numbering
]

{ #category : #accessing }
MicTitlePrinterSpecification >> numbering: anObject [
	numbering := anObject
]

{ #category : #accessing }
MicTitlePrinterSpecification >> predecessor [
	^ level = 1
			ifTrue: [ nil ]
			ifFalse: [ self printer perform: ('level' , (self level - 1) asString) asSymbol ]
]

{ #category : #rendering }
MicTitlePrinterSpecification >> printCounter: aCollection [
	^ String streamContents: [ :s | self printCounter: aCollection withMaxSize: self size on: s ]

]

{ #category : #rendering }
MicTitlePrinterSpecification >> printCounter: aCollection withMaxSize: aSize on: stream [
	aSize > 0
		ifTrue: [ (self predecessor isNotNil and: [ aSize - 1 > 0 ])
				ifTrue: [ self predecessor printCounter: aCollection allButLast withMaxSize: aSize - 1 on: stream.
					aCollection allButLast last = -1
						ifFalse: [ stream nextPut: self elementSeparator ] ].
			self printElement: aCollection last on: stream ]
]

{ #category : #'rendering-element' }
MicTitlePrinterSpecification >> printElement: aNumber on: stream [
	aNumber = -1
		ifFalse: [ self renderElement: aNumber on: stream ]
]

{ #category : #printing }
MicTitlePrinterSpecification >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: 'level:'; 
		nextPutAll: self level asString.
	aStream nextPutAll: ' autoAnchor:'; 
		nextPutAll: self autoAnchor asString.
]

{ #category : #accessing }
MicTitlePrinterSpecification >> printer [

	^ printer
]

{ #category : #accessing }
MicTitlePrinterSpecification >> printer: aPrinter [

	printer := aPrinter
]

{ #category : #accessing }
MicTitlePrinterSpecification >> renderAs [
	"only use during serialisation to serve as an marker to create instance of adequate subclasses"
	^ renderAs 
]

{ #category : #accessing }
MicTitlePrinterSpecification >> renderAs: aString [
	"only use during serialisation"
	renderAs := aString
]

{ #category : #'rendering-element' }
MicTitlePrinterSpecification >> renderElement: aNumber on: stream [
	^ self subclassResponsibility
]

{ #category : #accessing }
MicTitlePrinterSpecification >> size [
	^ self headerSize
]

{ #category : #accessing }
MicTitlePrinterSpecification >> size: anInteger [
	"Pay attention changing the size only makes sense when numbering is true."
	self headerSize: anInteger
]
