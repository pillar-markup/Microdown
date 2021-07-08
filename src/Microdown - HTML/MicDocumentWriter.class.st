Class {
	#name : #MicDocumentWriter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream',
		'configuration',
		'canvas',
		'writingRaw'
	],
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicDocumentWriter class >> defaultConfiguration [
	| defaultConfiguration |
	defaultConfiguration := ConfigurationForMicrodown new.
	defaultConfiguration properties at: 'outputType' put: self.
	defaultConfiguration properties at: 'configurations' put: Dictionary new.	"we specify an empty collection of sub configurations to avoid infinite recursion : a default configuration would otherwise contain a collection of default configurations, each containing a collection of default configurations..."
	^ defaultConfiguration
]

{ #category : #accessing }
MicDocumentWriter class >> defaultConfigurationName [
	^ self writerName
]

{ #category : #accessing }
MicDocumentWriter class >> fileExtension [
	^ self subclassResponsibility
]

{ #category : #accessing }
MicDocumentWriter class >> folderName [
	"This method is for decoupling the writer from its physical representation.
	It represents the physical folder name in the archetype, used when this writer is specified.
	For example your writerName can be latex:sbabook but the corresponding folderName is latex"
	^ self subclassResponsibility
]

{ #category : #testing }
MicDocumentWriter class >> isAbstract [
	^ self = MicDocumentWriter
]

{ #category : #accessing }
MicDocumentWriter class >> markupType [
	^ self writerName
]

{ #category : #'instance creation' }
MicDocumentWriter class >> on: aWriteStream [ 
	^ self new
		setStream: aWriteStream;
		yourself
]

{ #category : #'instance creation' }
MicDocumentWriter class >> write: aDocumentItem [
	^ self new write: aDocumentItem
]

{ #category : #'instance creation' }
MicDocumentWriter class >> write: aDocument to: aStream [
	^ self new write: aDocument to: aStream
]

{ #category : #accessing }
MicDocumentWriter class >> writerName [
	"Each writer define this to know the appropriate files to take for process. This one is different from folderName which corresponds to the physical representation. See folderName"
	^ self subclassResponsibility
]

{ #category : #accessing }
MicDocumentWriter >> canvasClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
MicDocumentWriter >> configuration [
	^ configuration ifNil: [ configuration := ConfigurationForMicrodown new ]
]

{ #category : #accessing }
MicDocumentWriter >> configuration: aConfiguration [ 
	configuration := aConfiguration.
	stream ifNotNil: [ stream configuration: aConfiguration ]
]

{ #category : #accessing }
MicDocumentWriter >> contents [ 
	^ stream contents
]

{ #category : #private }
MicDocumentWriter >> defaultStream [
	^ WriteStream on: (String new: 1000)
]

{ #category : #accessing }
MicDocumentWriter >> fileExtension [
	^ self class fileExtension , '.json'
]

{ #category : #templating }
MicDocumentWriter >> folderName [

	^ self class folderName
]

{ #category : #helpers }
MicDocumentWriter >> getStringFor: anObject [
	"Visit anObject and exports everything to a new stream. Answer the stream content."
	^ self getStringForAll: { anObject }
]

{ #category : #helpers }
MicDocumentWriter >> getStringForAll: aCollection [
	"Visit each element of aCollection and exports everything to a new stream. Answer the stream content."
	^ String streamContents: [ :newStream | | visitor |
		visitor := (self class on: newStream)
			configuration: self configuration;
			yourself.
		aCollection do: [ :object | visitor start: object ] ]
]

{ #category : #initialization }
MicDocumentWriter >> initialize [
	super initialize.
	writingRaw := false.
	self setStream: self defaultStream.
	canvas := self canvasClass on: stream.
]

{ #category : #helpers }
MicDocumentWriter >> languageForScript: aScript [
	^ aScript language isSpecified
		ifTrue: [ aScript language ]
		ifFalse: [ self configuration defaultScriptLanguage ]
]

{ #category : #accessing }
MicDocumentWriter >> mainDocumentTemplateName [
	
	^ 'template'
]

{ #category : #accessing }
MicDocumentWriter >> markupType [
	^ self class markupType
]

{ #category : #helpers }
MicDocumentWriter >> noNewLineDuring: aBlock [
	| oldNewLine |
	oldNewLine := self configuration newLine.
	self configuration newLine: ''.
	aBlock ensure: [ self configuration newLine: oldNewLine ]
]

{ #category : #initialization }
MicDocumentWriter >> setStream: aStream [
	stream := MicOutputStream on: aStream.
	configuration ifNotNil: [ stream configuration: configuration ].
	canvas ifNotNil: [ canvas setStream: stream ].
]

{ #category : #visiting }
MicDocumentWriter >> start: anObject [
	super start: anObject.
	canvas flush
]

{ #category : #templating }
MicDocumentWriter >> templateForConfiguration: aConfiguration [
	| inputFile templateName |
	configuration := aConfiguration.
	inputFile := configuration inputFile.
	
	(configuration hasProperty: #mainDocument)
		ifFalse: [ ^ configuration propertyAt: self mainDocumentTemplateName ifAbsent: [ 'main.mustache' ] ].
	
	templateName := inputFile fullName
		= ((configuration baseDirectory resolve: configuration mainDocument) , 'pillar') fullName
		ifTrue: [ self mainDocumentTemplateName ]
		ifFalse: [ self chapterTemplateName ].
	^ configuration propertyAt: templateName
]

{ #category : #'visiting-document' }
MicDocumentWriter >> visitRaw: aRaw [
	(aRaw isForType: self writerName)
		ifTrue: [ self writeRawDuring: [ super visitRaw: aRaw ] ]
]

{ #category : #'visiting-document' }
MicDocumentWriter >> visitText: aText [
	writingRaw
		ifTrue: [ canvas rawLines: aText substring ]
		ifFalse: [ canvas nextPutAllLines: aText substring ]
]

{ #category : #visiting }
MicDocumentWriter >> write: aDocumentItem [
	^ self start: aDocumentItem; contents
]

{ #category : #visiting }
MicDocumentWriter >> write: aDocumentItem to: aStream [
	^ self setStream: aStream; start: aDocumentItem
]

{ #category : #helpers }
MicDocumentWriter >> writeCounter: aCounter [
	"Write on the canvas the string representation of ==aCounter=="

	^ aCounter elements do: [ :each | self writeCounterElement: each ] separatedBy: [ self writeCounterElementSeparator ]
]

{ #category : #helpers }
MicDocumentWriter >> writeCounterDefinitionSeparator [
	canvas nextPutAll: '. '
]

{ #category : #helpers }
MicDocumentWriter >> writeCounterElement: aCounterElement [
	canvas nextPutAll: aCounterElement asString
]

{ #category : #helpers }
MicDocumentWriter >> writeCounterElementSeparator [
	canvas nextPut: $.
]

{ #category : #helpers }
MicDocumentWriter >> writeCounterForFigure: aFigure [
	aFigure counter isValidCounter
		ifFalse: [ ^ self ].
	self writeCounter: aFigure counter.
	self writeCounterDefinitionSeparator
]

{ #category : #helpers }
MicDocumentWriter >> writeCounterForHeader: aHeader [
	"| headerConf |
	headerConf := self configuration levelConfigurationFor: aHeader.
	(headerConf numbering and: [ aHeader counter isValidCounter and: [ headerConf size > 0 ] ])
		ifFalse: [ ^ self ].
	canvas nextPutAll: (headerConf printCounter: aHeader children).
	self writeCounterDefinitionSeparator"
	^ self
]

{ #category : #helpers }
MicDocumentWriter >> writeCounterForScript: aScript [
	aScript counter isValidCounter
		ifFalse: [ ^ self ].
	self writeCounter: aScript counter.
	self writeCounterDefinitionSeparator
]

{ #category : #writing }
MicDocumentWriter >> writeParagraphDuring: aBlockClosure [ 
	
	self subclassResponsibility
]

{ #category : #helpers }
MicDocumentWriter >> writeRawDuring: aBlock [
	[ 
	writingRaw := true.
	aBlock value ]
		ensure: [ writingRaw := false ]
]

{ #category : #compatibility }
MicDocumentWriter >> writerFor: aPRPillarConfiguration [ 
	
	^ self
]

{ #category : #accessing }
MicDocumentWriter >> writerName [
	^ self class writerName
]
