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

	self exportToHtml: self micHtmlDocument.
	WebBrowser openOn: self micHtmlDocument fullName.
]
