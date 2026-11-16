"
I represent the way to produce an output document (LaTex,....)
I often compose a visitor and some unix scripts + some folders for storing resources.

Pay attention the method `MicTemplatedWriter >> write: aMicElement 
	withTemplateFileName: templateFileName 
	extraArguments: arguments 
	ifAbsent: aBlock` expects a new and writer 

```
MicTemplatedWriter >> write: aMicElement 
	withTemplateFileName: templateFileName 
	extraArguments: arguments 
	ifAbsent: aBlock
	
	""Get templated text of children of aMicElement and template it with its template""
	
	self
		writeRawText: [ | subWriter |
			subWriter := outputDocument writer.
			subWriter environmentStack: environmentStack. 
			subWriter visitChildrenOf: aMicElement.
			subWriter contents ]
		withTemplateFileName: templateFileName
		extraArguments: arguments
		ifAbsent: aBlock
```
"
Class {
	#name : 'MicAbstractOutputDocumentMaker',
	#superclass : 'Object',
	#instVars : [
		'baseDirectory',
		'templateDirectory',
		'pageArguments'
	],
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> baseDirectory [

	^ baseDirectory
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> baseDirectory: anObject [

	baseDirectory := anObject
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> basicWriter [ 
	^ self subclassResponsibility
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> pageArguments [
	"The values the root template gets in addition to contents, e.g. the title or the table of contents of the page."

	^ pageArguments ifNil: [ pageArguments := Dictionary new ]
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> pageArguments: aDictionary [

	pageArguments := aDictionary
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> pathString [ 

	self flag: #revisitThis. 
	"All the paths harcoded everywhere makes me shiver."
	^  Path * '_support' / 'templates'
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> templateDirectory [
	"Answer the folder of the Mustache templates: the one given with templateDirectory:, else the conventional one below my base directory."

	^ templateDirectory ifNil: [
			  self baseDirectory / self writer folderName / '_support'
			  / 'templates' / self writer folderName ]
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> templateDirectory: aFileReference [

	templateDirectory := aFileReference
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> templateForConfiguration: aConfiguration [
   "Probably used by pillar."
	^ self basicWriter templateForConfiguration: aConfiguration
]

{ #category : 'accessing' }
MicAbstractOutputDocumentMaker >> writer [

	| writer |
	writer := MicTemplatedWriter new
			outputDocument: self;
			defaultWriter: self basicWriter;
			yourself.
	^ writer
]
