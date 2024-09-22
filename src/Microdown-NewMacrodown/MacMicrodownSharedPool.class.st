"
I do not know how to integrate the new delimiter in a modular way because 

```
MicInlineDelimiter class >> initializeDelimiters

	self = MicInlineDelimiter ifFalse: [ ^ self ].
	DelimiterDictionary := Dictionary new.
	self allSubclasses do: [ :class | class initializeDelimiters ]
```

is basically doing is currently taking all the different subclasses. 

The solution would be to have an explicit registration so that we can say
`MicInlineDelimiter useStandard` or `useExtendedSets`.

This has to be done if there is an interest.
"
Class {
	#name : 'MacMicrodownSharedPool',
	#superclass : 'SharedPool',
	#classVars : [
		'InlineParagraphDelimiter'
	],
	#category : 'Microdown-NewMacrodown',
	#package : 'Microdown-NewMacrodown'
}

{ #category : 'class initialization' }
MacMicrodownSharedPool class >> initialize [ 

	InlineParagraphDelimiter := '  '.
]
