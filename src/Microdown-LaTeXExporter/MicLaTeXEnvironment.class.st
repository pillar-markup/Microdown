"
A LaTeX environment

To emit

```
\begin{XXX}
kjlkjkl
\end{XXX}
```
"
Class {
	#name : #MicLaTeXEnvironment,
	#superclass : #MicLaTeXBrush,
	#instVars : [
		'name'
	],
	#category : #'Microdown-LaTeXExporter'
}

{ #category : #accessing }
MicLaTeXEnvironment >> name: aString [
	name := aString.
	stream newLine.
	stream << '\begin{' << aString << '}'
]

{ #category : #accessing }
MicLaTeXEnvironment >> with: aBlock [
	stream newLine.
	aBlock value.
	(stream << '\end{' << name)
		<< '}';
		newLine
]
