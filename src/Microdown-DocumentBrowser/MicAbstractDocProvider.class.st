"
I am an abstract documentation provider. A documentation provider must implement a number of virtual methods:
- loadDocuments - return a document collection (of perhaps a single document)
- saveDocument: aDocument - store a document in this collection, persisting it if possible
"
Class {
	#name : #MicAbstractDocProvider,
	#superclass : #Object,
	#instVars : [
		'docUri',
		'documentsCache'
	],
	#classVars : [
		'CollectionCache'
	],
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #'instance creation' }
MicAbstractDocProvider class >> cache [
	 ^ CollectionCache ifNil: [ CollectionCache := OrderedDictionary new ].
	
]

{ #category : #'instance creation' }
MicAbstractDocProvider class >> cache: aCache [
	"I am used in testing to restore the original cache - I am not intended to be used for other purposes"
	 ^ CollectionCache := aCache 
	
]

{ #category : #'instance creation' }
MicAbstractDocProvider class >> initialize [
	<script>
	CollectionCache := nil.
	
]

{ #category : #'instance creation' }
MicAbstractDocProvider class >> onUri: aUri [
	^ self cache 
		at: aUri 
		ifAbsentPut: [
			self basicNew 
				docUri: aUri;
				initialize;
				yourself]
]

{ #category : #adding }
MicAbstractDocProvider >> addChild: documents [
	"I am needed for the child parent relationship to function, called by #parent:"
	documentsCache := documents 
]

{ #category : #testing }
MicAbstractDocProvider >> canSave [
	^ false
]

{ #category : #accessing }
MicAbstractDocProvider >> docUri [

	^ docUri
]

{ #category : #accessing }
MicAbstractDocProvider >> docUri: aZnUrlOrString [
	"aZnUrl responds self if asked to convert"
	docUri := aZnUrlOrString asZnUrl.
]

{ #category : #public }
MicAbstractDocProvider >> documents [
	^ documentsCache ifNil: [ documentsCache := self loadDocuments  ]
]

{ #category : #public }
MicAbstractDocProvider >> loadDocuments [
	self subclassResponsibility 
]

{ #category : #accessing }
MicAbstractDocProvider >> parent [
	^ nil
]

{ #category : #accessing }
MicAbstractDocProvider >> provider [
	^ self
]

{ #category : #'as yet unclassified' }
MicAbstractDocProvider >> refreshDocuments [
	documentsCache := self loadDocuments.
	
]

{ #category : #rendering }
MicAbstractDocProvider >> renderSection: aMicSectionBlock [ 
	^ Microdown asRichText: (aMicSectionBlock propertyAt: #source ifAbsent: [aMicSectionBlock]) 
]

{ #category : #accessing }
MicAbstractDocProvider >> saveCollectionAt: fileUri [
	"Save all the documents I provide at the specified fileUri"
]
