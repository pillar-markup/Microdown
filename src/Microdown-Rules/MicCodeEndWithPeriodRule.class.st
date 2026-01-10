Class {
	#name : 'MicCodeEndWithPeriodRule',
	#superclass : 'MicRule',
	#category : 'Microdown-Rules-Code',
	#package : 'Microdown-Rules',
	#tag : 'Code'
}

{ #category : 'actions' }
MicCodeEndWithPeriodRule >> findLastLinePeriod: methodBody [
    "Retourne l'indice (1-based) de la dernière ligne non vide
    dont le trim se termine par un '.', ou 0 si aucune."

    | lines lastLineIndex |
    lines := methodBody lines.
    lastLineIndex := 0.

    lines withIndexDo: [ :line :index |
        line trim isEmpty not ifTrue: [ lastLineIndex := index ] ].

    lastLineIndex = 0 ifTrue: [ ^ 0 ].

    ((lines at: lastLineIndex) trim endsWith: '.')
        ifTrue: [ ^ lastLineIndex ].

    ^ 0
]
