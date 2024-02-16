"
A MicRichTextLinkPresenterTest is a test class for testing the behavior of MicRichTextLinkPresenter
"
Class {
	#name : 'MicRichTextLinkPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'linkPresenter'
	],
	#category : 'Microdown-RichTextComposer-Tests-Composer',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'Composer'
}

{ #category : 'running' }
MicRichTextLinkPresenterTest >> setUp [
	super setUp.
	linkPresenter := MicRichTextLinkDisplayer new.
]

{ #category : 'tests' }
MicRichTextLinkPresenterTest >> testGuessKindOf [
	"Testing default"
	| ref file |
	file := FileSystem memory / 'mydoc'.
	ref := file asMicResourceReference.
	ref contents: 'I am just a text file'.
	self assert: (linkPresenter guessKindOf: ref) equals: 'md'
]

{ #category : 'tests' }
MicRichTextLinkPresenterTest >> testGuessKindOf_html [
	"Testing default"
	| ref file |
	file := FileSystem memory / 'mydoc'.
	ref := file asMicResourceReference.
	ref contents: '<!doctype html>'.
	self assert: (linkPresenter guessKindOf: ref) equals: 'html'
]

{ #category : 'tests' }
MicRichTextLinkPresenterTest >> testGuessKindOf_html_with_comment [
	"Testing default"
	| ref file |
	file := FileSystem memory / 'mydoc'.
	ref := file asMicResourceReference.
	ref contents: '<!-- Silly stuff here -->

<!doctype html>'.
	self assert: (linkPresenter guessKindOf: ref) equals: 'html'
]

{ #category : 'tests' }
MicRichTextLinkPresenterTest >> testGuessKindOf_withExtension [
	"Testing default"
	| ref file |
	file := FileSystem memory / 'mydoc.foo'.
	ref := file asMicResourceReference.
	self assert: (linkPresenter guessKindOf: ref) equals: 'foo'
]

{ #category : 'tests' }
MicRichTextLinkPresenterTest >> testPragmaForKind [
	"Testing default"
	
	self assert: (linkPresenter pragmaForKind: '$$$' ) isEmpty
]
