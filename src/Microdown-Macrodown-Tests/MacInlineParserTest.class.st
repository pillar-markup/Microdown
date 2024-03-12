Class {
	#name : 'MacInlineParserTest',
	#superclass : 'MicInlineParserTest',
	#category : 'Microdown-Macrodown-Tests',
	#package : 'Microdown-Macrodown-Tests'
}

{ #category : 'accessing' }
MacInlineParserTest >> splitter [

	^ MacInlineParser new
]

{ #category : 'tests' }
MacInlineParserTest >> testParseLineBreak [
	| blocks |

	blocks := self splitter parse: 'x1  
x2
'.

	self assert: blocks size equals: 3.
	self assert: blocks second class equals: MacLineBreakBlock
]

{ #category : 'tests' }
MacInlineParserTest >> testParseLineBreakManySpaces [
	| blocks |

	blocks := self splitter parse: 'a     
b
'.

	self assert: blocks size equals: 3.
	self assert: blocks second class equals: MacLineBreakBlock
]
