Extension { #name : #MicCodeBlock }

{ #category : #'*Microdown-Evaluator' }
MicCodeBlock >> eval: aString [

	self flag: #tofix.
	"I do not get what is the use of this method."
	arguments at: 'eval' put: aString
]

{ #category : #'*Microdown-Evaluator' }
MicCodeBlock >> evaluate [

	| content |
	content := self evaluationString.
	^ [ (MicAbstractBlock new parserClass new parse: content) children ]
		on: Error
		do: [ :e | MicBoldFormatBlock new children: { (MicTextBlock new substring: e messageText) } ]
]

{ #category : #'*Microdown-Evaluator' }
MicCodeBlock >> evaluationString [
	^ String
		streamContents: [ :stream | 
			| evaluator |
			evaluator := MicCodeblockEvaluatorEnv new
				setStream: stream;
				yourself.
			[ self class compiler
				source: self body;
				logged: false;
				receiver: evaluator;
				evaluate ]
				on: Error
				do: [ :e | 
					stream
						nextPutAll: '= ';
						nextPutAll: e description ] ]
]
