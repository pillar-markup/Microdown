Class {
	#name : #MdsInlineParserTest,
	#superclass : #MicInlineParserTest,
	#category : #'Microdown-MarkdownStrict-Tests'
}

{ #category : #accessing }
MdsInlineParserTest >> splitter [

	^ MdsInlineParser new
]

{ #category : #tests }
MdsInlineParserTest >> testParseLineBreak [
	| blocks |

	blocks := self splitter parse: 'x1  
x2
'.

	self assert: blocks size equals: 3.
	self assert: blocks second class equals: MdsLineBreakBlock
]

{ #category : #tests }
MdsInlineParserTest >> testParseLineBreakManySpaces [
	| blocks |

	blocks := self splitter parse: 'a     
b
'.

	self assert: blocks size equals: 3.
	self assert: blocks second class equals: MdsLineBreakBlock
]
