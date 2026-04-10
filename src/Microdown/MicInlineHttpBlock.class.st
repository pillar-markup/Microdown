"
I implement the inline use of `https://somewhere.com` as a link directly in Microdown.
My parse method on the class side turns me directly into a `MicLinkBlock`, and as such, I am never instantiated.
"
Class {
	#name : 'MicInlineHttpBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicInlineHttpBlock class >> closingDelimiter [
	"I am never instantiated, but transformed into a MicLinkBlock"
	^ self shouldNotImplement 
]

{ #category : 'accessing' }
MicInlineHttpBlock class >> openingDelimiter [
	"I am never instantiated, but transformed into a MicLinkBlock"
	^ self shouldNotImplement 
]

{ #category : 'parsing' }
MicInlineHttpBlock class >> parse: delimiter stream: aTokenStream for: aParser [
	"I transform myself into a MicLinkBlock"

	^ MicLinkBlock new
		  children: { (MicTextBlock new bodyString: delimiter string) };
		  url: delimiter string;
		  closeMe
]

{ #category : 'visiting' }
MicInlineHttpBlock >> accept: dummy [
	self error: 'I should not be instantiatied and used by visitor'
]
