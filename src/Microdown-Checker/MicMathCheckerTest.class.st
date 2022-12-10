Class {
	#name : #MicMathCheckerTest
	#superclass : #TestCase,
	#category : #'Microdown-Checker'
}

{ #category : #private }
MicCodeblockEvaluatorTest >> actualClass [
	^ MicCodeblockEvaluator 
]

{ #category : #tests }
MicMathCheckerTest >> testIsOkWithCorrectExpression
	|expression mic|
	
	expression := Microdown parse: '
	$$
	\frac{A}{B}
	$$'.
	mic := MicMathChecker new visitMath: expression.
	self assert: (mic errors size) equals: 0.
]

{ #category : #tests }
MicMathCheckerTest >> testIsOkWithWrongExpression
	|expression mic|
	
	expression := Microdown parse: '
	$
	\frac{A}{B
	$$'.
	mic := MicMathChecker new visitMath: expression.
	self assert: (mic errors size) equals: 1.
]
}
