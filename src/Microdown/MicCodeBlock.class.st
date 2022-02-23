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
	
	| lineWithoutMarkup argumentsSplitter |
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	argumentsSplitter := MicArgumentsSplitter 
		split: lineWithoutMarkup 
		defaultArg: #language 
		defaultValue: self class defaultLanguage.
	arguments := argumentsSplitter arguments.
	^ lineWithoutMarkup
]

{ #category : #accessing }
MicCodeBlock >> firstTagValue [
	self halt: 'do not use'.
	^ arguments at: self firstTag ifAbsent: [ '' ]
]

{ #category : #testing }
MicCodeBlock >> hasArguments [

	^ arguments keys isNotEmpty
]

{ #category : #testing }
MicCodeBlock >> hasBody [

	^ body isNotEmpty
]

{ #category : #accessing }
MicCodeBlock >> hasFirstTag [
	self halt: 'What is this used for?'.
	^ 'firstTag' isNotEmpty
]

{ #category : #accessing }
MicCodeBlock >> hasLabel [
	^ arguments ifNotEmpty: [ 
		arguments at: #label ifPresent: [ true ] ifAbsent: [ false ]] ifEmpty: [ false ]

]

{ #category : #accessing }
MicCodeBlock >> hasLanguage [
	"Return true whether there is a language = tag used in the arguments."
	^ true
]

{ #category : #testing }
MicCodeBlock >> hasNoBody [

	^ body isEmptyOrNil
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
	^ arguments at: #language
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

{ #category : #accessing }
MicCodeBlock >> text [
	| text |
	self flag: #todo.
	"what a terrible idea we concatenate the text of children and store. 
	I could understand that we keep the text of the parser element but then we do not modify it after
	and certainly not change it."
	text := ''.
	body do: [ :each | text := text , each text ].
	^ text
]
