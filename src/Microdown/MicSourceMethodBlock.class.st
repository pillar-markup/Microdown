"
I am an extension to include source code into markdown document. I am to be used as:
```text
<!source|class=MicSourceMethodBlock&method=accept:&side=instance!>
```
Yielding:
<!source|class=MicSourceMethodBlock&method=accept:&side=instance!>

The `side` argument can be `instance` or `class`. If can be omitted, and is then assumed to be `instance`
"
Class {
	#name : #MicSourceMethodBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicSourceMethodBlock class >> tag [
	^#source
]

{ #category : #visiting }
MicSourceMethodBlock >> accept: aVisitor [
	aVisitor visitAll: self children 
]

{ #category : #'parse support' }
MicSourceMethodBlock >> closeMe [
	|builder|
	super closeMe.
	builder := Microdown builder. 
	builder codeblock: self sourceCode firstLineAssociations: { #language -> #Method }.
	self children:  (Microdown parse: builder contents) children.
]

{ #category : #accessing }
MicSourceMethodBlock >> sourceCode [

	| className class methodName method|
	className := self arguments at:  #class ifAbsent: [MicParsingError signal: 'No class argument in <!source... '].
	class := self class environment at: className asSymbol ifAbsent: [MicParsingError signal: 'Unknown class in <!source... ', className].
	((self arguments at: #side ifAbsent: [ 'instance' ]) = 'class')
		ifTrue: [ class := class class ].
	methodName := self arguments at: #method ifAbsent: [MicParsingError signal: 'No method argument in <!source... '].
	method := class >> methodName asSymbol.
	^ method sourceCode 
	
]
