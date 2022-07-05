Class {
	#name : #MicCSSStylerPreviewCommand,
	#superclass : #MicCSSStylerCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #accessing }
MicCSSStylerPreviewCommand class >> defaultDescription [

	^ 'Preview the selected style'
]

{ #category : #initialization }
MicCSSStylerPreviewCommand class >> defaultIconName [

	^ #forward
]

{ #category : #'accessing - defaults' }
MicCSSStylerPreviewCommand class >> defaultName [

	^ 'Preview'
]

{ #category : #default }
MicCSSStylerPreviewCommand class >> defaultShortcutKey [

	^ $v command mac | $v ctrl win | $v ctrl unix
]

{ #category : #accessing }
MicCSSStylerPreviewCommand class >> order [

	^ 3
]

{ #category : #testing }
MicCSSStylerPreviewCommand >> canBeExecuted [

	^ true
]

{ #category : #execution }
MicCSSStylerPreviewCommand >> execute [

	self exportToHtml: self context micDocumentFileRef.
]

{ #category : #executing }
MicCSSStylerPreviewCommand >> exportToHtml: aFileReference [ 
	"Write passed Microdown argument formatted as HTML, applying receiver's setttings"

	MicHTMLDoc new
		addCSSNamed: self cssFramework name;
		destinationPath: self destinationPath;
		fromMicrodown: aFileReference contents;
		writeToFileNamed: self outputFilename.
]
