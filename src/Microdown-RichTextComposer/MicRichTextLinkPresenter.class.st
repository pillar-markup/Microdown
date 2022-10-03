"
I will open links for RichText.

Links in Microdown are specified by `[Anchor](destination)`, and I concern myself with `destination`.
Destinations has a kind - for example html, jpg, or md.

I resolve how to present a link of a given kind in the following manner:

- If a method exist with a pragma `richtextlinkpresenter: kind` it will be executed with the destination reference (of type `MicAbsoluteResourceReference`).
- If the kind is '.jpg' or one of the other image formats which can be loaded in Pharo, I will load the document and show it in-image.
- other kinds will be passed on to the external webbrowser

### Example
A link to the microdown 
[Pharo Welcome Documentation](https://raw.githubusercontent.com/pharo-project/pharo/Pharo11/doc/Welcome/3-Documentation.md)

### Relative references
Relative references must be resolved before invoking this presenter.
"
Class {
	#name : #MicRichTextLinkPresenter,
	#superclass : #Object,
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #opening }
MicRichTextLinkPresenter >> guessKindOf: aMicAbsoluteResourceReference [ 
	|kind|
	kind := aMicAbsoluteResourceReference path copyAfterLast: $. .
	kind ifNotEmpty: [ ^ kind].
	((aMicAbsoluteResourceReference contents) asLowercase includesSubstring: '<!doctype')
		ifTrue: [ ^ 'html' ].
	"we make Microdown the default"
	^ 'md'
	
]

{ #category : #opening }
MicRichTextLinkPresenter >> openFormOn: aMicResourceReference [ 
	|image window |
	image := aMicResourceReference loadImage.
	window := SpImagePresenter new 
		image: image;
		autoScale: true;
		asWindow.
	window 
		title: 'Image viewer';
		open.
]

{ #category : #opening }
MicRichTextLinkPresenter >> openLink: anAbsoluteResourceReference [
	| kind |
	anAbsoluteResourceReference isRelative 
		ifTrue: [ MicResourceReferenceError 
			signal: 'Cannot open relative path: ', anAbsoluteResourceReference uri printString ].
	kind := self guessKindOf: anAbsoluteResourceReference.
	(self resolveKind: kind andOpen: anAbsoluteResourceReference)
		ifTrue: [ ^ self ].
	"no special handler found - is it image?"
	(ImageReadWriter allTypicalFileExtensions includes: kind)
		ifTrue: [ ^ self openFormOn: anAbsoluteResourceReference  ].
	"last, we try with an external browser"
	^ self openWebLink: anAbsoluteResourceReference
	
]

{ #category : #opening }
MicRichTextLinkPresenter >> openWebLink: aHtmlResource [
	WebBrowser openOn: aHtmlResource uri
]

{ #category : #opening }
MicRichTextLinkPresenter >> pragmaForKind: kind [
		| implementation |
	implementation := (Pragma allNamed: #richtextlinkpresenter:)
		select: [ :pragma | pragma arguments first = kind ].
	^ implementation
]

{ #category : #opening }
MicRichTextLinkPresenter >> resolveKind: kind andOpen: aMicHTTPResourceReference [
	"I will check if there is an implementation which would like to handle this kind.
	If so, handle it, if not return false"
	| implementation implementerClass |
	implementation := self pragmaForKind: kind.
	implementation
		ifEmpty: [ ^ false ].
	implementerClass := implementation first method methodClass soleInstance.
	implementation first method 
		valueWithReceiver: implementerClass 
		 arguments: {aMicHTTPResourceReference}.
	^ true
	 
		
		
	
]
