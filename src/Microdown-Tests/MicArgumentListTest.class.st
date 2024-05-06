"
A MicArgumentsSplitterTest is a test class for testing the behavior of MicArgumentList.
This list is used in figures, code, and math equation for now

In the following anchor=fig1&width=70 is an argument list.
```
![this is a caption](figures/f.png anchor=fig1&width=70)
```
"
Class {
	#name : 'MicArgumentListTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'helpers' }
MicArgumentListTest >> splitter [
	^ MicArgumentList
]

{ #category : 'helpers' }
MicArgumentListTest >> subjectUnderTestWith: aString [
	^ MicArgumentList withString: aString 
]

{ #category : 'tests' }
MicArgumentListTest >> testArguments [
	| subject |
	subject := self subjectUnderTestWith: 'foo=bar'.
	self assert: (subject at: #foo) equals: 'bar'
]

{ #category : 'tests' }
MicArgumentListTest >> testArgumentsForMath [
	| subject |
	subject := self subjectUnderTestWith: '%foo=bar'.
	self assert: (subject at: #foo) equals: 'bar'.
	
	subject := self subjectUnderTestWith: ' %foo=bar'.
	self assert: (subject at: #foo) equals: 'bar'.
	
	subject := self subjectUnderTestWith: ' % foo=bar'.
	self assert: (subject at: #foo) equals: 'bar'.
]

{ #category : 'tests' }
MicArgumentListTest >> testCanInstantiate [
	| subject |
	subject := self subjectUnderTestWith: 'bla'.
	self assert: (subject isNotNil)
]

{ #category : 'tests' }
MicArgumentListTest >> testDefaultWithEmptyInput [
	| subject |
	subject := self splitter split: '' defaultArg: #language defaultValue: 'smalltalk'.
	self assert: subject size equals: 1.
	self assert: subject keys first equals: #language.
	self assert: (subject at: #language) equals: 'smalltalk'.
	self deny: subject hasNonDefaultArguments 
]

{ #category : 'tests' }
MicArgumentListTest >> testDefaultWithNoValue [
	| subject |
	subject := self splitter split: 'pharo' defaultArg: #language.
	self assert: subject size equals: 1.
	self assert: subject keys first equals: #language.
	self assert: (subject at: #language) equals: 'pharo'
]

{ #category : 'tests' }
MicArgumentListTest >> testDefaultWithValue [
	| subject |
	subject := self splitter split: 'pharo' defaultArg: #language defaultValue: #smalltalk.
	self assert: subject size equals: 1.
	self assert: subject keys first equals: #language.
	self assert: (subject at: #language) equals: 'pharo'
]

{ #category : 'tests' }
MicArgumentListTest >> testEmpty [
	| subject |
	subject := self subjectUnderTestWith: ''.
	self assert: subject size equals: 0.
]

{ #category : 'tests' }
MicArgumentListTest >> testFirstTag [
	| subject |
	subject := self subjectUnderTestWith: 'bla'.
	self assert: (subject defaultValue) equals: 'bla'
]

{ #category : 'tests' }
MicArgumentListTest >> testFirstTagWithDelimiter [
	| subject |
	subject := self subjectUnderTestWith: 'foo|bar=99'.
	self assert: (subject defaultValue) equals: 'foo'
]

{ #category : 'tests' }
MicArgumentListTest >> testHasNonDefaultArguments [
	| subject |
	subject := self splitter split: '' defaultArg: #language.
	subject at: #foo put: 'bar'.
	self assert: subject hasNonDefaultArguments 
]

{ #category : 'tests' }
MicArgumentListTest >> testHasNonDefaultArguments_no [
	| subject |
	subject := self splitter split: '' defaultArg: #language.
	self deny: subject hasNonDefaultArguments 
]

{ #category : 'tests' }
MicArgumentListTest >> testHasNonDefaultArguments_nonDefault [
	| subject |
	subject := self splitter split: '' defaultArg: #language defaultValue: 'Pharo'.
	subject at: #language put: 'Fortran'.
	self assert: subject hasNonDefaultArguments 
]

{ #category : 'tests' }
MicArgumentListTest >> testHasNonDefaultValue [
	| subject |
	subject := self splitter split: 'fortran' defaultArg: #language.
	self assert: subject hasNonDefaultValue
]

{ #category : 'tests' }
MicArgumentListTest >> testHasNonDefaultValue_AndSomeArgs [
	| subject |
	subject := self splitter split: 'fortran|wasOnce=cool' defaultArg: #language.
	self assert: subject hasNonDefaultValue
]

{ #category : 'tests' }
MicArgumentListTest >> testHasNonDefaultValue_Default [
	| subject |
	subject := self splitter split: '' defaultArg: #language defaultValue: 'pharo'.
	self deny: subject hasNonDefaultValue
]

{ #category : 'tests' }
MicArgumentListTest >> testHasNonDefaultValue_DefaultOverridden [
	| subject |
	subject := self splitter split: 'fortran' defaultArg: #language defaultValue: 'pharo'.
	self assert: subject hasNonDefaultValue
]

{ #category : 'tests' }
MicArgumentListTest >> testHasNonDefaultValue_NoDefault [
	| subject |
	subject := self splitter split: '' defaultArg: #language.
	self deny: subject hasNonDefaultValue
]

{ #category : 'tests' }
MicArgumentListTest >> testJustTheArguments [
	| subject input |
	input := 'joe|foo=bar&aaa=bbb ccc&pip='.
	subject := self splitter split: input defaultArg: #personName.
	self assert: subject justTheArguments printString equals: 'foo=bar&aaa=bbb ccc&pip='
]

{ #category : 'tests' }
MicArgumentListTest >> testJustTheArguments_NoDefault [
	| subject input |
	input := 'foo=bar&aaa=bbb ccc&pip='.
	subject := self splitter split: input defaultArg: #personName.
	self assert: subject justTheArguments printString equals: 'foo=bar&aaa=bbb ccc&pip='
]

{ #category : 'tests' }
MicArgumentListTest >> testNameAndArguments [
	| subject |
	subject := self subjectUnderTestWith: 'aName|foo=bar'.
	self assert: (subject includesKey: #foo).
	self assert: subject defaultValue equals: 'aName'.
]

{ #category : 'tests' }
MicArgumentListTest >> testNameWithDelimiter [
	| subject |
	subject := self subjectUnderTestWith: 'fooName|bar=foe'.
	self assert: (subject defaultValue) equals: 'fooName'
]

{ #category : 'tests' }
MicArgumentListTest >> testPrintString [
	| subject input |
	input := 'joe|foo=bar&aaa=bbb ccc&pip='.
	subject := self splitter split: input defaultArg: #personName.
	self assert: subject printString equals: input
]

{ #category : 'tests' }
MicArgumentListTest >> testPrintString_AssignDefaultUsingEquals [
	| subject input |
	input := 'language=fortran'.
	subject := self splitter split: input defaultArg: 'language'.
	self assert: subject printString equals: 'fortran'
]

{ #category : 'tests' }
MicArgumentListTest >> testPrintString_Empty [
	| subject input |
	input := ''.
	subject := self splitter split: input.
	self assert: subject printString equals: input
]

{ #category : 'tests' }
MicArgumentListTest >> testPrintString_defaultValue [
	| subject input |
	input := 'foo'.
	subject := self splitter split: input.
	self assert: subject printString equals: input
]

{ #category : 'tests' }
MicArgumentListTest >> testPrintString_oneParam [
	| subject input |
	input := 'foo=bar'.
	subject := self splitter split: input.
	self assert: subject printString equals: input
]

{ #category : 'tests' }
MicArgumentListTest >> testPrintString_onlyParams [
	| subject input |
	input := 'foo=bar&a=b'.
	subject := self splitter split: input.
	self assert: subject printString equals: input
]

{ #category : 'tests' }
MicArgumentListTest >> testSeveralArguments [
	| subject |
	subject := self subjectUnderTestWith: 'foo=bar&caption=this is lovely&aaa=99'.
	self assert: subject size equals: 3.
	self assert: (subject at: #foo) equals: 'bar'.
	self assert: (subject at: #caption) equals: 'this is lovely'.
	self assert: (subject values last) equals: '99'
]
