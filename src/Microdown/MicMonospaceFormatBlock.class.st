"
I represent a monospaced text section. I'm delimited using `\`` as in `\`monospace\`` to obtain `monospace`.
"
Class {
	#name : 'MicMonospaceFormatBlock',
	#superclass : 'MicFormatBlock',
	#category : 'Microdown-ModelInline',
	#package : 'Microdown',
	#tag : 'ModelInline'
}

{ #category : 'testing' }
MicMonospaceFormatBlock class >> isEvaluated [
	^ false
]

{ #category : 'visiting' }
MicMonospaceFormatBlock >> accept: aVisitor [
	^ aVisitor visitMonospace: self
]

{ #category : 'visiting' }
MicMonospaceFormatBlock >> closeMe [
	
	| text decodedString |
	decodedString := MicInlineParser escapeReescape: substring except: '`'.
	self substring: decodedString.
	children ifEmpty: [
			text :=  (MicTextBlock
							from: start
							to: end
							withSubstring: decodedString 
							withChildren: Array empty).
			self children: { text } ]
]

{ #category : 'internal' }
MicMonospaceFormatBlock >> closingDelimiter [

 	^ MonospaceMarkup
]

{ #category : 'accessing' }
MicMonospaceFormatBlock >> kind [
	^ #monospace
]

{ #category : 'internal' }
MicMonospaceFormatBlock >> openingDelimiter [

 	^ MonospaceMarkup
]
