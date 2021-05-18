Class {
	#name : #MicEnvironmentBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
MicEnvironmentBlockTest >> testEnvironment [
	"'<?card
blbababbab bababba
?>
'" 
	| source root math environmentName |
	environmentName := 'card'.
	source := parser environmentOpeningBlockMarkup , environmentName, String cr, 
	 'blbababbab bababba', String cr,
	parser environmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	math := root children first. 
	self assert: (math isKindOf: MicEnvironmentBlock). 
	self assert: math name equals: environmentName.
	self assert: math body equals: 'blbababbab bababba'
	
]

{ #category : #tests }
MicEnvironmentBlockTest >> testEnvironmentWithAnyNestedElement [
	"'<?card
blbababbab bababba
?>
'" 
	| source root math environmentName |
	environmentName := 'card'.
	source := parser environmentOpeningBlockMarkup , environmentName, String cr, 
	 '- item1 
- item 2

blbababbab bababba', String cr,
	parser environmentClosingBlockMarkup, String cr.
	root :=  parser parse: source.
	
	self assert: root children size equals: 1.
	math := root children first. 
	self assert: (math isKindOf: MicEnvironmentBlock). 
	self assert: math name equals: environmentName.
	
	"sadly enough environment does not accept/parse its body.
	We just get a dull string!!!!
	"
	self flag: #fixme.
	self assert: math body equals: '- item1 
- item 2

blbababbab bababba'
	
]

{ #category : #tests }
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
	source := parser environmentOpeningBlockMarkup, environmentName, parser argumentListStartDelimiter, 'a=1&b=17&c'
		, String cr , contents , String cr
		, parser environmentClosingBlockMarkup , String cr.
	root := parser parse: source.
	self assert: root children size equals: 1.
	environment := root children first.
	self assert: environment name equals: 'card'.
	self assert: (environment arguments at: 'a') equals: '1'.
	self assert: (environment arguments at: 'b') equals: '17'.
	self assert: (environment arguments at: 'c') equals: nil.
]

{ #category : #tests }
MicEnvironmentBlockTest >> testEnvironmentWithMultipleLines [
	"'<?card
blbababbab
bababba

toto
?>
'"
	
	| source root math environmentName contents |
	environmentName := 'card'.
	contents := 'blbababbab
bababba

toto'.
	source := parser environmentOpeningBlockMarkup , environmentName
		, String cr , contents , String cr
		, parser environmentClosingBlockMarkup , String cr.
	root := parser parse: source .
	self assert: root children size equals: 1.
	math := root children first.
	self assert: (math isKindOf: MicEnvironmentBlock).
	self assert: math name equals: environmentName.
	self assert: math body equals: contents
]
