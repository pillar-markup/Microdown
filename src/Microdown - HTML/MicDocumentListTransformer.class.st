Class {
	#name : #MicDocumentListTransformer,
	#superclass : #MicNodeTransformer,
	#instVars : [
		'workingDirectory',
		'currentFile',
		'filesDirectory',
		'availableTemplates'
	],
	#category : #'Microdown - HTML'
}

{ #category : #'instance-creation' }
MicDocumentListTransformer class >> withContext: aContext [

	| inst |
	inst := super withContext: aContext.
	inst workingDirectory: aContext baseDirectory.
	^ inst
]

{ #category : #adding }
MicDocumentListTransformer >> addAbstractOfCurrentFileToDocument: aDocument inAnnotation: aMicDocListAnnotation [
	| abstractOfCurrentFile |
	abstractOfCurrentFile := MicroDownParser new parse: self currentFile contents.
	"arbitrary value for children"
	abstractOfCurrentFile
		children: {(MicTextBlock new substring: (abstractOfCurrentFile text truncateWithElipsisTo: aMicDocListAnnotation summaryMaxSize))}.
	^ self availableTemplates
		ifNotEmpty: [ | previousContent |
			previousContent := aDocument text.
			aDocument
				text: previousContent , (self generateFileUsingTemplateFromDocument: abstractOfCurrentFile) ]
		ifEmpty: [ abstractOfCurrentFile children do: [ :each | aDocument addChild: each ].
			self addLinkToDocument: aDocument ]
]

{ #category : #adding }
MicDocumentListTransformer >> addLinkToDocument: aDocument [
	aDocument
		addChild:
			((PRInternalLink reference: self filesDirectory , '/' , self currentFile basename)
				addAll: {(MicTextBlock new substring: 'Read more')};
				yourself)
]

{ #category : #accessing }
MicDocumentListTransformer >> availableTemplates [
	^ availableTemplates
]

{ #category : #transforming }
MicDocumentListTransformer >> createDocList: aMicDocListAnnotation [
	| files document sortedFiles |
	"Check if the specified path exist and get pillar files from it.
	Get some abstract of these pillar files. The final document is a DocumentGroup, but when templates
	are specified and exists It is a Raw HTML document"
	document := MicRootBlock new.
	
	availableTemplates := self lookForAvailableTemplates: aMicDocListAnnotation templates.
	self availableTemplates ifNotEmpty: [ document := MicRawBlock new text: '' ].
	
	filesDirectory := aMicDocListAnnotation path.
	(workingDirectory resolve: self filesDirectory) exists
		ifTrue: [ 
			files := (workingDirectory resolve: aMicDocListAnnotation path) files select: [ :each | each extension = 'mic' ].
			sortedFiles := self sort: files limit: (aMicDocListAnnotation limit asInteger min: files size) by: aMicDocListAnnotation sort.
			
			1 to: (aMicDocListAnnotation limit asInteger min: sortedFiles size) do: [ :index | 
				currentFile := (sortedFiles at: index).
				
				"Parse current file and add an abstract to the general document"
				self addAbstractOfCurrentFileToDocument: document inAnnotation: aMicDocListAnnotation ] 
		].
	^ document
]

{ #category : #adding }
MicDocumentListTransformer >> currentDocumentInternalLink [
	
	^ PRInternalLink reference: self filesDirectory , '/' , self currentFile basename
]

{ #category : #visiting }
MicDocumentListTransformer >> currentFile [
	^ currentFile
]

{ #category : #accessing }
MicDocumentListTransformer >> filesDirectory [
	^ filesDirectory
]

{ #category : #parsing }
MicDocumentListTransformer >> generateFileUsingTemplateFromDocument: aDocument [
	| conf htmlDoc |
	"Read configurations"
	conf := ConfigurationForMicrodown newFromDictionary: aDocument properties.
	self halt.
	conf parent: self configuration.

	"Write the  document in HTML, It means that this template is only for HTML generation"
	conf at: #content put: (MicHTMLWriter write: aDocument).
	conf at: #link put: self currentDocumentInternalLink referenceAsHTML.
	
	htmlDoc := (MustacheTemplate on: (self workingDirectory resolve: self availableTemplates first) contents) value: conf.
	self availableTemplates add: availableTemplates first.
	self availableTemplates remove: availableTemplates first. 
	^ htmlDoc
]

{ #category : #accessing }
MicDocumentListTransformer >> lookForAvailableTemplates: aCollection [
	^ (aCollection select: [ :each | (self workingDirectory resolve: each) exists and: [ each asFileReference extension = 'mustache' ] ]) asOrderedCollection
]

{ #category : #sorting }
MicDocumentListTransformer >> sort: aCollectionOfReferences limit: anInteger by: aString [
	| references |
	references := aCollectionOfReferences first: anInteger.
	aString = 'date'
		ifTrue: [ ^ MicDocumentListDateSorter with: references ].
	aString = 'name'
		ifTrue: [ ^ MicDocumentListNameSorter with: references ].
	^ references
]

{ #category : #visiting }
MicDocumentListTransformer >> visitDocListAnnotation: aMicDocListAnnotation [
	self replace: { (self createDocList: aMicDocListAnnotation) }
]

{ #category : #accessing }
MicDocumentListTransformer >> workingDirectory [
	^ workingDirectory
]

{ #category : #accessing }
MicDocumentListTransformer >> workingDirectory: aFileReference [
	workingDirectory := aFileReference
]
