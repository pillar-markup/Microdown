Class {
	#name : #MicJPEGH5PTemplateWriter2,
	#superclass : #MicH5PTemplateWriter,
	#category : #'Microdown-H5P'
}

{ #category : #'no template' }
MicJPEGH5PTemplateWriter2 >> presentationRawString [
	"STONJSON fromString: self new presentationRawString"
	^ '{"presentation":{"slides":[{"elements":[{"x":0,"y":0,"width":99.99999999999999,"height":100,"action":{"library":"H5P.Image 1.1","params":{"contentName":"Image","file":{"path":"images/image-OE0PKFVx.png","mime":"image/png","copyright":{"license":"U"},"width":310,"height":330}},"subContentId":"5fb6da95-df20-4df0-9de2-aa006c01c08e","metadata":{"contentType":"Image","license":"U","title":"Untitled Image","authors":[],"changes":[]}},"alwaysDisplayComments":false,"backgroundOpacity":0,"displayAsButton":false,"buttonSize":"big","goToSlideType":"specified","invisible":false,"solution":""}],"slideBackgroundSelector":{},"keywords":[{"main":"Nice code eh!"}]}],"keywordListEnabled":true,"globalBackgroundSelector":{},"keywordListAlwaysShow":false,"keywordListAutoHide":false,"keywordListOpacity":100},"override":{"activeSurface":false,"hideSummarySlide":false,"summarySlideSolutionButton":true,"summarySlideRetryButton":true,"enablePrintButton":false,"social":{"showFacebookShare":false,"facebookShare":{"url":"@currentpageurl","quote":"I scored @score out of @maxScore on a task at @currentpageurl."},"showTwitterShare":false,"twitterShare":{"statement":"I scored @score out of @maxScore on a task at @currentpageurl.","url":"@currentpageurl","hashtags":"h5p, course"},"showGoogleShare":false,"googleShareUrl":"@currentpageurl"}},"l10n":{"slide":"Slide","score":"Score","yourScore":"Your Score","maxScore":"Max Score","total":"Total","totalScore":"Total Score","showSolutions":"Show solutions","retry":"Retry","exportAnswers":"Export text","hideKeywords":"Hide sidebar navigation menu","showKeywords":"Show sidebar navigation menu","fullscreen":"Fullscreen","exitFullscreen":"Exit fullscreen","prevSlide":"Previous slide","nextSlide":"Next slide","currentSlide":"Current slide","lastSlide":"Last slide","solutionModeTitle":"Exit solution mode","solutionModeText":"Solution Mode","summaryMultipleTaskText":"Multiple tasks","scoreMessage":"You achieved:","shareFacebook":"Share on Facebook","shareTwitter":"Share on Twitter","shareGoogle":"Share on Google+","summary":"Summary","solutionsButtonTitle":"Show comments","printTitle":"Print","printIngress":"How would you like to print this presentation?","printAllSlides":"Print all slides","printCurrentSlide":"Print current slide","noTitle":"No title","accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.","accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.","containsNotCompleted":"@slideName contains not completed interaction","containsCompleted":"@slideName contains completed interaction","slideCount":"Slide @index of @total","containsOnlyCorrect":"@slideName only has correct answers","containsIncorrectAnswers":"@slideName has incorrect answers","shareResult":"Share Result","accessibilityTotalScore":"You got @score of @maxScore points in total","accessibilityEnteredFullscreen":"Entered fullscreen","accessibilityExitedFullscreen":"Exited fullscreen","confirmDialogHeader":"Submit your answers","confirmDialogText":"This will submit your results, do you want to continue?","confirmDialogConfirmText":"Submit and see results"}}'
]

{ #category : #writing }
MicJPEGH5PTemplateWriter2 >> presentationString [

	^ self presentationStringForCollection: #('foo.png')
]

{ #category : #writing }
MicJPEGH5PTemplateWriter2 >> presentationString2 [
	"STONJSON fromString: self new presentationString2"
	
	^ '{"presentation":{"slides":[', (self slideStringFor: 'foo.png'), '],"keywordListEnabled":true,"globalBackgroundSelector":{},"keywordListAlwaysShow":false,"keywordListAutoHide":false,"keywordListOpacity":100},"override":{"activeSurface":false,"hideSummarySlide":false,"summarySlideSolutionButton":true,"summarySlideRetryButton":true,"enablePrintButton":false,"social":{"showFacebookShare":false,"facebookShare":{"url":"@currentpageurl","quote":"I scored @score out of @maxScore on a task at @currentpageurl."},"showTwitterShare":false,"twitterShare":{"statement":"I scored @score out of @maxScore on a task at @currentpageurl.","url":"@currentpageurl","hashtags":"h5p, course"},"showGoogleShare":false,"googleShareUrl":"@currentpageurl"}},"l10n":{"slide":"Slide","score":"Score","yourScore":"Your Score","maxScore":"Max Score","total":"Total","totalScore":"Total Score","showSolutions":"Show solutions","retry":"Retry","exportAnswers":"Export text","hideKeywords":"Hide sidebar navigation menu","showKeywords":"Show sidebar navigation menu","fullscreen":"Fullscreen","exitFullscreen":"Exit fullscreen","prevSlide":"Previous slide","nextSlide":"Next slide","currentSlide":"Current slide","lastSlide":"Last slide","solutionModeTitle":"Exit solution mode","solutionModeText":"Solution Mode","summaryMultipleTaskText":"Multiple tasks","scoreMessage":"You achieved:","shareFacebook":"Share on Facebook","shareTwitter":"Share on Twitter","shareGoogle":"Share on Google+","summary":"Summary","solutionsButtonTitle":"Show comments","printTitle":"Print","printIngress":"How would you like to print this presentation?","printAllSlides":"Print all slides","printCurrentSlide":"Print current slide","noTitle":"No title","accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.","accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.","containsNotCompleted":"@slideName contains not completed interaction","containsCompleted":"@slideName contains completed interaction","slideCount":"Slide @index of @total","containsOnlyCorrect":"@slideName only has correct answers","containsIncorrectAnswers":"@slideName has incorrect answers","shareResult":"Share Result","accessibilityTotalScore":"You got @score of @maxScore points in total","accessibilityEnteredFullscreen":"Entered fullscreen","accessibilityExitedFullscreen":"Exited fullscreen","confirmDialogHeader":"Submit your answers","confirmDialogText":"This will submit your results, do you want to continue?","confirmDialogConfirmText":"Submit and see results"}}'
]

{ #category : #writing }
MicJPEGH5PTemplateWriter2 >> presentationStringForCollection: aCollection [

	^ '{"presentation":{"slides":[', (self slidesStringForCollection: aCollection), '],"keywordListEnabled":true,"globalBackgroundSelector":{},"keywordListAlwaysShow":false,"keywordListAutoHide":false,"keywordListOpacity":100},"override":{"activeSurface":false,"hideSummarySlide":false,"summarySlideSolutionButton":true,"summarySlideRetryButton":true,"enablePrintButton":false,"social":{"showFacebookShare":false,"facebookShare":{"url":"@currentpageurl","quote":"I scored @score out of @maxScore on a task at @currentpageurl."},"showTwitterShare":false,"twitterShare":{"statement":"I scored @score out of @maxScore on a task at @currentpageurl.","url":"@currentpageurl","hashtags":"h5p, course"},"showGoogleShare":false,"googleShareUrl":"@currentpageurl"}},"l10n":{"slide":"Slide","score":"Score","yourScore":"Your Score","maxScore":"Max Score","total":"Total","totalScore":"Total Score","showSolutions":"Show solutions","retry":"Retry","exportAnswers":"Export text","hideKeywords":"Hide sidebar navigation menu","showKeywords":"Show sidebar navigation menu","fullscreen":"Fullscreen","exitFullscreen":"Exit fullscreen","prevSlide":"Previous slide","nextSlide":"Next slide","currentSlide":"Current slide","lastSlide":"Last slide","solutionModeTitle":"Exit solution mode","solutionModeText":"Solution Mode","summaryMultipleTaskText":"Multiple tasks","scoreMessage":"You achieved:","shareFacebook":"Share on Facebook","shareTwitter":"Share on Twitter","shareGoogle":"Share on Google+","summary":"Summary","solutionsButtonTitle":"Show comments","printTitle":"Print","printIngress":"How would you like to print this presentation?","printAllSlides":"Print all slides","printCurrentSlide":"Print current slide","noTitle":"No title","accessibilitySlideNavigationExplanation":"Use left and right arrow to change slide in that direction whenever canvas is selected.","accessibilityCanvasLabel":"Presentation canvas. Use left and right arrow to move between slides.","containsNotCompleted":"@slideName contains not completed interaction","containsCompleted":"@slideName contains completed interaction","slideCount":"Slide @index of @total","containsOnlyCorrect":"@slideName only has correct answers","containsIncorrectAnswers":"@slideName has incorrect answers","shareResult":"Share Result","accessibilityTotalScore":"You got @score of @maxScore points in total","accessibilityEnteredFullscreen":"Entered fullscreen","accessibilityExitedFullscreen":"Exited fullscreen","confirmDialogHeader":"Submit your answers","confirmDialogText":"This will submit your results, do you want to continue?","confirmDialogConfirmText":"Submit and see results"}}'
]

{ #category : #'no template' }
MicJPEGH5PTemplateWriter2 >> slideString [
	"STONJSON fromString: self new slideString"
	^ '{"elements":[{"x":0,"y":0,"width":100,"height":100,"action":{"library":"H5P.Image 1.1","params":{"contentName":"Image","file":{"path":"images/image-OE0PKFVx.png","mime":"image/png","copyright":{"license":"U"},"width":310,"height":330}},"subContentId":"5fb6da95-df20-4df0-9de2-aa006c01c08e","metadata":{"contentType":"Image","license":"U","title":"Untitled Image","authors":[],"changes":[]}},"alwaysDisplayComments":false,"backgroundOpacity":0,"displayAsButton":false,"buttonSize":"big","goToSlideType":"specified","invisible":false,"solution":""}],"slideBackgroundSelector":{},"keywords":[{"main":"Nice code eh!"}]}'
]

{ #category : #writing }
MicJPEGH5PTemplateWriter2 >> slideStringFor: aString [

	^ '{"elements":[{"x":0,"y":0,"width":100,"height":100,"action":{"library":"H5P.Image 1.1","params":{"contentName":"Image","file":{"path":"images/',aString,'","mime":"image/png","copyright":{"license":"U"},"width":310,"height":330}},"subContentId":"5fb6da95-df20-4df0-9de2-aa006c01c08e","metadata":{"contentType":"Image","license":"U","title":"Untitled Image","authors":[],"changes":[]}},"alwaysDisplayComments":false,"backgroundOpacity":0,"displayAsButton":false,"buttonSize":"big","goToSlideType":"specified","invisible":false,"solution":""}],"slideBackgroundSelector":{},"keywords":[{"main":"Nice code eh!"}]}'
]

{ #category : #writing }
MicJPEGH5PTemplateWriter2 >> slidesStringForCollection: aCollection [

	^ String streamContents: [ :st | 
		aCollection 
			do: [ :each | st nextPutAll: (self slideStringFor: each)  ]
			separatedBy: [ st nextPutAll:',' ]
		 ]

]

{ #category : #writing }
MicJPEGH5PTemplateWriter2 >> writeContentJSONOnDisk: aMicDocument [
	"self new writeContentJSONOnDisk: 2"
	 '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/pharo-Template-withVariableNames2/content/content.json' asFileReference ensureDelete.
	 '/Users/ducasse/Workspace/FirstCircle/MyBooks/Bk-Writing/AdvancedOODesign/h5p/pharo-Template-withVariableNames2/content/content.json' asFileReference 
		writeStreamDo: [ :str | str nextPutAll: (self presentationString2) ]
]
