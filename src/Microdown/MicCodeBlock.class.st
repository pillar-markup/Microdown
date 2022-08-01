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
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicCodeBlock class >> defaultLanguage [
	^ 'Pharo'
]

{ #category : #visiting }
MicCodeBlock >> accept: aVisitor [
 	^ aVisitor visitCode: self
]

{ #category : #accessing }
MicCodeBlock >> code [
	^ self body
]

{ #category : #handle }
MicCodeBlock >> extractFirstLineFrom: aLine [
	"language=Pharo&label=fig1&caption=La vie est belle"
	"The first tag is language.
	its value is Pharo."
	
	| lineWithoutMarkup|
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	arguments := MicArgumentList 
		split: lineWithoutMarkup.
	^ lineWithoutMarkup
]

{ #category : #testing }
MicCodeBlock >> hasBody [

	^ body isNotEmpty
]

{ #category : #accessing }
MicCodeBlock >> hasLabel [
	^ arguments includesKey: #label

]

{ #category : #testing }
MicCodeBlock >> hasNonDefaultArguments [

	^ 	arguments hasNonDefaultArguments
]

{ #category : #accessing }
MicCodeBlock >> hasNonDefaultLanguage [
	"is the language defined explicitly"
	^ arguments hasNonDefaultValue 
]

{ #category : #initialization }
MicCodeBlock >> initialize [
	super initialize.
	arguments := OrderedDictionary new.
]

{ #category : #accessing }
MicCodeBlock >> label [
	"precondition: receiver hasLabel"
	
	^ arguments at: #label
]

{ #category : #accessing }
MicCodeBlock >> label: aString [

	self arguments at: #label put: aString
]

{ #category : #accessing }
MicCodeBlock >> language [
	^ arguments at: #language ifAbsent: [ '' ]
]

{ #category : #utilities }
MicCodeBlock >> lineStartMarkup [
	"a code block is delimited by ``` "
	
	^ CodeblockMarkup 
]

{ #category : #accessing }
MicCodeBlock >> size [

	"precondition: receiver hasLabel"

	^ arguments at: #size
]
