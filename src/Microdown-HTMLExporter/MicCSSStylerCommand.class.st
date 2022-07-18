"
Abstract command concerning Microdown HTML Styler.
"
Class {
	#name : #MicCSSStylerCommand,
	#superclass : #CmCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #initialization }
MicCSSStylerCommand class >> defaultIconName [
	^self subclassResponsibility 
]

{ #category : #'instance creation' }
MicCSSStylerCommand class >> forSpecContext: anObject [

	self flag: 'This helper is needed so icons can be displayed through #defaultIconName in class side subclasses (oposed to sending #iconNamed: to the command manually)'.
	^ (self forSpecWithIconNamed: self defaultIconName)
		context: anObject;
		yourself
]

{ #category : #accessing }
MicCSSStylerCommand class >> order [
	^ self subclassResponsibility

]

{ #category : #accessing }
MicCSSStylerCommand >> cssFramework [
	"Answer the currently selected <MicCSSFramework>"

	^ self context cssFramework
]

{ #category : #executing }
MicCSSStylerCommand >> exportToHtml: aMicHTMLDoc [ 
	"Write passed Microdown HTML document to a file"

	aMicHTMLDoc exists
		ifTrue: [
			self context isOverwrite
				ifFalse: [ ^ self inform: 'Already exists' ]
				ifTrue: [ self removeExport: aMicHTMLDoc fullName asFileReference ] ].
	aMicHTMLDoc writeToFileNamed: aMicHTMLDoc fileName.
	self inform: 'Export finished'
]

{ #category : #updating }
MicCSSStylerCommand >> micHtmlDocument [

	^ self context micHtmlDocument
]

{ #category : #private }
MicCSSStylerCommand >> removeExport: aFileReference [ 

	aFileReference parent ensureDeleteAll.
]
