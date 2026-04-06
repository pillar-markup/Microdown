"
I'm a wrapper of the reporter that generates results in HTML format. 
A possible future for me is 
- to be a subclass or sibling of MicAnalysisReporter
- that checker results produce HTML (may be via a simple double dispatch).
"
Class {
	#name : 'MicCheckerHTMLReporter',
	#superclass : 'Object',
	#instVars : [
		'reporter',
		'fileReference'
	],
	#category : 'Microdown-BookTester-UI',
	#package : 'Microdown-BookTester',
	#tag : 'UI'
}

{ #category : 'accessing' }
MicCheckerHTMLReporter >> buildHTML [
	^ String streamContents: [ :s |
		s nextPutAll: '<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<title>Checker Report</title>
<style>
body { font-family: Arial, sans-serif; margin: 20px; background: #f9f9f9; }
h1 { color: #333; }
h2 { color: #c0392b; border-bottom: 2px solid #e74c3c; padding-bottom: 5px; margin-top: 30px; }
.error { background: #ffe0e0; border-left: 4px solid #e74c3c; padding: 10px; margin: 8px 0; border-radius: 3px; }
.line-num { color: #e74c3c; font-weight: bold; margin-right: 8px; }
.file-ref { color: #888; font-size: 0.85em; display: block; margin-top: 4px; }
.ok { color: #27ae60; font-size: 1.2em; font-weight: bold; padding: 20px; background: #eafaf1; border-radius: 5px; }
.summary { background: #fff; border: 1px solid #ddd; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
</style></head><body>'.
	s nextPutAll: '<h1>Microdown Checker Report</h1>'.
	s nextPutAll: '<div class="summary"'.
	s nextPutAll: '<strong>File:</strong> ' , fileReference fullName , '<br>'.
	s nextPutAll: '<strong>Total errors:</strong> ' , reporter results size printString.
   s nextPutAll: '</div>'.
	reporter isOkay 
		ifTrue: [ s nextPutAll: '<p class="ok">✓ No problems found!</p>' ]
		ifFalse: [ self buildResultsOn: s].
		s nextPutAll: '</body></html>'
		 ]
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> buildResultsOn: aStream [
    | grouped |
    grouped := reporter results groupedBy: [:r | r headerString].
    grouped keysAndValuesDo: [:header :results |
        aStream nextPutAll: '<h2>' , header , '</h2>'.
        results do: [:r |
            | lineNum srcFile searchText |
            srcFile := r sourceFileReference ifNil: [ fileReference ].
            searchText := (r micElement isNil or: [r micElement bodyString isNil])
                ifTrue: [ r detail ifNil: [''] ]
                ifFalse: [ r micElement bodyString ].
            lineNum := (srcFile notNil and: [searchText notEmpty])
                ifTrue: [ self lineNumberOf: searchText inFile: srcFile ]
                ifFalse: [ 0 ].
            aStream nextPutAll: '<div class="error">'.
            lineNum > 0 ifTrue: [
                aStream nextPutAll: '<span class="line-num">Line ' , lineNum printString , ': </span>' ].
            aStream nextPutAll: r explanation.
            lineNum > 0 ifTrue: [
                | context |
                context := self contextAround: lineNum inFile: srcFile.
                aStream nextPutAll: '<pre class="context">' , context , '</pre>' ].
            aStream nextPutAll: '</div>' ] ]
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> contextAround: lineNum inFile: aFileRef [
    | lines start end |
    lines := aFileRef contents lines.
    start := (lineNum - 2) max: 1.
    end := (lineNum + 2) min: lines size.
    ^ String streamContents: [:s |
        start to: end do: [:i |
            i = lineNum
                ifTrue: [ s nextPutAll: '<span class="error-line">' ]
                ifFalse: [ s nextPutAll: '<span>' ].
            s nextPutAll: i printString , ' | ' , (lines at: i).
            s nextPutAll: '</span>'.
            s nextPut: Character lf]]
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> fileReference: aFileReference [

	fileReference := aFileReference 
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> generateReport [
	| html outputFile |
	html := self buildHTML.
	outputFile := fileReference parent / '_result' / 'checker-report.html'.
	outputFile parent ensureCreateDirectory.
	outputFile writeStreamDo: [ :s | s nextPutAll: html ].
	^ outputFile 
	
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> lineNumberOf: aString inFile: aFileRef [
	| lines |
	(aString isNil or: [aString isEmpty ]) ifTrue: [ ^ 0 ].
	aFileRef exists ifFalse: [ ^ 0 ].
	lines := aFileRef readStream contents lines.
		^ lines detectIndex: [ :line |
			line includesSubstring: aString ]
			ifNone: [ 0 ]
			 
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> reporter: aReporter [

	reporter := aReporter 
]
