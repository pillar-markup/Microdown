Class {
	#name : 'MicCheckerHTMLReporter',
	#superclass : 'Object',
	#instVars : [
		'reporter',
		'fileReference',
		'selectedCheckers',
		'checkerResults'
	],
	#category : 'Microdown-BookTester-CheckerDashboard',
	#package : 'Microdown-BookTester',
	#tag : 'CheckerDashboard'
}

{ #category : 'accessing' }
MicCheckerHTMLReporter >> buildHTML [
    ^ String streamContents: [ :s |
        | passedCount errorCount |
        s nextPutAll: '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Microdown Checker Report</title><style>* { box-sizing: border-box; margin: 0; padding: 0; }body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif; background: #f4f6f9; min-height: 100vh; }.wrap { max-width: 1100px; margin: 0 auto; padding: 2.5rem 2rem; }.report-header { background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 1.75rem 2rem; margin-bottom: 2rem; display: flex; flex-direction: row; align-items: center; text-align: left; gap: 1.25rem; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }.report-logo { font-size: 36px; line-height: 1; flex-shrink: 0; }.report-header-text { display: flex; flex-direction: column; gap: 0.4rem; }.report-title { font-size: 22px; font-weight: 700; color: #0f172a; letter-spacing: -0.5px; }.report-subtitle { font-size: 13px; color: #6b3a2a; font-family: monospace; font-weight: 600; background: #fdf6f3; padding: 5px 14px; border-radius: 100px; border: 1px solid #e8c4b0; display: inline-block; }.stats-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 14px; margin-bottom: 2rem; }.stat-card { border-radius: 12px; padding: 1.5rem; background: #ffffff; border: 1px solid #e2e8f0; box-shadow: 0 2px 8px rgba(0,0,0,0.04); position: relative; overflow: hidden; }.stat-card::before { content: ""; position: absolute; top: 0; left: 0; right: 0; height: 3px; }.stat-card.danger::before { background: #dc2626; }.stat-card.success::before { background: #16a34a; }.stat-card.warning::before { background: #7c3a28; }.stat-label { font-size: 11px; color: #65758b; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.8px; font-weight: 700; }.stat-value { font-size: 36px; font-weight: 700; line-height: 1; }.stat-value.danger { color: #dc2626; }.stat-value.success { color: #16a34a; }.stat-value.warning { color: #7c3a28; }.stat-desc { font-size: 12px; color: #65758b; margin-top: 6px; }.section { border-radius: 12px; margin-bottom: 16px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.06); }.section.ok-section { background: #f0fdf4; border: 1px solid #bbf7d0; }.section.err-section { background: #ffffff; border: 2px solid #7c3a28; }.section-header { display: flex; align-items: center; gap: 12px; padding: 1rem 1.5rem; cursor: pointer; user-select: none; }.ok-section .section-header { border-bottom: 1px solid #8db89a; background: #a5cbb1; }.ok-section .section-header:hover { background: #b2d4bc; }.err-section .section-header { background: #9a6d62; border-bottom: 2px solid #7c3a28; }.err-section .section-header:hover { background: #a87b70; }.section-badge { font-size: 11px; font-weight: 700; padding: 4px 12px; border-radius: 100px; flex-shrink: 0; letter-spacing: 0.5px; text-transform: uppercase; }.badge-error { background: #d4a574; color: #2d0f06; border: none; }.badge-ok { background: #ffffff; color: #1e6b3a; border: 1px solid #8db89a; }.section-title { font-size: 14px; font-weight: 700; color: #fdf6f3; flex: 1; }.ok-section .section-title { color: #0f2d1a; }.section-count { font-size: 12px; color: #f0ddd9; font-weight: 600; margin-right: 4px; }.ok-section .section-count { color: #2a5c38; }.chevron { font-size: 10px; color: #f0ddd9; transition: transform 0.2s; display: inline-block; }.ok-section .chevron { color: #2a5c38; }.chevron.open { transform: rotate(180deg); }.ok-row { display: flex; align-items: center; gap: 12px; padding: 0.65rem 1.5rem; border-bottom: 1px solid #d1fae5; }.ok-row:last-child { border-bottom: none; }.ok-dot { width: 20px; height: 20px; background: #16a34a; border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0; color: #ffffff; font-size: 11px; font-weight: 700; }.ok-text { font-size: 13px; color: #166534; font-weight: 500; }.ok-checker { font-weight: 700; }.error-row { padding: 1.25rem 1.5rem; border-bottom: 1px solid #f1f5f9; }.error-row:last-child { border-bottom: none; }.error-row:hover { background: #fdf9f8; }.error-meta { display: flex; align-items: center; gap: 8px; margin-bottom: 10px; flex-wrap: wrap; }.line-badge { font-size: 11px; font-weight: 700; padding: 4px 12px; border-radius: 100px; background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; text-transform: uppercase; letter-spacing: 0.4px; }.file-path { font-size: 13px; font-weight: 700; color: #6b3a2a; font-family: monospace; background: #fdf6f3; padding: 4px 12px; border-radius: 6px; border: 1px solid #e8c4b0; }.error-msg { font-size: 14px; color: #1e293b; line-height: 1.65; margin-bottom: 10px; font-weight: 500; }.error-msg code { background: #f1f5f9; padding: 2px 7px; border-radius: 5px; font-family: monospace; font-size: 12px; color: #6b3a2a; border: 1px solid #e8c4b0; font-weight: 700; }.error-context { background: #cbcbe0; border-radius: 8px; padding: 14px 18px; font-family: monospace; font-size: 13px; color: #090a0f; white-space: pre; overflow-x: auto; border-left: 4px solid #7c3a28; line-height: 2; }.error-context .ln { color: #7a7a99; user-select: none; margin-right: 16px; display: inline-block; min-width: 24px; text-align: right; }.hl { color: #090a0f; font-weight: 700; background: #a8a8c8; padding: 2px 0; display: inline-block; width: 100%; }.hl .ln { color: #784032; }</style></head><body><div class="wrap">'.

        "Header"
        s nextPutAll: '<div class="report-header"><div class="report-logo">&#128196;</div><div class="report-header-text"><div class="report-title">Microdown Checker Report</div><div class="report-subtitle">' , (self htmlEscape: fileReference fullName) , '</div></div></div>'.

    "Stats"
        passedCount := self selectedCheckers count: [ :checkerName |
            | results |
            results := checkerResults at: checkerName ifAbsent: [ #() ].
            results isEmpty ].
        errorCount := self selectedCheckers size - passedCount.
        s nextPutAll: '<div class="stats-grid"><div class="stat-card danger"><div class="stat-label">Total errors</div><div class="stat-value danger">' , reporter results size printString , '</div><div class="stat-desc">issues detected</div></div><div class="stat-card success"><div class="stat-label">Checkers passed</div><div class="stat-value success">' , passedCount printString , '</div><div class="stat-desc">no problems found</div></div><div class="stat-card warning"><div class="stat-label">Checkers with errors</div><div class="stat-value warning">' , errorCount printString , '</div><div class="stat-desc">need attention</div></div></div>'.
        "OK section"
        s nextPutAll: '<div class="section ok-section"><div class="section-header" onclick="toggle(this)"><span class="section-badge badge-ok">&#10003; Passed</span><span class="section-title">Checkers with no problems</span><span class="section-count">' , passedCount printString , ' checkers</span><span class="chevron open">&#9660;</span></div><div class="section-body">'.
        self selectedCheckers do: [ :checkerName |
            | results |
            results := checkerResults at: checkerName ifAbsent: [ #() ].
            results isEmpty ifTrue: [
                s nextPutAll: '<div class="ok-row"><div class="ok-dot">&#10003;</div><span class="ok-text"><span class="ok-checker">' , (self htmlEscape: checkerName) , '</span> &#8212; no problems found</span></div>' ] ].
        s nextPutAll: '</div></div>'.

        "Error sections"
        reporter isOkay ifFalse: [ self buildResultsOn: s ].

        s nextPutAll: '</div><script>function toggle(header){var body=header.nextElementSibling;var chevron=header.querySelector(".chevron");var isOpen=chevron.classList.contains("open");body.style.display=isOpen?"none":"block";chevron.classList.toggle("open",!isOpen);}</script></body></html>' ]
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> buildResultsOn: aStream [
    | grouped |
    grouped := reporter results groupedBy: [ :r | r headerString ].
    grouped keysAndValuesDo: [ :header :errorList |
        | count |
        count := errorList size.
        aStream
            nextPutAll: '<div class="section err-section"><div class="section-header" onclick="toggle(this)"><span class="section-badge badge-error">' , count printString , ' error' , (count = 1 ifTrue: [''] ifFalse: ['s']) , '</span><span class="section-title">' , (self htmlEscape: header) , '</span><span class="chevron open">&#9660;</span></div><div class="section-body">'.
        errorList do: [ :r |
            | lineNum srcFile searchText fullPath shortMsg context |
            srcFile := r sourceFileReference ifNil: [ fileReference ].
            searchText := ((r class methodDict includesKey: #what) and: [ r what notNil and: [ r what notEmpty ] ])
                ifTrue: [ r what ]
                ifFalse: [
                    ((r respondsTo: #micElement) and: [ r micElement notNil ])
                        ifTrue: [
                            (r micElement respondsTo: #bodyString)
                                ifTrue: [ r micElement bodyString lines first trim ]
                                ifFalse: [
                                    (r micElement respondsTo: #text)
                                        ifTrue: [ r micElement text ]
                                        ifFalse: [ '' ] ] ]
                        ifFalse: [ '' ] ].
            lineNum := (srcFile notNil and: [ searchText notEmpty ])
                ifTrue: [ self lineNumberOf: searchText inFile: srcFile ]
                ifFalse: [ 0 ].
            lineNum := lineNum ifNil: [ 0 ].
            fullPath := srcFile notNil ifTrue: [ srcFile fullName ] ifFalse: [ '' ].

            "Extraire uniquement Text: ... depuis r explanation"
            shortMsg := r explanation isString
                ifTrue: [ r explanation ]
                ifFalse: [ r explanation displayString ].
            (shortMsg includesSubstring: 'Text: "') ifTrue: [
                | startIdx endIdx |
                startIdx := shortMsg indexOfSubCollection: 'Text: "' startingAt: 1.
                endIdx := shortMsg indexOf: $" startingAt: startIdx + 7.
                endIdx > 0
                    ifTrue: [ shortMsg := shortMsg copyFrom: startIdx to: endIdx ]
                    ifFalse: [ shortMsg := shortMsg copyFrom: startIdx to: shortMsg size ] ].

            aStream nextPutAll: '<div class="error-row"><div class="error-meta">'.
            lineNum > 0 ifTrue: [
                aStream nextPutAll: '<span class="line-badge">Line ' , lineNum printString , '</span>' ].
            aStream nextPutAll: '<span class="file-path">' , (self htmlEscape: fullPath) , '</span></div><div class="error-msg">' , (self htmlEscape: shortMsg) , '</div>'.
            lineNum > 0 ifTrue: [
                context := self contextAround: lineNum inFile: srcFile.
                aStream nextPutAll: '<div class="error-context">' , (self htmlEscape: context) , '</div>' ].
            aStream nextPutAll: '</div>' ].
        aStream nextPutAll: '</div></div>' ]
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> checkerResults: aDict [

	checkerResults := aDict
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
    "Delete old file first"
    outputFile := fileReference parent / '_result' / 'checker-report.html'.
    outputFile exists ifTrue: [ outputFile delete ].
    outputFile parent ensureCreateDirectory.
    outputFile writeStreamDo: [ :s | s nextPutAll: html ].
    ^ outputFile 
	
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> htmlEscape: anObject [
    | aString result |
    aString := anObject isString
        ifTrue: [ anObject ]
        ifFalse: [ anObject displayString ].
    result := aString copyReplaceAll: '&' with: '&amp;'.
    result := result copyReplaceAll: '<' with: '&lt;'.
    result := result copyReplaceAll: '>' with: '&gt;'.
    result := result copyReplaceAll: '"' with: '&quot;'.
    ^ result
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> lineNumberOf: aString inFile: aFileRef [
	| lines |
	Transcript show: 'searching: '; show: aString printString; cr.
Transcript show: 'in file: '; show: aFileRef fullName; cr.
	(aString isNil or: [aString isEmpty ]) ifTrue: [ ^ 0 ].
	(aFileRef isKindOf: FileReference) ifFalse: [ ^ 0 ].
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

{ #category : 'accessing' }
MicCheckerHTMLReporter >> selectedCheckers [

	^ selectedCheckers
]

{ #category : 'accessing' }
MicCheckerHTMLReporter >> selectedCheckers: aCollection [

	selectedCheckers := aCollection 
]
