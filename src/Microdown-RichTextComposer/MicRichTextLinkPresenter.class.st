"
I will open links for RichText.
Links in Microdown are specified by `[Anchor](destination)`, and I concern myself with `destination`.
Destinations has a kind - for example html, jpg, or md.

I resolve how to present a link of a given kind in the following manner:

- If a method exist with a pragma `richtextlinkpresenter: kind` it will be executed with the destination reference (of type `MicAbsoluteResourceReference`).
- If the kind is '.jpg' or one of the other image formats which can be loaded in Pharo, I will load the document and show it in-image.
- other kinds will be passed on to the external webbrowser

### Relative references
Relative references must be resolved before invoking this presenter.
"
Class {
	#name : #MicRichTextLinkPresenter,
	#superclass : #Object,
	#category : #'Microdown-RichTextComposer-Composer'
}

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
	| path kind |
	anAbsoluteResourceReference isRelative 
		ifTrue: [ MicResourceReferenceError 
			signal: 'Cannot open relative path: ', anAbsoluteResourceReference uri printString ].
	path := anAbsoluteResourceReference path.
	kind := path copyAfterLast: $. .
	(kind isEmpty "eg. https://pharo.org or https://pharo.org/download"
	 or: [kind = 'html'] ) ifTrue: [ ^ self openWebLink: anAbsoluteResourceReference  ].
	(ImageReadWriter allTypicalFileExtensions includes: kind)
		ifTrue: [ ^ self openFormOn: anAbsoluteResourceReference  ].
	^ self resolveKind: kind andOpen: anAbsoluteResourceReference
	
]

{ #category : #opening }
MicRichTextLinkPresenter >> resolveKind: kind andOpen: aMicHTTPResourceReference [
	"I will check if there is an implementation which would like to handle this kind.
	If so, handle it, if not return false"
	| implementation |
	implementation := (Pragma allNamed: #richtextlinkpresenter:)
		select: [ :pragma | pragma arguments first = kind ].
	implementation
		ifEmpty: [ ^ false ].
	implementation first method 
		valueWithReceiver: implementation first method methodClass
		 arguments: {aMicHTTPResourceReference}.
	^ true
	 
		
		
	
]
