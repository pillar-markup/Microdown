Class {
	#name : #MicEnvironmentBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> subjectClass [ 
	^ MicEnvironmentBlock  
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironment [
	"'<?card
blbababbab bababba
?>
'" 
	| source root env environmentName |
	environmentName := 'card'.
	source := EnvironmentOpeningBlockMarkup , environmentName, String cr, 
	 'blbababbab bababba', String cr, EnvironmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	env := root children first. 
	self assert: (env isKindOf: MicEnvironmentBlock). 
	self assert: env environmentName equals: environmentName.
	self assert: env children first children first text equals: 'blbababbab bababba'
	
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentClosingNotEatingClosingCharacter [

	
	| root env |
	root := parser parse: '<!card
to

!>'.
	self assert: root children size equals: 1.
	env := root children first.
	self assert: env children first text equals: 'to'.
]

{ #category : #'tests - extensions' }
MicEnvironmentBlockTest >> testEnvironmentIsCreatedWhenTagDoesNotMatch [

	| source root env environmentName |
	environmentName := 'slideXXX'.
	source := EnvironmentOpeningBlockMarkup , environmentName, String cr, 
	 'this is the slide body', String cr, EnvironmentClosingBlockMarkup, String cr.
	
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	env := root children first. 
	self assert: (env isKindOf: MicEnvironmentBlock). 
	self assert: env environmentName equals: environmentName.
	self assert: env children first children first text equals: 'this is the slide body'
	
]

{ #category : #'tests - extensions' }
MicEnvironmentBlockTest >> testEnvironmentWiathArgsWithCorrespondingClassIsCreated [

		| source root environment environmentName contents |
	environmentName := 'slide'.
	contents := 'blbababbab
bababba

toto'.
	source := EnvironmentOpeningBlockMarkup, environmentName, ArgumentListStartDelimiter, 'a=1&b=17&c' , String cr , contents , String cr , EnvironmentClosingBlockMarkup , String cr.
		
	root := parser parse: source.
	self assert: root children size equals: 1.
	environment := root children first.
	self assert: environment environmentName equals: 'slide'.
	self assert: environment class equals: MicSlideBlock.
	self assert: (environment arguments at: 'a') equals: '1'.
	self assert: (environment arguments at: 'b') equals: '17'.
	self assert: (environment arguments at: 'c') equals: nil.
	
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentWithAnyNestedElement [
	"'<?slide
- item 1 
- item 2
?>
'" 
	| source root env environmentName |
	environmentName := 'slide'.
	source := EnvironmentOpeningBlockMarkup , environmentName, String cr, 
	 '- item1 
- item 2

blbababbab bababba', String cr, EnvironmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	
	self assert: root children size equals: 1.
	env := root children first. 
	self assert: (env isKindOf: MicEnvironmentBlock). 
	self assert: env environmentName equals: environmentName.
	
	self assert: env children size equals: 2.
	self assert: env children first class equals: MicUnorderedListBlock.
	self assert: env children first children size equals: 2.
	self assert: env children first children first class equals: MicListItemBlock.
	self assert: env children second class equals: MicParagraphBlock.
	self assert: env children second children first class equals: MicTextBlock2.
	
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentWithArguments [
	 "'<?card|a=1&b=17&c
blbababbab
bababba

toto
?>
'"
	
	| source root environment environmentName contents |
	environmentName := 'card'.
	contents := 'blbababbab
bababba

toto'.
	source := EnvironmentOpeningBlockMarkup, environmentName, ArgumentListStartDelimiter, 'a=1&b=17&c'
		, String cr , contents , String cr
		, EnvironmentClosingBlockMarkup , String cr.
	root := parser parse: source.
	self assert: root children size equals: 1.
	environment := root children first.
	self assert: environment environmentName equals: 'card'.
	self assert: (environment arguments at: 'a') equals: '1'.
	self assert: (environment arguments at: 'b') equals: '17'.
	self assert: (environment arguments at: 'c') equals: nil.
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentWithBrokenMotherNested [
 
	| root |
	root :=  parser parse: '<!slideenvironment

<!script
!>

<!script 

!>

The mother environment is not closed so it will eat everything.
'.
	self assert: root children size equals: 1. 

]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentWithBrokenNestedScript [
 
	| root |
	root :=  parser parse: '<!slideenvironment

```pharoscript

```pharoscript 

!>
'.
	self assert: root children first children first class equals: MicPharoScriptBlock.
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentWithCodeBlock [
 
	| root env |
	root :=  parser parse: '<!slide

This is a nice piece of code
```
1000 factorial /999 factorial
>>> 1000
```
isn''t it
!>
'.
	
	self assert: root children size equals: 1.
	env := root children first. 	
	self assert: env children size equals: 3.
	self assert: env children first class equals: MicParagraphBlock.
	self assert: env children second class equals: MicCodeBlock.
	self assert: env children third class equals: MicParagraphBlock.
	
]

{ #category : #'tests - extensions' }
MicEnvironmentBlockTest >> testEnvironmentWithCorrespondingClassIsCreated [

	| source root env environmentName |
	environmentName := 'slide'.
	source := EnvironmentOpeningBlockMarkup ,  environmentName, String cr, 
	 'this is the slide body', String cr,
	EnvironmentClosingBlockMarkup, String cr.
	
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	env := root children first. 
	self assert: (env isKindOf: MicSlideBlock). 
	self assert: env environmentName equals: environmentName.
	self assert: env children first children first text equals: 'this is the slide body'
	
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentWithFormat [

	"'<?slide
- item 1 
- item 2
?>
'"

	| source root env environmentName |
	environmentName := 'slide'.
	source := EnvironmentOpeningBlockMarkup , environmentName , String cr
	          , '- item1 **bold**
- item 2

blbababbab bababba' , String cr , EnvironmentClosingBlockMarkup
	          , String cr.
	root := parser parse: source.

	self assert: root children size equals: 1.
	env := root children first.

	self
		assert: env children first children first class
		equals: MicListItemBlock.
	self
		assert: env children first children first children second class
		equals: MicBoldFormatBlock2
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentWithMultipleLines [
	"'<?card
blbababbab
bababba

toto
?>
'"
	
	| source root env environmentName contents |
	environmentName := 'card'.
	contents := 'blbababbab
bababba

toto'.
	source := EnvironmentOpeningBlockMarkup , environmentName
		, String cr , contents , String cr
		, EnvironmentClosingBlockMarkup , String cr.
	root := parser parse: source .
	self assert: root children size equals: 1.
	env := root children first.
	self assert: (env isKindOf: MicEnvironmentBlock).
	self assert: env environmentName equals: environmentName.
	self assert: env children size equals: 2.
	self assert: env children first class equals: MicParagraphBlock.
	self assert: env children second class equals: MicParagraphBlock.
	self assert: env children second text equals: 'toto'.
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testEnvironmentWithNoEmptyBeforeTheEndMarker [

	
	| root env |
	root := parser parse: '<!card
Here we are a paragraph and the paragraph should not eat the end of the
environment, else we force writer to enter a new line to declare the end of
the paragraph.
!>'.
	self assert: root children size equals: 1.
	env := root children first.
	self assert: env children first text equals: 'Here we are a paragraph and the paragraph should not eat the end of the
environment, else we force writer to enter a new line to declare the end of
the paragraph.'.
]

{ #category : #'tests - extensions' }
MicEnvironmentBlockTest >> testExtensionClassWithSpaceAndArgIsCreated [

		| source root environment environmentName contents |
	environmentName := ' slide'.
	contents := 'blbababbab
bababba

toto'.
	source := EnvironmentOpeningBlockMarkup, environmentName, ArgumentListStartDelimiter, 'a=1&b=17&c'
		, String cr , contents , String cr
		, EnvironmentClosingBlockMarkup , String cr.
		
	root := parser parse: source.
	self assert: root children size equals: 1.
	environment := root children first.
	self assert: environment environmentName equals: 'slide'.
	self assert: environment class equals: MicSlideBlock.
	self assert: (environment arguments at: 'a') equals: '1'.
	self assert: (environment arguments at: 'b') equals: '17'.
	self assert: (environment arguments at: 'c') equals: nil.
	
]

{ #category : #'tests - better parsing' }
MicEnvironmentBlockTest >> testInputFileOnOneLineWithJunkAfter [

	| mic infileReference |
	mic := parser parse: EnvironmentOpeningBlockMarkup, 'inputFile|path=chapters/withStyle.md', EnvironmentClosingBlockMarkup, String space, 'lkjkljklj'.
	infileReference := mic children first path.
	self assert: infileReference path equals: 'chapters/withStyle.md' 
]

{ #category : #'tests - better parsing' }
MicEnvironmentBlockTest >> testInputFileOnOneLineWithJunkSpaceBeforeEnd [

	| mic infileReference |
	mic := parser parse: EnvironmentOpeningBlockMarkup, 'inputFile|path=chapters/withStyle.md     ', EnvironmentClosingBlockMarkup.
	infileReference := mic children first path.
	self assert: infileReference path equals: 'chapters/withStyle.md'
]

{ #category : #'tests - better parsing' }
MicEnvironmentBlockTest >> testInputFileOnOneLineWithSpaceBeforeJunkAfter [

	| mic infileReference |
	mic := parser parse: EnvironmentOpeningBlockMarkup, 'inputFile|path=chapters/withStyle.md  ', EnvironmentClosingBlockMarkup, String space, 'lkjkljklj'.
	infileReference := mic children first path.
	self assert: infileReference path equals: 'chapters/withStyle.md' 
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testParagraphEnvironmentParagraph [
	| root |
	root := parser parse: 'What a super day for a ride.

<!card
Sunn Special S3

!>

Yes this is a good idea.'.
	
	self assert: root children size equals: 3.
	self assert: root children second children first text equals: 'Sunn Special S3'.
	self assert: root children third text  equals: 'Yes this is a good idea.'.
	

]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testParagraphEnvironmentParagraph2 [
	"This test has a space after ?> '?> ' - was strangely broken at one point in time"
	| root |
	root := parser parse: 
'What a super day for a ride.	
<!card
Sunn Special S3
!> 
Yes this is a good idea.'.
	
	self assert: root children size equals: 3.
	self assert: root children second children first text equals: 'Sunn Special S3'.
	self assert: root children third text  equals: 'Yes this is a good idea.'.
	

]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testParagraphEnvironmentParagraph3 [
	"Text after ?> should be ignored - was strangely broken at one point in time"
	| root |
	root := parser parse: 
'What a super day for a ride.	
<!card
Sunn Special S3
!> Should ignore
Yes this is a good idea.'.
	
	self assert: root children size equals: 3.
	self assert: root children second children first text equals: 'Sunn Special S3'.
	self assert: root children third text  equals: 'Yes this is a good idea.'.
	

]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testSecondScriptShouldNotBeChildOfFirst [
 
	| root |
	root :=  parser parse: '<!slideenvironment

<!script
!>
<!script 
!>
!>
'.

	self assert: 
		root children first "environment" 
		children first "script"
		children isEmpty.
	self assert: 
		root children first "environment" 
		children size equals: 2
]

{ #category : #'tests - default environment' }
MicEnvironmentBlockTest >> testSecondScriptShouldNotBeChildOfFirstWhenClosingOnTheSameLine [
 
	| root |
	root :=  parser parse: '<!slideenvironment

<!script!>
<!script!>

!>
'.

	self assert: 
		root children first "environment" 
		children first "script"
		children isEmpty.
	self assert: 
		root children first "environment" 
		children size equals: 2
]
