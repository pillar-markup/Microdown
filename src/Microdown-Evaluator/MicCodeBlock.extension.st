Extension { #name : 'MicCodeBlock' }

{ #category : '*Microdown-Evaluator' }
MicCodeBlock >> eval: aBoolean [
	
	"the string conversion is due to the fact that the arguments are not converted so normally the parser returns strings and not boolean. 
	This could be changed but it means that the parser (closeMe method), the isEvaluated method and this one should be in sync.
	"
	
	arguments at: #eval put: aBoolean asString

]

{ #category : '*Microdown-Evaluator' }
MicCodeBlock >> evaluate [

	| content |
	content := self evaluationString.
	^ [ (self parserClass parse: content) children ]
		  on: Error
		  do: [ :e |
			  MicBoldFormatBlock new children:
				  { (MicTextBlock new bodyString: e messageText) } ]
]

{ #category : '*Microdown-Evaluator' }
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
						nextPutAll: e description ] ]
]

{ #category : '*Microdown-Evaluator' }
MicCodeBlock >> isEvaluated [ 
	arguments at: #eval ifAbsent: [ ^ false ].
	^ (arguments at: #eval) = 'true'
]
