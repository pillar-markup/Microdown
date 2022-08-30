"
Abstract command concerning Microdown HTML Styler.
"
Class {
	#name : #MicHTMLStylerCommand,
	#superclass : #CmCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #initialization }
MicHTMLStylerCommand class >> defaultIconName [
	^self subclassResponsibility 
]

{ #category : #'instance creation' }
MicHTMLStylerCommand class >> forSpecContext: anObject [

	self flag: 'This helper is needed so icons can be displayed through #defaultIconName in class side subclasses (oposed to sending #iconNamed: to the command manually)'.
	^ (self forSpecWithIconNamed: self defaultIconName)
		context: anObject;
		yourself
]

{ #category : #accessing }
MicHTMLStylerCommand class >> order [
	^ self subclassResponsibility

]

{ #category : #accessing }
MicHTMLStylerCommand >> cssFramework [
	"Answer the currently selected <MicCSSFramework>"

	^ self context cssFramework
]

{ #category : #executing }
MicHTMLStylerCommand >> exportToHtml: aMicHTMLDoc [ 
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
MicHTMLStylerCommand >> micHtmlDocument [

	^ self context micHtmlDocument
]

{ #category : #private }
MicHTMLStylerCommand >> removeExport: aFileReference [ 

	aFileReference parent ensureDeleteAll.
]
