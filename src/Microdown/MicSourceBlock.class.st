"
I am an extension for including source code into markdown document. I am to be used as:
```text
<!source|class=MicSourceMethodBlock&method=accept:&side=instance!>
```
Yielding:
<!source|class=MicSourceBlock&method=accept:&side=instance!>

The `side` argument can be `instance` or `class`. It can be omitted, and is then assumed to be `instance`.
"
Class {
	#name : 'MicSourceBlock',
	#superclass : 'MicEnvironmentBlock',
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'accessing' }
MicSourceBlock class >> tag [
	^#source
]

{ #category : 'visiting' }
MicSourceBlock >> accept: aVisitor [
	aVisitor visitAll: self children 
]

{ #category : 'parse support' }
MicSourceBlock >> closeMe [
	|builder|
	super closeMe.
	builder := Microdown builder. 
	builder codeblock: self sourceCode firstLineAssociations: { #language -> #Method }.
	self children:  (Microdown parse: builder contents) children.
]

{ #category : 'accessing' }
MicSourceBlock >> sourceCode [

	| className class methodName method|
	methodName := self arguments at: #method ifAbsent: [^ 'No method argument in <!source... '].
	className := self arguments at:  #class ifAbsent: [ ^ 'No class argument in <!source... '].
	class := self class environment at: className asSymbol ifAbsent: [^ 'Unknown class in <!source... ', className].
	((self arguments at: #side ifAbsent: [ 'instance' ]) = 'class')
		ifTrue: [ class := class class ].
	method := class >> methodName asSymbol.
	^ method sourceCode 
	
]
