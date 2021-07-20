"
I am a code block. I look like this, starting and ending with three $`
my 'arguments' is just the text from the fourth character up to the end of line.

```
 ```arguments
 line 1
 line 2
 line 3
 ``` 
```

A codeblock does not interpreter its contents. 
You can however specify different tag and multiple argument. 

```
	```language=pharo|caption=A method&label=method 
	pharoMotto 
		^ 'Doing something every is the best way to make progress'
	```
```


For now we do not support the use of multiple backticks. The markup is only 3 backticks. If you want to embed codeblock inside codeblock you must use an extra space. 

```
 ```
  ```
  A nested codeblock
  ```
 ```
```

#### Implementation thoughts
The current implementation stores lines in a single text and this is a bad idea because first what if the user use lf in his text!
Second if we want to treat lines separatedly we have to reparse it. Now we do not need it so this is good but this is just by chance!
"
Class {
	#name : #MicCodeBlock,
	#superclass : #MicSameStartStopMarkupBlock,
	#instVars : [
		'firstTag'
	],
	#category : #'Microdown-Evaluator'
}

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
				source: self text;
				logged: false;
				receiver: evaluator;
				evaluate ]
				on: Error
				do: [ :e | 
					stream
						nextPutAll: '= ';
						nextPutAll: e description ] ]
]
